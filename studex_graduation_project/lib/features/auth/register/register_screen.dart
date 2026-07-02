import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:studex_graduation_project/core/theme/app_colors.dart';
import 'package:studex_graduation_project/core/theme/app_styles.dart';
import 'package:studex_graduation_project/features/widgets/Custom_Dropdown_Button_Form_Field.dart';
import 'package:studex_graduation_project/features/widgets/custom_elevated_botton.dart';
import 'package:studex_graduation_project/features/widgets/custom_text_form_field.dart';

import '../../../core/constants/assets_paths.dart';
import 'package:studex_graduation_project/core/routes/app_routes.dart';

import '../../../repositories/auth_repository.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final formKey = GlobalKey<FormState>();

  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: AppBar(
        backgroundColor: AppColors.whiteColor,
        title: Text(
          'إنشاء حساب',
          style: AppStyles.bold20black.copyWith(fontFamily: 'AbdoMaster'),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: width * 0.02,
            vertical: height * 0.03,
          ),
          child: Column(
            children: [
              Image.asset(
                AssetsPaths.iconCreate,
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
                child: Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        'الاسم',
                        style: AppStyles.medium16black.copyWith(
                          fontFamily: 'AbdoMaster',
                        ),
                      ),
                      CustomTextFormFieldd(
                        hintText: 'الاسم',
                        prefixIcon: Image.asset(AssetsPaths.iconName),
                        keyboardType: TextInputType.name,
                        controller: nameController,
                        validator: (text) {
                          if (text == null || text.trim().isEmpty) {
                            return ('من فضلك أدخل الاسم');
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: height * 0.02),
                      Text(
                        'البريد الإلكتروني',
                        style: AppStyles.medium16black.copyWith(
                          fontFamily: 'AbdoMaster',
                        ),
                      ),
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
                      Text(
                        'كلمة المرور',
                        style: AppStyles.medium16black.copyWith(
                          fontFamily: 'AbdoMaster',
                        ),
                      ),
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
                      Text(
                        'تأكيد كلمة المرور',
                        style: AppStyles.medium16black.copyWith(
                          fontFamily: 'AbdoMaster',
                        ),
                      ),
                      CustomTextFormFieldd(
                        hintText: 'تأكيد كلمة المرور',
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
                      Text(
                        'الجامعة',
                        style: AppStyles.medium16black.copyWith(
                          fontFamily: 'AbdoMaster',
                        ),
                      ),
                      CustomDropdownButtonFormField(
                        type: DropdownType.university,
                      ),
                      SizedBox(height: height * 0.02),
                      Text(
                        'التخصص',
                        style: AppStyles.medium16black.copyWith(
                          fontFamily: 'AbdoMaster',
                        ),
                      ),
                      CustomDropdownButtonFormField(type: DropdownType.major),
                      SizedBox(height: height * 0.02),
                      Text(
                        'الفرقة الدراسية',
                        style: AppStyles.medium16black.copyWith(
                          fontFamily: 'AbdoMaster',
                        ),
                      ),
                      CustomDropdownButtonFormField(type: DropdownType.year),
                      SizedBox(height: height * 0.04),
                      CustomElevatedButton(
                        text: 'إنشاء حساب',
                        onPressed: createAccount,
                      ),
                      SizedBox(height: height * 0.02),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'عندك حساب بالفعل؟',
                            style: AppStyles.bold16black.copyWith(
                              fontFamily: 'AbdoMaster',
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              context.pushNamed(AppRoutes.loginRoute);
                            },
                            child: Text(
                              'تسجيل الدخول',
                              style: AppStyles.bold16primary.copyWith(
                                decoration: TextDecoration.underline,
                                decorationColor: AppColors.primaryLight,
                              ),
                            ),
                          ),
                        ],
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

  Future<void> createAccount() async {
    if (formKey.currentState?.validate() != true) return;

    try {
      final authRepository = FirebaseAuthRepository();

      await authRepository.signUp(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
        name: nameController.text.trim(),
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
}
