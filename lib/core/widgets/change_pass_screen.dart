import 'package:doctor_appointment/core/helper/debounce.dart';
import 'package:doctor_appointment/core/utils/text_style.dart';
import 'package:doctor_appointment/core/widgets/app_button.dart';
import 'package:doctor_appointment/core/widgets/custom_widgets/build_section_title.dart';
import 'package:doctor_appointment/features/auth/data/login_body.dart';
import 'package:doctor_appointment/features/auth/logic/cubit.dart';
import 'package:doctor_appointment/features/auth/logic/state.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../utils/colors_manager.dart';
import 'app_text_field.dart';

class ChangePassScreen extends StatefulWidget {
  const ChangePassScreen({super.key});

  @override
  State<ChangePassScreen> createState() => _ChangePassScreenState();
}

class _ChangePassScreenState extends State<ChangePassScreen> {
  final newPassController = TextEditingController();
  final confirmPassController = TextEditingController();
  final debounce = Debounce();
  bool showPassword= false;
  bool hasText = false;
  final formKey =GlobalKey<FormState>();
  @override
  void dispose() {
    newPassController.dispose();
    confirmPassController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
  create: (context) => AuthCubit(),
  child: Scaffold(
      appBar:
         AppBar(
          systemOverlayStyle: SystemUiOverlayStyle(
            statusBarBrightness: Brightness.light,
            statusBarColor: ColorsManager.primary,
          ),

          leadingWidth: double.infinity,
          elevation: 5,
          title: Text('Change Password', style: TxtStyle.font14BoldBlue,),
          centerTitle: true,
           backgroundColor: ColorsManager.white,

        ),

      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 2,
          children: [
            buildSectionTitle('Change Password',style: TxtStyle.font14BoldBlue),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
              child:  CustomTextField(
                hintText: "Create a strong password",
                controller: newPassController,
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
            ),
            buildSectionTitle('Confirm new password',style: TxtStyle.font14BoldBlue),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
              child:  CustomTextField(
                hintText: "Confirm password",
                controller: confirmPassController,
                textInput: (value) {
                  if (value==null || value.isEmpty) {
                    return "Please enter your password again";
                  } else if (confirmPassController.text.trim() !=
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
            ),
            SizedBox(height: 20,),
            BlocListener<AuthCubit, AuthStates>(
  listener: (context, state) {
    if(state is AuthSuccessState){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Password is changed')));
    }
    else if (state is AuthErrorState){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(state.em)));
    }
  },
  child: Center(
              child: AppButton(barWidth: 200.w, txt: 'Reset Password',
                  onPress: (){
                if(formKey.currentState!.validate()){
                  context.read<AuthCubit>().login(LoginRequestBody(
                      email: newPassController.text, password: newPassController.text));
                }
                  }),
            ),
)
          ],
        ),
      ),

    ),
);
  }
}
