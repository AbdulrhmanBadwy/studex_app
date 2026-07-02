import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:studex_graduation_project/core/services/auth_service.dart';
import 'package:studex_graduation_project/features/homescreen/cubit/home_state.dart';
import 'package:studex_graduation_project/features/quiz/data/models/quiz_model.dart';
import 'package:studex_graduation_project/features/quiz/domain/entites/quiz_entity.dart';
import 'package:studex_graduation_project/models/room_model.dart';
import 'package:studex_graduation_project/repositories/room_repository.dart';
import 'package:studex_graduation_project/repositories/user_repository.dart';

class HomeCubit extends Cubit<HomeState> {
  final RoomRepository _roomRepository;
  final UserRepository _userRepository;
  StreamSubscription<List<RoomModel>>? _roomsSubscription;
  final List<StreamSubscription<QuerySnapshot<Map<String, dynamic>>>>
  _quizSubscriptions = [];
  final Map<String, QuizEntity> _joinedQuizzesByKey = {};
  final Set<String> _completedQuizKeys = {};
  Set<String> _joinedRoomIds = {};

  HomeCubit(this._roomRepository, {UserRepository? userRepository})
    : _userRepository = userRepository ?? FirestoreUserRepository(),
      super(
        const HomeState(
          roomsStatus: HomeSectionStatus.loading,
          taskStatus: HomeSectionStatus.loading,
        ),
      );

  Future<void> loadRecentChats() async {
    _roomsSubscription?.cancel();
    _cancelQuizSubscriptions();
    _joinedQuizzesByKey.clear();
    _completedQuizKeys.clear();
    _joinedRoomIds = {};

    final currentUser = AuthService.instance.currentUser;
    if (currentUser == null) {
      emit(
        state.copyWith(
          roomsStatus: HomeSectionStatus.error,
          roomsErrorMessage: 'You must be signed in to view recent chats.',
          taskStatus: HomeSectionStatus.error,
          taskMessage: 'You must be signed in to view your tasks.',
          latestQuiz: null,
          latestQuizRoomId: null,
          participantsCount: 0,
          totalQuizzesCount: 0,
          completedQuizzesCount: 0,
          uncompletedQuizzesCount: 0,
        ),
      );
      return;
    }

    emit(
      state.copyWith(
        roomsStatus: HomeSectionStatus.loading,
        taskStatus: HomeSectionStatus.loading,
        clearRoomsErrorMessage: true,
        clearTaskMessage: true,
      ),
    );

    final profile = await _userRepository.getCurrentUser(currentUser.uid);
    emit(state.copyWith(currentUser: profile ?? currentUser));

    _roomsSubscription = _roomRepository.getRooms().listen(
      (rooms) {
        final joinedRooms = _sortRooms(
          rooms
              .where((room) => room.members.contains(currentUser.uid))
              .toList(),
        );
        final availableRooms = _sortRooms(
          rooms
              .where((room) => !room.members.contains(currentUser.uid))
              .toList(),
        );

        if (joinedRooms.isEmpty) {
          _cancelQuizSubscriptions();
          _joinedQuizzesByKey.clear();
          _completedQuizKeys.clear();
          emit(
            state.copyWith(
              joinedRooms: joinedRooms,
              availableRooms: availableRooms,
              roomsStatus: rooms.isEmpty
                  ? HomeSectionStatus.empty
                  : HomeSectionStatus.loaded,
              taskStatus: HomeSectionStatus.noRoomsJoined,
              latestQuiz: null,
              latestQuizRoomId: null,
              participantsCount: 0,
              totalQuizzesCount: 0,
              completedQuizzesCount: 0,
              uncompletedQuizzesCount: 0,
              taskMessage:
                  'لسه منضمش لأي غرفة، انضم لغرفة الأول عشان تشوف مهامك',
            ),
          );
          return;
        }

        emit(
          state.copyWith(
            joinedRooms: joinedRooms,
            availableRooms: availableRooms,
            roomsStatus: rooms.isEmpty
                ? HomeSectionStatus.empty
                : HomeSectionStatus.loaded,
            clearRoomsErrorMessage: true,
          ),
        );
        _subscribeToJoinedRoomQuizzes(joinedRooms, currentUser.uid);
      },
      onError: (error) {
        emit(
          state.copyWith(
            roomsStatus: HomeSectionStatus.error,
            roomsErrorMessage: error.toString(),
          ),
        );
      },
    );
  }

  List<RoomModel> _sortRooms(List<RoomModel> rooms) {
    rooms.sort((left, right) {
      final leftTime = left.lastMessageAt ?? left.createdAt;
      final rightTime = right.lastMessageAt ?? right.createdAt;
      if (leftTime == null && rightTime == null) {
        return 0;
      }
      if (leftTime == null) {
        return 1;
      }
      if (rightTime == null) {
        return -1;
      }
      return rightTime.compareTo(leftTime);
    });
    return rooms;
  }

  void _subscribeToJoinedRoomQuizzes(List<RoomModel> rooms, String userId) {
    _cancelQuizSubscriptions();
    _joinedQuizzesByKey.clear();
    _completedQuizKeys.clear();
    _joinedRoomIds = rooms
        .map((room) => room.id)
        .where((id) => id.isNotEmpty)
        .toSet();

    if (_joinedRoomIds.isEmpty) {
      emit(
        state.copyWith(
          taskStatus: HomeSectionStatus.noRoomsJoined,
          latestQuiz: null,
          latestQuizRoomId: null,
          participantsCount: 0,
          totalQuizzesCount: 0,
          completedQuizzesCount: 0,
          uncompletedQuizzesCount: 0,
          taskMessage: 'لسه منضمش لأي غرفة، انضم لغرفة الأول عشان تشوف مهامك',
        ),
      );
      return;
    }

    _quizSubscriptions.add(
      FirebaseFirestore.instance
          .collectionGroup('quizzes')
          .snapshots()
          .listen(
            (QuerySnapshot<Map<String, dynamic>> snapshot) {
              _joinedQuizzesByKey.clear();

              for (final doc in snapshot.docs) {
                final data = doc.data();
                final roomId = data['roomId'] as String? ?? '';
                if (!_joinedRoomIds.contains(roomId)) {
                  continue;
                }

                final quiz = QuizModel.fromJson({
                  ...data,
                  'id': data['id'] ?? doc.id,
                });
                _joinedQuizzesByKey[_quizKey(roomId, quiz.id)] = quiz;
              }

              _emitLatestQuizState();
              _emitQuizCounts();
            },
            onError: (error) {
              emit(
                state.copyWith(
                  taskStatus: HomeSectionStatus.error,
                  taskMessage: error.toString(),
                ),
              );
            },
          ),
    );

    _quizSubscriptions.add(
      FirebaseFirestore.instance
          .collectionGroup('results')
          .snapshots()
          .listen(
            (QuerySnapshot<Map<String, dynamic>> snapshot) {
              _completedQuizKeys.clear();

              for (final doc in snapshot.docs) {
                final data = doc.data();
                if ((data['userId'] as String?) != userId) {
                  continue;
                }

                final segments = doc.reference.path.split('/');
                if (segments.length < 6) {
                  continue;
                }

                final roomId = segments[1];
                final quizId = segments[3];
                if (!_joinedRoomIds.contains(roomId)) {
                  continue;
                }

                _completedQuizKeys.add(_quizKey(roomId, quizId));
              }

              _emitQuizCounts();
            },
            onError: (error) {
              emit(
                state.copyWith(
                  taskStatus: HomeSectionStatus.error,
                  taskMessage: error.toString(),
                ),
              );
            },
          ),
    );
  }

  QuizEntity? _latestQuizFromList(List<QuizEntity> quizzes) {
    if (quizzes.isEmpty) {
      return null;
    }

    quizzes.sort((left, right) {
      final leftTime = left.createdAt;
      final rightTime = right.createdAt;
      if (leftTime == null && rightTime == null) {
        return 0;
      }
      if (leftTime == null) {
        return 1;
      }
      if (rightTime == null) {
        return -1;
      }
      return rightTime.compareTo(leftTime);
    });

    return quizzes.first;
  }

  void _emitQuizCounts() {
    final totalCount = _joinedQuizzesByKey.length;
    final completedCount = _joinedQuizzesByKey.keys
        .where(_completedQuizKeys.contains)
        .length;

    emit(
      state.copyWith(
        totalQuizzesCount: totalCount,
        completedQuizzesCount: completedCount,
        uncompletedQuizzesCount: totalCount - completedCount,
      ),
    );
  }

  void _emitLatestQuizState() {
    final quizzes = _joinedQuizzesByKey.values.toList();
    if (quizzes.isEmpty) {
      emit(
        state.copyWith(
          taskStatus: HomeSectionStatus.noQuizzesYet,
          latestQuiz: null,
          latestQuizRoomId: null,
          participantsCount: 0,
          taskMessage: 'مفيش اختبارات لسه في غرفك',
        ),
      );
      return;
    }

    final latestQuiz = _latestQuizFromList(quizzes);
    if (latestQuiz == null) {
      return;
    }

    emit(
      state.copyWith(
        taskStatus: HomeSectionStatus.loaded,
        latestQuiz: latestQuiz,
        latestQuizRoomId: latestQuiz.roomId,
        participantsCount: latestQuiz.resultsCount,
        clearTaskMessage: true,
      ),
    );
  }

  String _quizKey(String roomId, String quizId) => '$roomId::$quizId';

  void _cancelQuizSubscriptions() {
    for (final subscription in _quizSubscriptions) {
      subscription.cancel();
    }
    _quizSubscriptions.clear();
  }

  @override
  Future<void> close() async {
    await _roomsSubscription?.cancel();
    _cancelQuizSubscriptions();
    return super.close();
  }
}
