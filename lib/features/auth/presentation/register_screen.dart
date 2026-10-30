import 'package:doctor_appointment/core/routing/routes.dart';
import 'package:doctor_appointment/core/utils/app_extensions.dart';
import 'package:doctor_appointment/core/widgets/app_button.dart';
import 'package:doctor_appointment/core/widgets/app_text_field.dart';
import 'package:doctor_appointment/features/auth/data/register_body.dart';
import 'package:doctor_appointment/features/auth/logic/cubit.dart';
import 'package:doctor_appointment/features/auth/logic/state.dart';
import 'package:doctor_appointment/features/auth/presentation/login_screen.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../core/utils/colors_manager.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final genderController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final tapGestureRecognizer = TapGestureRecognizer();
  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    tapGestureRecognizer.dispose();
    super.dispose();
  }

  bool showPassword = false;
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthCubit(),
      child: BlocConsumer<AuthCubit, AuthStates>(
        listener: (context, state) {

          if (state is AuthSuccessState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(context.l1on.signup_success),
                backgroundColor: ColorsManager.primary,
                behavior: SnackBarBehavior.floating,
              ),

            );
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> const LoginScreen()));
          }
          else if (state is AuthErrorState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.em),
                backgroundColor: Colors.red,
                behavior: SnackBarBehavior.floating,
              ),
            );
          }
        },
        builder: (context, state) {
          return Scaffold(
            backgroundColor: Colors.white,
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 20),
              child: SafeArea(
                child: SingleChildScrollView(
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,

                      children: [
                        Text(
                          context.l1on.create_an_account,
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 26,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(height: 10),

                        Text(
                          context.l1on.register_subtitle,
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 16,
                            color: Colors.grey,
                          ),
                        ),
                        SizedBox(height: 30),
                        Text(
                          context.l1on.full_name,
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                            letterSpacing: 0.14,
                          ),
                        ),
                        SizedBox(height: 5),
                        CustomTextField(
                          hintText: context.l1on.name_hint,
                          controller: nameController,
                          textInput: (val) {

                            if (val ==null || val.isEmpty) {
                              return context.l1on.err_enter_name;
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 10),
                        Text(
                          context.l1on.gender,
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                            letterSpacing: 0.14,
                          ),
                        ),
                        SizedBox(height: 5),
                        Row(
                          children: [
                            Expanded(
                              child: RadioListTile<String>(
                                title: Text(context.l1on.male),
                                value: "1",
                                groupValue: genderController.text,
                                onChanged: (String? val) => setState(() => genderController.text = val!),
                              ),
                            ),
                            Expanded(
                              child: RadioListTile<String>(
                                title:  Text(context.l1on.female),
                                value: "0",
                                groupValue: genderController.text,
                                onChanged: (val) => setState(() => genderController.text = val!),
                              ),
                            ),
                          ],
                        ),

                        SizedBox(height: 10),

                        Text(
                          context.l1on.email_address,
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                            letterSpacing: 0.14,
                          ),
                        ),
                        SizedBox(height: 10),
                        CustomTextField(
                          hintText: context.l1on.email_hint,
                          controller: emailController,
                          prefixIcon: Icons.email_outlined,
                          keyboardType: TextInputType.emailAddress,
                          textInput: (value) {
                            RegExp emailRegex = RegExp(
                              r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                            );
                            if (value ==null || value.isEmpty) {
                              return context.l1on.err_enter_email;
                            } else if (!emailRegex.hasMatch(value)) {
                              return context.l1on.err_valid_email;
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 13),
                        Text(
                          context.l1on.phone_number,
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                            letterSpacing: 0.14,
                          ),
                        ),
                        SizedBox(height: 5),
                        CustomTextField(
                          hintText: context.l1on.phone_hint,
                          controller: phoneController,
                          prefixIcon: Icons.phone,
                          textInput: (val) {
                            RegExp phoneRegex = RegExp(r'^01[0125][0-9]{8}$');
                            if (val == null || val.isEmpty) {
                              return context.l1on.err_enter_phone;
                            }else if (val.length !=11)
                              {
                                return context.l1on.err_phone_digits;
                              }

                            else if (!phoneRegex.hasMatch(val)) {
                              return context.l1on.err_valid_phone;
                            }
                            return null;
                          },
                          keyboardType: TextInputType.phone,
                        ),
                        SizedBox(height: 10),

                        Text(
                          context.l1on.password,
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                            letterSpacing: 0.14,
                          ),
                        ),
                        SizedBox(height: 5),
                        CustomTextField(
                          hintText: context.l1on.create_strong_password,
                          controller: passwordController,
                          textInput: (value) {

                            RegExp regex = RegExp(
                              r'^(?=.*[a-z])(?=.*[A-Z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$',
                            );
                            if (value ==null || value.isEmpty) {
                              return "Please enter your password";
                            } else if (value.length < 8) {
                              return "Password must contain uppercase, lowercase, numbers, and special characters";
                            } else if (!regex.hasMatch(value)) {
                              return "Password must contain uppercase, lowercase, numbers, and special characters";
                            }
                            return null;
                          },
                          suffixIcon: InkWell(
                            onTap: () {
                              setState(() {
                                showPassword = !showPassword;
                              });
                            },
                            child: Icon(
                              showPassword
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                            ),
                          ),
                          isPassword: !showPassword,
                          prefixIcon: Icons.lock,
                        ),
                        SizedBox(height: 10),

                        Text(
                          context.l1on.confirm_password,
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                            letterSpacing: 0.14,
                          ),
                        ),
                        SizedBox(height: 5),
                        CustomTextField(
                          hintText: "Confirm password",
                          controller: confirmPasswordController,
                          textInput: (value) {
                            if (value==null || value.isEmpty) {
                              return "Please enter your password again";
                            } else if (passwordController.text.trim() !=
                                value) {
                              return "please enter you password correctly";
                            }
                            return null;
                          },
                          suffixIcon: InkWell(
                            onTap: () {
                              setState(() {
                                showPassword = !showPassword;
                              });
                            },
                            child: Icon(
                              showPassword
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                            ),
                          ),
                          isPassword: !showPassword,
                          onPress: () {},
                          prefixIcon: Icons.lock,
                        ),
                        SizedBox(height: 30),

                        // 1. الجزء الخاص بالـ Checkbox والشروط
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 24,
                              width: 24,
                              child: Checkbox(
                                value: isChecked,
                                // متغير bool لازم تعرفه فوق في الـ State
                                onChanged: (value) {
                                  setState(() {
                                    isChecked = value!;
                                  });
                                },
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(4),
                                ),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Text.rich(
                                TextSpan(
                                  text: context.l1on.i_agree_to,
                                  style: const TextStyle(
                                    color: Colors.black54,
                                    fontSize: 13,
                                  ),
                                  children: [
                                    TextSpan(
                                      text: context.l1on.terms_of_service,
                                      style: const TextStyle(
                                        color: ColorsManager.primary,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      recognizer: tapGestureRecognizer
                                        ..onTap = () {},
                                    ),
                                     TextSpan(text: context.l1on.and),
                                     TextSpan(
                                      text: context.l1on.privacy_policy,
                                      style: TextStyle(
                                        color: ColorsManager.primary,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 24),

                        // 2. زرار Create Account
                        //
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: AppButton(
                            barWidth: double.infinity,
                            txt: (state is AuthLoadingState)
                                ? context.l1on.loading
                                : context.l1on.create_account_btn,
                            onPress: () {
                              if (!isChecked){
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text("Please accept terms and conditions"),
                                  backgroundColor:Colors.redAccent ,behavior: SnackBarBehavior.floating,));
                                return;
                              }
                              if (formKey.currentState!.validate()) {
                                context.read<AuthCubit>().register(
                                  RegisterBody(
                                    name: nameController.text.trim(),
                                    email: emailController.text.trim(),
                                    phone: phoneController.text.trim(),
                                    gender: genderController.text.trim(),
                                    password: passwordController.text,
                                    passwordConfirmation:
                                        confirmPasswordController.text,
                                  ),
                                );
                              }

                            },
                          ),
                        ),

                        const SizedBox(height: 24),

                        // 3. النص اللي تحت (Already have an account?)
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                             Text(
                              context.l1on.already_have_account,
                              style: TextStyle(color: Colors.black54),
                            ),
                            GestureDetector(
                              onTap: () {
                                // انقل لصفحة الـ Login
                                context.go(AppRouter.kLoginScreen);
                              },
                              child:  Text(
                                context.l1on.log_in,
                                style: TextStyle(
                                  color: ColorsManager.primary,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
