import 'package:doctor_appointment/core/helper/debounce.dart';
import 'package:doctor_appointment/core/utils/app_extensions.dart';
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
import 'package:go_router/go_router.dart';

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
    final local = context.l1on;
    final isDark = context.isDark;
    return BlocProvider(
  create: (context) => AuthCubit(),
  child: Scaffold(
      appBar:
         AppBar(
          systemOverlayStyle: SystemUiOverlayStyle(
            statusBarBrightness: Brightness.light,
            statusBarColor: ColorsManager.primary,
          ),
leading: IconButton(onPressed: () {
  context.pop();
}, icon: Icon(Icons.arrow_back,
    color: isDark? Colors.white70: Colors.white,)),
          elevation: 5,
          title: Text(local.change_password, style: TxtStyle.font18SemiBoldWhite,),
          centerTitle: true,
           backgroundColor: isDark?ColorsManager.primary:Colors.black12,

        ),

      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          key: formKey,
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 2,
          children: [
            buildSectionTitle(local.change_password,isDark?TxtStyle.font14BoldBlue:TxtStyle.font14SemiBoldWhite),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
              child:  CustomTextField(
                hintText: local.create_strong_password,
                controller: newPassController,
                textInput: (value) {

                  RegExp regex = RegExp(
                    r'^(?=.*[a-z])(?=.*[A-Z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$',
                  );
                  if (value ==null || value.isEmpty) {
                    return local.err_enter_password;
                  } else if (value.length < 8) {
                    return local.err_password_spec;
                  } else if (!regex.hasMatch(value)) {
                    return local.err_password_spec;
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
            buildSectionTitle(local.confirm_password, isDark?TxtStyle.font14BoldBlue:TxtStyle.font14SemiBoldWhite ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
              child:  CustomTextField(
                hintText: local.confirm_password,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(
                      color: isDark? Colors.black12:Colors.white70,
                    )
                  ),
                ),
                controller: confirmPassController,
                textInput: (value) {
                  if (value==null || value.isEmpty) {
                    return local.err_enter_password_again;
                  } else if (confirmPassController.text.trim() !=
                      value) {
                    return local.err_password_match;
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
          content: Text(local.change_password_success)));
    }
    else if (state is AuthErrorState){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(state.em)));
    }
  },
  child: Center(
              child: AppButton(barWidth: 200.w, txt: local.reset_password,
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
