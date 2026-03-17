import 'package:flutter/material.dart';
import 'package:studex_graduation_project/core/constants/assets_paths.dart';
import 'package:studex_graduation_project/features/auth/repassword/re_password.dart';


import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_styles.dart';
import '../../../routes/app_routes.dart';
import '../../widgets/custom_botton.dart';
import '../../widgets/custom_text_form_field.dart';
import '../register/register_screen.dart';

class LoginScreen extends StatefulWidget {

  const LoginScreen({super.key });

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final formKey = GlobalKey<FormState>();

  TextEditingController emailController =TextEditingController();

  TextEditingController passwordController =TextEditingController();

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: SafeArea(
        child: Padding(
          padding:  EdgeInsets.symmetric(horizontal: width*0.02),
          child: Column(
            children: [
              Image.asset(AssetsPaths.logoLogin,width: width*0.3,height: height*0.09,),
              Text('Studex',style: AppStyles.bold30black,),
              Text('Welcome back to your educational journey',style: AppStyles.medium16grey,),
              SizedBox(height: height*0.05,),
              Form(
                  key: formKey ,
                  child:SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        CustomTextFormFieldd(
                          hintText: 'Email',
                          prefixIcon: Image.asset(AssetsPaths.logoEmail),
                          keyboardType: TextInputType.emailAddress,
                          controller: emailController,
                          validator: (text){
                            if(text == null || text.trim().isEmpty){
                              return ('please Enter Email');
                            }
                            final bool emailValid =
                            RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                .hasMatch(text);
                            if(!emailValid){
                              return 'please Enter Valid Email';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: height*0.02,),
                        CustomTextFormFieldd(
                          hintText: 'Password',
                          prefixIcon: Image.asset(AssetsPaths.logoPassword),
                          suffixIcon: Image.asset(AssetsPaths.logoShowPassword),
                          keyboardType: TextInputType.phone,
                          obscureText: true,
                          controller: passwordController,
                          validator: (text){
                            if(text == null || text.trim().isEmpty){
                              return ('please Enter Password');
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: height*0.02,),
                        Container(
                          alignment: Alignment.centerRight,
                          child: TextButton(onPressed: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context) => RePassword(),));
                          },
                              child: Text('Forget Password?',
                                style: AppStyles.bold16primary.copyWith(
                                    decoration: TextDecoration.underline,
                                    decorationColor: AppColors.primaryLight
                                ),)
                          ),
                        ),
                        SizedBox(height: height*0.02,),
                        CustomButton(onPressed: login,
                            text:'Login'),
                        SizedBox(height: height*0.02,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Don\'t have an account?',
                              style: AppStyles.bold16black,),
                            TextButton(onPressed: (){
                              Navigator.push(context, MaterialPageRoute(
                                builder: (context) => RegisterScreen(),));
                            },
                                child: Text('Create Account',
                                  style: AppStyles.bold16primary.copyWith(
                                      decoration: TextDecoration.underline,
                                      decorationColor: AppColors.primaryLight
                                  ),)
                            ),
                          ],
                        ),
                        SizedBox(height: height*0.02,),
                        Row(
                          children: [
                            Expanded(
                              child: Divider(
                                color: AppColors.primaryLight,
                                thickness: 1,
                                indent:width*0.04 ,
                                endIndent: width*0.04,
                              ),
                            ),
                            Text('Or',
                              style: AppStyles.medium16primary,),
                            Expanded(
                              child: Divider(
                                color: AppColors.primaryLight,
                                thickness: 1,
                                indent:width*0.04 ,
                                endIndent: width*0.04,
                              ),
                            )
                          ],
                        ),
                        SizedBox(height: height*0.02,),
                        CustomButton(onPressed: (){

                        },

                          backgroundColor: AppColors.transparent,
                          borderColor: AppColors.primaryLight,
                          hasIcon: true,
                          childIconWidget:
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(AssetsPaths.iconGoogle),
                              SizedBox(width: width*0.03,),
                              Text('Login with Google',
                                style: AppStyles.bold20primary,)
                            ],
                          ),
                        ),
                      ],
                    ),
                  ) )

            ],
          ),
        ),
      ),
    );
  }

  void login(){
    if(formKey.currentState?.validate() == true){
      Navigator.of(context).pushNamedAndRemoveUntil(AppRoutes.registerRoute, (route) => false,);
    }
  }
}
