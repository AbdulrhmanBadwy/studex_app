import 'package:meta/meta.dart';
import 'package:studex_graduation_project/features/quiz/domain/entites/quiz_entity.dart';
import 'package:studex_graduation_project/models/user_model.dart';
import 'package:studex_graduation_project/models/room_model.dart';

enum HomeSectionStatus {
  loading,
  loaded,
  empty,
  error,
  noRoomsJoined,
  noQuizzesYet,
}

@immutable
class HomeState {
  final UserModel? currentUser;
  final List<RoomModel> joinedRooms;
  final List<RoomModel> availableRooms;
  final HomeSectionStatus roomsStatus;
  final String? roomsErrorMessage;
  final HomeSectionStatus taskStatus;
  final QuizEntity? latestQuiz;
  final String? latestQuizRoomId;
  final int participantsCount;
  final int totalQuizzesCount;
  final int completedQuizzesCount;
  final int uncompletedQuizzesCount;
  final String? taskMessage;

  const HomeState({
    this.currentUser,
    this.joinedRooms = const [],
    this.availableRooms = const [],
    this.roomsStatus = HomeSectionStatus.loading,
    this.roomsErrorMessage,
    this.taskStatus = HomeSectionStatus.loading,
    this.latestQuiz,
    this.latestQuizRoomId,
    this.participantsCount = 0,
    this.totalQuizzesCount = 0,
    this.completedQuizzesCount = 0,
    this.uncompletedQuizzesCount = 0,
    this.taskMessage,
  });

  HomeState copyWith({
    UserModel? currentUser,
    bool clearCurrentUser = false,
    List<RoomModel>? joinedRooms,
    List<RoomModel>? availableRooms,
    HomeSectionStatus? roomsStatus,
    String? roomsErrorMessage,
    bool clearRoomsErrorMessage = false,
    HomeSectionStatus? taskStatus,
    QuizEntity? latestQuiz,
    String? latestQuizRoomId,
    int? participantsCount,
    int? totalQuizzesCount,
    int? completedQuizzesCount,
    int? uncompletedQuizzesCount,
    String? taskMessage,
    bool clearTaskMessage = false,
  }) {
    return HomeState(
      currentUser: clearCurrentUser ? null : (currentUser ?? this.currentUser),
      joinedRooms: joinedRooms ?? this.joinedRooms,
      availableRooms: availableRooms ?? this.availableRooms,
      roomsStatus: roomsStatus ?? this.roomsStatus,
      roomsErrorMessage: clearRoomsErrorMessage
          ? null
          : (roomsErrorMessage ?? this.roomsErrorMessage),
      taskStatus: taskStatus ?? this.taskStatus,
      latestQuiz: latestQuiz ?? this.latestQuiz,
      latestQuizRoomId: latestQuizRoomId ?? this.latestQuizRoomId,
      participantsCount: participantsCount ?? this.participantsCount,
      totalQuizzesCount: totalQuizzesCount ?? this.totalQuizzesCount,
      completedQuizzesCount:
          completedQuizzesCount ?? this.completedQuizzesCount,
      uncompletedQuizzesCount:
          uncompletedQuizzesCount ?? this.uncompletedQuizzesCount,
      taskMessage: clearTaskMessage ? null : (taskMessage ?? this.taskMessage),
    );
  }
}
