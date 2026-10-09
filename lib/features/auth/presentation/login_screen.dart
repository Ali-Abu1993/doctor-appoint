import 'package:doctor_appointment/core/routing/routes.dart';
import 'package:doctor_appointment/core/utils/colors_manager.dart';
import 'package:doctor_appointment/core/widgets/app_button.dart';
import 'package:doctor_appointment/core/widgets/app_text_field.dart';
import 'package:doctor_appointment/core/widgets/buttons.dart';
import 'package:doctor_appointment/features/alldoctors/presentation/all_doctors_screen.dart';
import 'package:doctor_appointment/features/auth/data/login_body.dart';
import 'package:doctor_appointment/features/auth/logic/cubit.dart';
import 'package:doctor_appointment/features/auth/logic/state.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passController = TextEditingController();
   bool showPassword = false;
   bool isChecked = false;
   final  tapGestureRecognizer =TapGestureRecognizer();
   final formKey =GlobalKey();
   @override
  void dispose() {
    tapGestureRecognizer.dispose();
    emailController.dispose();
    passController.dispose();
    super.dispose();
  }
  void showError(String message){
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(backgroundColor: Colors.redAccent,
      content: Text(message, style:
      TextStyle(
        color: Colors.white,

      ),),
      behavior: SnackBarBehavior.floating,));
  }
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
  create: (context) => AuthCubit(),
  child: BlocConsumer<AuthCubit, AuthStates>(
  listener: (context, state) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("You signed up successfully"),
        backgroundColor: ColorsManager.primary,
        behavior: SnackBarBehavior.floating,
      ),

    );
  },
  builder: (context, state) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left:20, top: 30),
          child: SingleChildScrollView(
            child: Form(
              child: Column(
                key: formKey,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Text("Welcome Back",style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 32,
                      color: Colors.black

                    ),),
                  ),
                  Center(
                    child: Text("Sign in to securely access your\n medical records and upcoming\n appointments."
                      , style: TextStyle(fontWeight: FontWeight.w400,
                      fontSize: 16 ,
                        color: Color.fromRGBO(66, 71, 82, 1)
                      ),
                      ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 20,),

                      Text(
                        "Email Address",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                          letterSpacing: 0.14,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 15,),
                  CustomTextField(hintText: "patient@example.com",
                    controller: emailController,
                    prefixIcon: Icons.email_outlined,
                  keyboardType: TextInputType.emailAddress,
                    textInput: ( value){

                      RegExp emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
                      if(value.isEmpty){
                        return"Please enter your email address";
                      }
                      else if(!emailRegex.hasMatch(value)){
                        return"Please enter a valid email address";
                      }
                      return null;
                    },),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    spacing: 0,
                    children: [
                      SizedBox(height: 20,),
                      Text(
                        "Password",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                          letterSpacing: 0.14,
                        ),
                      ),
                      SizedBox(width: 150,),
                      TextButton(onPressed: (){},
                          child:ShaderMask(shaderCallback: (bounds)=>
                              LinearGradient(colors: [ColorsManager.primary,ColorsManager.primary],
                                  begin: Alignment.centerLeft,end: Alignment.centerRight )
                                  .createShader(Rect.fromLTWH(0, 0, bounds.width, bounds.height)),
                            child: Text("Forgot password?",style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 12

                            ),),
                          ),

                      ),

                    ],
                  ),

                  CustomTextField(
                    hintText: "••••••••",
                    controller: passController,
                    textInput: ( value){

                      RegExp regex = RegExp(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
                      if(value.isEmpty){
                        return"Please enter your password";
                      }
                      else if(value.length<8){
                        return "Password must contain uppercase, lowercase, numbers, and special characters";}


                      else if(!regex.hasMatch(value)){
                        return"Password must contain uppercase, lowercase, numbers, and special characters";
                      }return null;

                    },
                    suffixIcon: InkWell(onTap: (){
                      setState(() {
                        showPassword =!showPassword;
                      });
                    },
                      child: Icon(showPassword ? Icons.visibility_off: Icons.visibility),),
                    isPassword: !showPassword,
                    prefixIcon: Icons.lock,
                  ),
                  SizedBox(height: 0,),
                  Padding(
                    padding: const EdgeInsets.only(top: 30),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 24,
                          width: 24,
                          child: Checkbox(value: isChecked, onChanged: (val){
                            setState(() {
                              isChecked =val!;
                            });
                          }),
                        ),
                        SizedBox(width: 10,),
                        Text("Remember me for 30 days",style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                          color: Color.fromRGBO(66, 71, 82, 1)
                        ),)
                      ],
                    ),
                  ),

                  SizedBox(height: 40),
                  Padding(
                    padding: const EdgeInsets.only(right: 15),
                    child: AppButton(barWidth: double.infinity, txt:(state is AuthLoadingState)? "Loading..." :"Sign in",
                        onPress: (){
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>AllDoctorsScreen()));
                      context.read<AuthCubit>().login(LoginRequestBody(
                          email: emailController.text.trim(), password: passController.text.trim()));
                        }),
                  ),
                  SizedBox(height: 50,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset("assets/images_and_icons/Line 1.png", width: 100,height: 10,
                        color:Colors.grey ,),
                      SizedBox(width: 20,),
                      Text("Or continue with",style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 12,
                        color: Color.fromRGBO(114, 119, 131, 1)
                      ),),
                      SizedBox(width: 20,),
                      Image.asset("assets/images_and_icons/Line 1.png", width: 100,height: 10,
                        color:Colors.grey ,),
                    ],

                  ),
                  SizedBox(height: 20,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ButtonWidget("assets/images_and_icons/google_logo.png",
                      onTap: () async{
                        try{
                          final UserCredential? userCredential =
                          await  context.read<AuthCubit>().signInWithGoogle();
                          if(userCredential != null){
                            print("---------------------- google signin success");
                            print(userCredential);
                            print("Logged in as: ${userCredential.user?.displayName}");
                            context.goNamed(AppRouter.kAllDoctorScreen);
                          }

                        }catch(ex){
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text(ex.toString())));
                        }
                        
                      },
                          containerWidth: 150, containerHeight: 48, borderColor: Colors.blueGrey,
                          textColor: Colors.black, body: "Google", fontWeight: FontWeight.w600)
                          ,
                      SizedBox(width: 20,),
                      ButtonWidget("assets/images_and_icons/apple_logo.png",
                      onTap: () {

                      },
                          containerWidth: 150, containerHeight: 48, borderColor: Colors.blueGrey,
                          textColor: Colors.black, body: "Apple", fontWeight: FontWeight.w600),
                    ],
                  ),
                  SizedBox(height: 35,),
                  Center(
                    child: Text.rich(TextSpan(
                      text: "Don't have an account? ",
                      style: TextStyle(color: Colors.black54, fontSize: 13),
                      children: [
                        TextSpan(
                            text: "Create one here ",
                            style: TextStyle(
                              color: ColorsManager.primary,
                              fontWeight: FontWeight.bold,
                    ),
                          recognizer: tapGestureRecognizer..onTap=(){
                              context.go(AppRouter.kSignUpScreen);
                          }
                        ),
                      ]
                    )),
                  )

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
