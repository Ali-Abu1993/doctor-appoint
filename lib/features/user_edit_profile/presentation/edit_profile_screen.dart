import 'package:doctor_appointment/core/mock_data/logic/mock_profile_cubit.dart';
import 'package:doctor_appointment/core/utils/colors_manager.dart';
import 'package:doctor_appointment/core/utils/text_style.dart';
import 'package:doctor_appointment/core/widgets/app_button.dart';
import 'package:doctor_appointment/core/widgets/app_text_field.dart';
import 'package:doctor_appointment/features/user_edit_profile/data/user_profile_model.dart';
import 'package:doctor_appointment/features/user_edit_profile/logic/user_profile_states.dart';
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

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.editProfile?.fullName);
    emailController = TextEditingController(text: widget.editProfile?.email);
    phoneController = TextEditingController(
      text: widget.editProfile?.phoneNumber,
    );
    selectedGender = widget.editProfile?.gender ?? 'Male';
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
    return BlocProvider(
      create: (context) => MockProfileCubit(),
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
            child: Column(
              children: [
                CircleAvatar(
                  radius: 35,
                  child: Image.asset(
                    "assets/images_and_icons/female_doc_img.jpg",
                  ),
                ),
                SizedBox(height: 10),
                Center(
                  child: Text(
                    widget.editProfile?.fullName ?? '',
                    style: TxtStyle.font24W600Black,
                  ),
                ),
                Text("Member since 2021", style: TxtStyle.font16W400Regular),
                SizedBox(height: 20),
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
                  child: Column(
                    children: [
                      CustomTextField(
                        controller: nameController,
                        hintText: "Full Name",
                        textInput: (val) {
                          return null;
                        },
                        prefixIcon: null,
                      ),
                      Divider(height: 24),
                      CustomTextField(
                        textInput: (val) {
                          return null;
                        },
                        controller: emailController,
                        hintText: "Email Address",
                      ),

                      Divider(height: 24),
                      CustomTextField(
                        textInput: (val) {
                          return null;
                        },
                        controller: phoneController,
                        hintText: "Phone Number",
                      ),
                      Divider(height: 24),

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

                      SizedBox(height: 30),
                    ],
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
    );
  }
}
