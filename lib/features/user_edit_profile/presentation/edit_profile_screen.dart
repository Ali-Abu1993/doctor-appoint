import 'package:doctor_appointment/core/helper/dio_helper.dart';
import 'package:doctor_appointment/core/mock_data/logic/mock_profile_cubit.dart';
import 'package:doctor_appointment/core/utils/app_extensions.dart';
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
    final profile =widget.editProfile;

    String initialName = (profile?.fullName!=null && profile!.fullName.isNotEmpty)?
        profile.fullName:(user?.displayName ?? '');

    String initialEmail=(profile?.email !=null && profile!.email.isNotEmpty)?
        profile.email:(user?.email ?? '');
    String initialPhone =(profile?.phoneNumber !=null && profile!.phoneNumber.isNotEmpty)?
        profile.phoneNumber:(user?.phoneNumber ?? "");
    nameController=TextEditingController(text: initialName);
    emailController=TextEditingController(text: initialEmail);
    phoneController=TextEditingController(text: initialPhone);

    selectedGender = profile?.gender.isNotEmpty ==true ? profile!.gender:"Male";
    photoUrl=profile?.photoUrl ?? user?.photoURL;

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
    final local = context.l1on;
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
          title: Text(local.edit_profile, style: context.isDark? TxtStyle.font18SemiBoldWhite:TxtStyle.font18SemiBold(context)),
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
                color: context.isDark?ColorsManager.white:Colors.white70,
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
                        local.profile_updated_success,
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
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Row(
          children: [
            Icon(Icons.check_circle, color: Colors.white),
            SizedBox(width: 10),
            Text(
              local.image_updated_success,
              style: TxtStyle.font12W500,
            ),
          ],
        ),
        backgroundColor: ColorsManager.primary,
        duration: Duration(seconds: 2),
      ));

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
                      local.change_profile_photo,
                      style: TxtStyle.font14BoldBlue,
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
                          Text(local.full_name,style: TxtStyle.font14RegularBlue,),
                          CustomTextField(
                            controller: nameController,
                            hintText: (widget.editProfile?.fullName.isNotEmpty==true)?
                            widget.editProfile!.fullName:(user?.displayName ?? 'Full Name'),
                            textInput: (val) =>null,
                            prefixIcon: null,
                          ),
                          Divider(height: 20),
                          Text(local.email_address,style: TxtStyle.font14RegularBlue,),
                          CustomTextField(
                            textInput: (val) =>null,
                            controller: emailController,
                            hintText: widget.editProfile?.email.isNotEmpty==true?
                            widget.editProfile!.email:(user?.email ?? "noemail@nodomain.com"),
                          ),
                      
                          Divider(height: 20),
                          Text(local.phone_number,style: TxtStyle.font14RegularBlue,),
                          CustomTextField(
                            textInput: (val) =>null,
                            controller: phoneController,
                            hintText: widget.editProfile?.phoneNumber.isNotEmpty==true?
                            widget.editProfile!.phoneNumber:(user?.phoneNumber ?? "")
                            ,
                          ),
                          Divider(height: 20),
                          Text(local.gender,style: TxtStyle.font14RegularBlue,),
                          Row(
                            children: [
                              Text(local.gender, style: TxtStyle.font12W500),
                              Radio(
                                value: local.male,
                                groupValue: selectedGender,
                                onChanged: (value) {
                                  setState(() {
                                    selectedGender = value!;
                                  });
                                },
                              ),
                              Text(local.male, style: TxtStyle.font12W500),
                              Radio(
                                value: local.female,
                                groupValue: selectedGender,
                                onChanged: (value) {
                                  setState(() {
                                    selectedGender = value!;
                                  });
                                },
                              ),
                              Text(local.female, style: TxtStyle.font12W500),
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
                          ? local.updating
                          : local.update_profile,
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
