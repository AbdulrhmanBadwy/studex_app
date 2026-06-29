import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:go_router/go_router.dart';
import 'package:studex_graduation_project/core/theme/app_styles.dart';
import 'package:studex_graduation_project/core/widgets/spacing.dart';
import 'package:studex_graduation_project/core/routes/app_routes.dart';
import 'package:studex_graduation_project/models/room_model.dart';
import 'package:studex_graduation_project/repositories/room_repository.dart';
import 'package:studex_graduation_project/features/rooms/widgets/custom_create_room_button.dart';
import 'package:studex_graduation_project/features/rooms/widgets/custom_text_form_field.dart';

import '../widgets/custom_headline_create_room.dart';

class CreateRoom extends StatefulWidget {
  const CreateRoom({super.key});

  @override
  State<CreateRoom> createState() => _CreateRoomState();
}

class _CreateRoomState extends State<CreateRoom> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  final RoomRepository _roomRepository = FirestoreRoomRepository();
  bool _isLoading = false;

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  Future<void> _createRoom() async {
    if (_formKey.currentState?.validate() != true) return;

    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('You must be signed in to create a room.')),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      await _roomRepository.createRoom(
        RoomModel(
          id: '',
          name: _nameController.text.trim(),
          description: _descriptionController.text.trim(),
          type: 'public',
          creatorId: currentUser.uid,
          members: [currentUser.uid],
        ),
      );

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Room created successfully')),
      );
      context.go(AppRoutes.roomListScreen);
    } on FirebaseException catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.message ?? 'Failed to create room.')),
      );
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.toString())),
      );
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF8F6F6),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomHeadlineCreateRoom(
                    title: 'إنشاء غرفة جديدة',
                    onPressed: () {
                      context.pop();
                    },
                  ),
                  const HeightSpacing(18),
                  Text(
                    'اسم الغرفة',
                    style: AppStyles.bold16black.copyWith(
                      fontFamily: 'AbdoMaster',
                    ),
                  ),
                  const HeightSpacing(8),
                  CustomTextFormField(
                    controller: _nameController,
                    hintText: 'مثال : جروب فرقة تالته حساسبات ومعلومات',
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Room name is required';
                      }
                      return null;
                    },
                  ),
                  const HeightSpacing(24),
                  Text(
                    'وصف مختصر',
                    style: AppStyles.bold16black.copyWith(
                      fontFamily: 'AbdoMaster',
                    ),
                  ),
                  const HeightSpacing(8),
                  CustomTextFormField(
                    controller: _descriptionController,
                    hintText: 'ما هو الهدف من هذه الغرفة ؟',
                    heigh: 150,
                    maxLines: null,
                  ),
                  const HeightSpacing(32),
                  CustomCreateRoomButton(
                    onPressed: _createRoom,
                    text: 'إنشاء الغرفة',
                    isLoading: _isLoading,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
