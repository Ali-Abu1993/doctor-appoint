import 'package:doctor_appointment/core/helper/dio_helper.dart';
import 'package:doctor_appointment/core/mock_data/logic/mock_profile_cubit.dart';
import 'package:doctor_appointment/core/utils/colors_manager.dart';
import 'package:doctor_appointment/core/utils/text_style.dart';
import 'package:doctor_appointment/core/widgets/app_button.dart';
import 'package:doctor_appointment/core/widgets/app_text_field.dart';
import 'package:doctor_appointment/features/user_edit_profile/data/user_profile_model.dart';
import 'package:doctor_appointment/features/user_edit_profile/logic/profile_cubit.dart';
import 'package:doctor_appointment/features/user_edit_profile/logic/user_profile_states.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class EditProfileScreen extends StatefulWidget {
  final UserProfileModel? editProfile;
  const EditProfileScreen({super.key, this.editProfile});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  late TextEditingController nameController;
  late TextEditingController emailController;
  late TextEditingController phoneController;
  String selectedGender = 'Male';
  final user = FirebaseAuth.instance.currentUser;
  String? photoUrl;
  late String? finalImage= photoUrl ?? user?.photoURL ;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.editProfile?.fullName);
    emailController = TextEditingController(text: widget.editProfile?.email);
    phoneController = TextEditingController(
      text: widget.editProfile?.phoneNumber,
    );
    selectedGender = widget.editProfile?.gender ?? 'Male';
    photoUrl=widget.editProfile?.photoUrl ?? user?.photoURL;

  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
  providers: [
    BlocProvider(
      create: (context) => MockProfileCubit(),
),
    BlocProvider(
      create: (context) => ProfileCubit(DioHelper()),
    ),
  ],
  child: Scaffold(
        appBar: AppBar(
          title: Text("Edit profile", style: TxtStyle.font14W700),
          centerTitle: true,
          leading: IconButton(
            onPressed: () {
              context.pop();
            },

            icon: Icon(Icons.arrow_back),
          ),
          actions: [
            IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.notifications_outlined,
                color: ColorsManager.primary,
              ),
            ),
            SizedBox(width: 10),
          ],
        ),

        body: BlocListener<MockProfileCubit, UserProfileStates>(
          listener: (context, state) {
            if (state is UpdateProfileSuccessState) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Row(
                    children: [
                      Icon(Icons.check_circle, color: Colors.white),
                      SizedBox(width: 10),
                      Text(
                        "Profile updated successfully",
                        style: TxtStyle.font12W500,
                      ),
                    ],
                  ),
                  backgroundColor: ColorsManager.primary,
                  duration: Duration(seconds: 2),
                ),
              );
              context.pop();
            } else if (state is UpdateProfileErrorState) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message),
                  backgroundColor: Colors.red,
                  duration: Duration(seconds: 2),
                ),
              );
            }
          },
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 30),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  BlocConsumer<ProfileCubit, UserProfileStates>(
  listener: (context, state) {
    if ( state is EditPhotoLoadingState){
      showDialog(context: context,
          barrierDismissible: false,
          builder: (builder)=> Center(child: const CircularProgressIndicator()));
    }
    if (state is EditPhotoSuccessState){
      SnackBar(
        content: Row(
          children: [
            Icon(Icons.check_circle, color: Colors.white),
            SizedBox(width: 10),
            Text(
              "Image updated successfully",
              style: TxtStyle.font12W500,
            ),
          ],
        ),
        backgroundColor: ColorsManager.primary,
        duration: Duration(seconds: 2),
      );

    context.pop();
    }
    if (state is EditPhotoErrorState){
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(state.message),
          backgroundColor: Colors.red,
          duration: Duration(seconds: 2),
        ),
      );
    }
  },
  builder: (context, state) {
    return InkWell(
      onTap: (){
        pickAndUploadImage(context);
      },
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.white,width: 4)
                          ),
                          child: CircleAvatar(
                            radius: 50,
                            // backgroundColor: Colors.grey.shade500,
                            backgroundImage: photoUrl !=null? NetworkImage(photoUrl!):null
                            ,
                            child: photoUrl==null? Icon(Icons.person,size: 60,color: Colors.grey,):
                            null,
                    
                          ),
                        ),
                        Positioned(
                          right: 5,
                            bottom:5,
                            child:Container(
                              padding: EdgeInsets.all(4.0),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Color(0xFF1E56A0)
                              ),
                              child: Icon(Icons.edit, color: Colors.white,size: 16,),
                            ) )
                      ],
                    ),
                  );
  },
)
                  ,
                  SizedBox(height: 5),
                  Center(
                    child: Text(
                      'change profile photo',
                      style: TxtStyle.font16W400Regular,
                    ),
                  ),
                  SizedBox(height: 30),
                  Container(
                    width: 350.w,
                    height: 293.h,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Color.fromRGBO(255, 255, 255, 1),
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.03),
                          blurRadius: 10,
                          offset: Offset(0, 4),
                        ),
                      ],
                    ),
                    child: SingleChildScrollView(
                      child: Column(
                        spacing: 3,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Full name',style: TxtStyle.font14RegularBlue,),
                          CustomTextField(
                            controller: nameController,
                            hintText: user?.displayName ?? ' ',
                            textInput: (val) {
                              return null;
                            },
                            prefixIcon: null,
                          ),
                          Divider(height: 20),
                          Text('Email Address',style: TxtStyle.font14RegularBlue,),
                          CustomTextField(
                            textInput: (val) {
                              return null;
                            },
                            controller: emailController,
                            hintText: user?.email ?? "noemail@nodomain.com",
                          ),
                      
                          Divider(height: 20),
                          Text('Phone Number',style: TxtStyle.font14RegularBlue,),
                          CustomTextField(
                            textInput: (val) {
                              return null;
                            },
                            controller: phoneController,
                            hintText: user?.phoneNumber ?? '+01 000 0000 0000',
                          ),
                          Divider(height: 20),
                          Text('Gender',style: TxtStyle.font14RegularBlue,),
                          Row(
                            children: [
                              Text("Gender", style: TxtStyle.font12W500),
                              Radio(
                                value: "Male",
                                groupValue: selectedGender,
                                onChanged: (value) {
                                  setState(() {
                                    selectedGender = value!;
                                  });
                                },
                              ),
                              Text("Male", style: TxtStyle.font12W500),
                              Radio(
                                value: "Female",
                                groupValue: selectedGender,
                                onChanged: (value) {
                                  setState(() {
                                    selectedGender = value!;
                                  });
                                },
                              ),
                              Text("Female", style: TxtStyle.font12W500),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  BlocBuilder<MockProfileCubit, UserProfileStates>(
                    builder: (context, state) => AppButton(
                      barWidth: 300.w,
                      txt: state is UpdateProfileLoadingState
                          ? "Updating..."
                          : "Update profile",
                      onPress: () {
                        context.read<MockProfileCubit>().updateUserData(
                          data: UserProfileModel(
                            fullName: nameController.text,
                            email: emailController.text,
                            phoneNumber: phoneController.text,
                            gender: selectedGender,
                          ),
                        );
                      },
                      icon: Icon(Icons.edit, color: Colors.white),
                    ),
                  ),
                  SizedBox(height: 30),
                ],
              ),
            ),
          ),
        ),
      ),
);
  }
}
