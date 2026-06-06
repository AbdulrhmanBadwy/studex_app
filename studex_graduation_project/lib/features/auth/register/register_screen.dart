import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:studex_graduation_project/core/theme/app_colors.dart';
import 'package:studex_graduation_project/core/theme/app_styles.dart';
import 'package:studex_graduation_project/features/auth/login/login_screen.dart';
import 'package:studex_graduation_project/features/widgets/Custom_Dropdown_Button_Form_Field.dart';
import 'package:studex_graduation_project/features/widgets/custom_elevated_botton.dart';
import 'package:studex_graduation_project/features/widgets/custom_text_form_field.dart';

import '../../../core/constants/assets_paths.dart';
import '../../../routes/app_routes.dart';


class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final formKey = GlobalKey<FormState>();

  TextEditingController emailController =TextEditingController();
  TextEditingController nameController =TextEditingController();
  TextEditingController passwordController =TextEditingController();
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: AppBar(
        backgroundColor: AppColors.whiteColor,
        title: Text('Create Account',style: AppStyles.bold20black,),
        centerTitle: true,

      ),
      body: SingleChildScrollView(
        child: Padding(
          padding:  EdgeInsets.symmetric(horizontal: width*0.02,vertical: height*0.03),
          child: Column(
            children: [
              Image.asset(AssetsPaths.iconCreate,width: width*0.3,height: height*0.09,),
              Text('Studex',style: AppStyles.bold30black,),
              Text('Welcome back to your educational journey',style: AppStyles.medium16grey,),
              SizedBox(height: height*0.05,),
              Form(
                  key: formKey ,
                  child:Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                      Text('Name',style: AppStyles.medium16black,),
                    CustomTextFormFieldd(
                      hintText: 'Name',
                      prefixIcon: Image.asset(AssetsPaths.iconName),
                      keyboardType: TextInputType.name,
                      controller: nameController,
                    ),
                        SizedBox(height: height*0.02,),
                        Text('Email',style: AppStyles.medium16black,),
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
                        Text('Password',style: AppStyles.medium16black,),
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
                        Text('Confirm Password',style: AppStyles.medium16black,),
                        CustomTextFormFieldd(
                          hintText: 'Confirm Password',
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
                        Text('University',style: AppStyles.medium16black,),
                        CustomDropdownButtonFormField(),
                        SizedBox(height: height*0.02,),
                        Text('Section',style: AppStyles.medium16black,),
                        CustomDropdownButtonFormField(),
                        SizedBox(height: height*0.02,),
                        Text('Academic Year',style: AppStyles.medium16black,),
                        CustomDropdownButtonFormField(),
                        SizedBox(height: height*0.04,),
                        CustomElevatedButton(
                            text: 'Create Account',
                            onPressed: CreateAccount ,
                        ),
                        SizedBox(height: height*0.02,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Don\'t have an account?',
                              style: AppStyles.bold16black,),
                            TextButton(onPressed: (){
                              Navigator.push(context, MaterialPageRoute(
                                builder: (context) => LoginScreen(),));
                            },
                                child: Text('Login',
                                  style: AppStyles.bold16primary.copyWith(
                                      decoration: TextDecoration.underline,
                                      decorationColor: AppColors.primaryLight
                                  ),)
                            ),
                          ],
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

  void CreateAccount(){
    if(formKey.currentState?.validate() == true){
      context.go(AppRoutes.homeScreen);
      //Navigator.of(context).pushNamedAndRemoveUntil(AppRoutes.homeScreen, (route) => false,);
    }
  }
}
 