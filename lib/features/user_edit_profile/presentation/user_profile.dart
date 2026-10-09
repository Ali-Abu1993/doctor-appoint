import 'package:doctor_appointment/core/helper/cache_helper.dart';
import 'package:doctor_appointment/core/mock_data/logic/mock_profile_cubit.dart';
import 'package:doctor_appointment/core/routing/navigation_cubit.dart';
import 'package:doctor_appointment/core/routing/routes.dart';
import 'package:doctor_appointment/core/utils/colors_manager.dart';
import 'package:doctor_appointment/core/utils/text_style.dart';
import 'package:doctor_appointment/core/widgets/app_button.dart';
import 'package:doctor_appointment/core/widgets/build_info_tile.dart';
import 'package:doctor_appointment/features/user_edit_profile/data/user_profile_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../logic/user_profile_states.dart';

class UserProfile extends StatelessWidget {
  const UserProfile({super.key});

  @override
  Widget build(BuildContext context) {
    
    return BlocProvider(
      create: (context) => MockProfileCubit()..fetchUserProfile(
          userToken: SecureStorageHelper.getToken().toString()),
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(onPressed: () {}, icon: Icon(Icons.arrow_back)),
          title: Text("Profile", style: TxtStyle.font14W700),
          centerTitle: true,

          actions: [
            InkWell(child: Icon(Icons.settings, color: ColorsManager.primary)),
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
              return SingleChildScrollView(
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
                      child: Text(user.fullName, style: TxtStyle.font24W600Black),
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
                        buildInfoTile(Icons.person_2_outlined, "Full Name", user.fullName),
                            Divider(height: 24,),
                            buildInfoTile(Icons.email_outlined, "Email Address", user.email),
                            Divider(height: 24,),
                            buildInfoTile(Icons.phone, "Phone Number", user.phoneNumber),
                            Divider(height: 24,),
                            buildInfoTile(Icons.transgender_outlined, "Gender", user.gender),
                            SizedBox(height: 30,)
                      ]),
                    ),
                    SizedBox(height: 20,),
                    AppButton(
                      barWidth: 300.w,
                    txt: "Edit your profile",
                  onPress:() {
                    context.push(AppRouter.editProfileScreen, extra: user);
                  },
                  icon: Icon(Icons.edit,color: Colors.white,),
                ),
                  SizedBox(height: 30,),
                  BottomNavigationBar(
            selectedItemColor: ColorsManager.secondary,
              unselectedItemColor: ColorsManager.unselectedIcon,
              unselectedLabelStyle: TxtStyle.font12W500,
              currentIndex: context.read<NavigationCubit>().currentIndex,
              onTap: (val){
                context.read<NavigationCubit>().changeIndex(val);
              },
              type: BottomNavigationBarType.fixed,
              items: [
            BottomNavigationBarItem(icon: InkWell(
              onTap: (){
                context.read<NavigationCubit>().changeIndex(0);
                context.pushNamed(AppRouter.kHomeScreen);
              },
              child:Icon(Icons.home_outlined)),label: "Home",),
            BottomNavigationBarItem(icon: InkWell(
              onTap: (){
                context.read<NavigationCubit>().changeIndex(1);
                context.pushNamed(AppRouter.kSearchScreen);
              },
              child:Icon(Icons.search)),label: "Search",
            backgroundColor:ColorsManager.unselectedIcon ),
            BottomNavigationBarItem(icon: InkWell(
              onTap: (){
                context.read<NavigationCubit>().changeIndex(2);
              },
              child: Icon(Icons.calendar_today_outlined)),label: "Booking"),
            BottomNavigationBarItem(
              icon: InkWell(
                onTap: (){
                  context.read<NavigationCubit>().changeIndex(3);
                },
                child: Icon(Icons.person)),label: "profile"),
          ]
          )

                  ],
                  
                ),
                
              );
            }
            return SizedBox();
          },
          
        ),
        
      ),
    );
  }
}
