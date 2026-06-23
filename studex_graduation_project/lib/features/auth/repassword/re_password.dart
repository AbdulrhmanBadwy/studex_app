import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:studex_graduation_project/core/constants/assets_paths.dart';
import 'package:studex_graduation_project/core/theme/app_colors.dart';

import '../../../core/theme/app_styles.dart';
import 'package:studex_graduation_project/core/routes/app_routes.dart';
import '../../widgets/custom_botton.dart';
import '../../widgets/custom_text_form_field.dart';

class RePassword extends StatefulWidget {
  const RePassword({super.key});

  @override
  State<RePassword> createState() => _RePasswordState();
}

class _RePasswordState extends State<RePassword> {
  final formKey = GlobalKey<FormState>();

  TextEditingController emailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: AppBar(backgroundColor: AppColors.whiteColor, title: Text('')),
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 60, horizontal: 30),
        child: Center(
          child: Column(
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset(AssetsPaths.logoRePassword),
              SizedBox(height: 15),
              Text(
                'Did you forget your password?',
                style: AppStyles.bold20black,
              ),
              SizedBox(height: 40),
              Form(
                key: formKey,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text('Enter Email', style: AppStyles.bold16black),
                      SizedBox(height: 5),
                      CustomTextFormFieldd(
                        hintText: 'Email',
                        prefixIcon: Image.asset(AssetsPaths.logoEmail),
                        keyboardType: TextInputType.emailAddress,
                        controller: emailController,
                        validator: (text) {
                          if (text == null || text.trim().isEmpty) {
                            return ('please Enter Email');
                          }
                          final bool emailValid = RegExp(
                            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
                          ).hasMatch(text);
                          if (!emailValid) {
                            return 'please Enter Valid Email';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 50),
                      CustomButton(
                        onPressed: sendReset,
                        text: 'Send reset link',
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void sendReset() {
    if (formKey.currentState?.validate() == true) {
      context.go(AppRoutes.registerRoute);
    }
  }
}
