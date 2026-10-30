import 'package:doctor_appointment/core/helper/cache_helper.dart';
import 'package:doctor_appointment/core/helper/dio_helper.dart';
import 'package:doctor_appointment/core/mock_data/logic/mock_profile_cubit.dart';
import 'package:doctor_appointment/core/routing/navigation_cubit.dart';
import 'package:doctor_appointment/core/routing/routes.dart';
import 'package:doctor_appointment/core/utils/app_extensions.dart';
import 'package:doctor_appointment/core/utils/colors_manager.dart';
import 'package:doctor_appointment/core/utils/text_style.dart';
import 'package:doctor_appointment/core/widgets/app_button.dart';
import 'package:doctor_appointment/core/widgets/custom_widgets/build_info_tile.dart';
import 'package:doctor_appointment/core/widgets/main_layout.dart';
import 'package:doctor_appointment/features/user_edit_profile/data/user_profile_model.dart';
import 'package:doctor_appointment/features/user_edit_profile/logic/profile_cubit.dart';
import 'package:doctor_appointment/l10n/app_localizations.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../logic/user_profile_states.dart';

class UserProfile extends StatelessWidget {
  const UserProfile({super.key});

  @override
  Widget build(BuildContext context) {
    late AppLocalizations local =context.l1on;
    
    return MultiBlocProvider(
  providers: [
    BlocProvider(
      create: (context) => MockProfileCubit()..fetchUserProfile(
          userToken: SecureStorageHelper.getToken().toString()),
),
    BlocProvider(
      create: (context) => NavigationCubit(),
    ),
    BlocProvider(create: (_)=> ProfileCubit(DioHelper()))
  ],
  child: Scaffold(

        appBar: AppBar(backgroundColor: context.colorTheme.background,
          leading: IconButton(onPressed: () {
            context.pop();
          }, icon: Icon(Icons.arrow_back,
            color:context.isDark? Colors.white70: Colors.white70)),
          title: Text(local.profile_title, style:context.isDark? TxtStyle.font20W700White:TxtStyle.font20W700White),
          centerTitle: true,

          actions: [
            InkWell(onTap: (){context.pushNamed(AppRouter.kSettingsScreen);},
                child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Icon(Icons.settings, color:context.isDark? Colors.white70: Colors.white70),
            )),
          ],
        ),
        body: BlocBuilder<MockProfileCubit, UserProfileStates>(
          builder: (context, state) {
            if (state is ProfileLoadingState) {
              return Center(child: CircularProgressIndicator());
            }
            if (state is ProfileErrorState) {
              return Text(state.message);
            }
            if (state is ProfileSuccessState) {
              final UserProfileModel user = state.user;
              final userName = FirebaseAuth.instance.currentUser;
              return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 30),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white,width: 4)
                        ),
                        child: CircleAvatar(
                          radius: 50,
                          backgroundImage:NetworkImage(userName?.photoURL ??
                          'assets/images_and_icons/stock-vector-a-faceless-male-doctor-avatar-with-a-stethoscope-in-a-flat-design-ideal-for-healthcare-medical-2644008685.jpg'
                          )
                                          ),
                      ),
                      SizedBox(height: 10),
                      Center(
                        child: Text(userName?.displayName ?? 'User',
                            style: TxtStyle.font24W600Black(context)),
                      ),
                      Text(local.member_since(userName?.metadata.creationTime!.year.toString() ?? ''),
                          style: TxtStyle.font16W400Regular),
                      SizedBox(height: 30),
                      Container(
                        width: 350.w,
                        height: 293.h,
                        padding: const EdgeInsets.all(20),
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
                        child: BlocBuilder<ProfileCubit, UserProfileStates>(
  builder: (context, state) {
    String gender = state is ProfileSuccessState? state.user.gender : local.not_specified;
    return Column(

                            children: [
                          buildInfoTile(Icons.person_2_outlined, local.full_name, userName?.displayName ?? 'User',
                          TxtStyle.font11BoldGrey,TxtStyle.font15W600DarkBlue),
                              Divider(height: 24,),
                              buildInfoTile(Icons.email_outlined, local.email_address, userName?.email ?? 'noemail@nodomain.com',
                              TxtStyle.font11BoldGrey, TxtStyle.font15W600DarkBlue),
                              Divider(height: 24,),
                              buildInfoTile(Icons.phone, local.phone_number, userName?.phoneNumber ?? '',
                              TxtStyle.font11BoldGrey,TxtStyle.font15W600DarkBlue),
                              Divider(height: 24,),
                              buildInfoTile(Icons.transgender_outlined, local.gender, gender,
                              TxtStyle.font11BoldGrey, TxtStyle.font15W600DarkBlue),

                        ]);
  },
),
                      ),
                      SizedBox(height: 20,),
                      AppButton(
                        barWidth: 300.w,
                      txt: local.edit_profile,
                    onPress:() {
                      context.push(AppRouter.editProfileScreen, extra: user);
                    },
                    icon: Icon(Icons.edit,color: Colors.white,),
                  ),



                    ],

                  ),
                ),

              );
              
            }
            return SizedBox();
          },
          
        ),
        bottomNavigationBar:  BlocBuilder<NavigationCubit, NavigationState>(
  builder: (context, state) {
    return MainLayout();
  },
)
      ),
);
  }
}
