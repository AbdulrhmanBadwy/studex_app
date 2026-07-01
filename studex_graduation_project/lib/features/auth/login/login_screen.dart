import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:studex_graduation_project/core/constants/assets_paths.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_styles.dart';
import 'package:studex_graduation_project/core/routes/app_routes.dart';
import '../../../repositories/auth_repository.dart';
import '../../widgets/custom_botton.dart';
import '../../widgets/custom_text_form_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final formKey = GlobalKey<FormState>();

  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: width * 0.02),
          child: Column(
            children: [
              Image.asset(
                AssetsPaths.logoLogin,
                width: width * 0.3,
                height: height * 0.09,
              ),
              Text(
                'Studex',
                style: AppStyles.bold30black.copyWith(fontFamily: 'AbdoMaster'),
              ),
              Text(
                'أهلاً بيك تاني في رحلتك التعليمية',
                style: AppStyles.medium16grey.copyWith(
                  fontFamily: 'AbdoMaster',
                ),
              ),
              SizedBox(height: height * 0.05),
              Form(
                key: formKey,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      CustomTextFormFieldd(
                        hintText: 'البريد الإلكتروني',
                        prefixIcon: Image.asset(AssetsPaths.logoEmail),
                        keyboardType: TextInputType.emailAddress,
                        controller: emailController,
                        validator: (text) {
                          if (text == null || text.trim().isEmpty) {
                            return ('من فضلك أدخل البريد الإلكتروني');
                          }
                          final bool emailValid = RegExp(
                            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
                          ).hasMatch(text);
                          if (!emailValid) {
                            return 'من فضلك أدخل بريد إلكتروني صحيح';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: height * 0.02),
                      CustomTextFormFieldd(
                        hintText: 'كلمة المرور',
                        prefixIcon: Image.asset(AssetsPaths.logoPassword),
                        suffixIcon: Image.asset(AssetsPaths.logoShowPassword),
                        keyboardType: TextInputType.phone,
                        obscureText: true,
                        controller: passwordController,
                        validator: (text) {
                          if (text == null || text.trim().isEmpty) {
                            return ('من فضلك أدخل كلمة المرور');
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: height * 0.02),
                      Container(
                        alignment: AlignmentDirectional.centerEnd,
                        child: TextButton(
                          onPressed: () {
                            context.pushNamed(AppRoutes.rePasswordRoute);
                          },
                          child: Text(
                            'نسيت كلمة المرور؟',
                            style: AppStyles.bold16primary.copyWith(
                              decoration: TextDecoration.underline,
                              decorationColor: AppColors.primaryLight,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: height * 0.02),
                      CustomButton(onPressed: login, text: 'تسجيل الدخول'),
                      SizedBox(height: height * 0.02),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'معندكش حساب؟',
                            style: AppStyles.bold16black.copyWith(
                              fontFamily: 'AbdoMaster',
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              context.pushNamed(AppRoutes.registerRoute);
                            },
                            child: Text(
                              'إنشاء حساب',
                              style: AppStyles.bold16primary.copyWith(
                                decoration: TextDecoration.underline,
                                decorationColor: AppColors.primaryLight,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: height * 0.02),
                      Row(
                        children: [
                          Expanded(
                            child: Divider(
                              color: AppColors.primaryLight,
                              thickness: 1,
                              indent: width * 0.04,
                              endIndent: width * 0.04,
                            ),
                          ),
                          Text(
                            'أو',
                            style: AppStyles.medium16primary.copyWith(
                              fontFamily: 'AbdoMaster',
                            ),
                          ),
                          Expanded(
                            child: Divider(
                              color: AppColors.primaryLight,
                              thickness: 1,
                              indent: width * 0.04,
                              endIndent: width * 0.04,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: height * 0.02),
                      CustomButton(
                        onPressed: loginWithGoogle,

                        backgroundColor: AppColors.transparent,
                        borderColor: AppColors.primaryLight,
                        hasIcon: true,
                        childIconWidget: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(AssetsPaths.iconGoogle),
                            SizedBox(width: width * 0.03),
                            Text(
                              'تسجيل الدخول بواسطة جوجل',
                              style: AppStyles.bold20primary.copyWith(
                                fontFamily: 'AbdoMaster',
                              ),
                            ),
                          ],
                        ),
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

  // void login(){
  //   if(formKey.currentState?.validate() == true){
  //    // Navigator.of(context).pushNamedAndRemoveUntil(AppRoutes.registerRoute, (route) => false,);
  //   }
  Future<void> login() async {
    if (formKey.currentState?.validate() != true) return;

    try {
      final authRepository = FirebaseAuthRepository();

      await authRepository.signIn(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );

      if (!mounted) return;

      context.go(AppRoutes.homeScreen);
    } catch (e) {
      debugPrint('REGISTER ERROR: $e');

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }

  Future<void> loginWithGoogle() async {
    try {
      final authRepository = FirebaseAuthRepository();

      await authRepository.signInWithGoogle();
      await GoogleSignIn().signOut();

      if (!mounted) return;

      context.go(AppRoutes.homeScreen);
    } catch (e) {
      debugPrint('GOOGLE LOGIN ERROR: $e');

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }
}
