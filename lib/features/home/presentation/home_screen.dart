import 'package:doctor_appointment/core/helper/debounce.dart';
import 'package:doctor_appointment/core/mock_data/data/all_doctors_mock_data.dart';
import 'package:doctor_appointment/core/mock_data/logic/mock_all_doctors_cubit.dart';
import 'package:doctor_appointment/core/mock_data/logic/mock_home_cubit.dart';
import 'package:doctor_appointment/core/routing/navigation_cubit.dart';
import 'package:doctor_appointment/core/routing/routes.dart';
import 'package:doctor_appointment/core/utils/colors_manager.dart';
import 'package:doctor_appointment/core/utils/text_style.dart';
import 'package:doctor_appointment/core/widgets/app_text_field.dart';
import 'package:doctor_appointment/core/widgets/doctor_card.dart';
import 'package:doctor_appointment/core/widgets/main_layout.dart';
import 'package:doctor_appointment/features/home/data/list_view_speciality.dart';
import 'package:doctor_appointment/features/home/logic/recomended_doctors_states.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../data/doctors_model.dart';

class HomeScreen extends StatelessWidget {
   HomeScreen({super.key});

  final searchController = TextEditingController();
  final debounce = Debounce();
String getGreeting(){
  final hour =DateTime.now().hour;
  if (hour<12 ){
    return 'Good Morning!';
  } else if(hour<17){
    return 'Good Afternoon!';
  } else {
    return 'Good Evening!';
  }
}


  @override
  Widget build(BuildContext context) {
  final String greeting = getGreeting();
  final user= FirebaseAuth.instance.currentUser;
  final String? photoUrl = user?.photoURL;
  final userName = user?.displayName ?? user?.email?.split("@")[0] ?? 'user';
    return MultiBlocProvider(
      providers: [

        BlocProvider(
          create: (context) =>
          MockHomeCubit()
            ..getDoctorsDetails(),
        ),
        BlocProvider(
          create: (context) =>
          MockAllDoctorsCubit()
            ..getAllDoctors(),
        ),
        BlocProvider(create: (_)=> NavigationCubit())
      ],
      child: Scaffold(
        appBar: AppBar(
          leading: Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(
              onPressed: () {
                context.pushNamed(AppRouter.kProfileScreen);
              },
              icon:
              CircleAvatar( radius: 15,
                  backgroundImage: photoUrl != null && photoUrl.isNotEmpty?
                  NetworkImage(photoUrl):null,
                   backgroundColor: ColorsManager.primary),
            ),
          ),
          title: Text("DocPoint", style: TxtStyle.font20W700Blue),
          centerTitle: true,
          actions: [
            IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.notifications_none_outlined,
                color: ColorsManager.primary,
              ),
            ),
          ],
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 5,),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Text(greeting, style: TxtStyle.font12W500),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Text("Hello, $userName!", style: TxtStyle.font18SemiBold),
                  ),
                  SizedBox(height: 25),
                  Center(
                    child: CustomTextField(
                      hintText: 'Search doctors, specialties, clinics...',
                      controller: searchController,
                      textInput: (value) {
                        return;
                      },
                      query: (value) {
                        debounce.call(() {
                          if (value.isNotEmpty) {
                            context.read<MockAllDoctorsCubit>().getSearchDoctors(
                                doctorName: value);
                          }
                          else {
                            context.read<MockAllDoctorsCubit>().getAllDoctors();
                          }
                        });
                      },
                      prefixIcon: Icons.search,
                      suffixIcon: Icon(Icons.tune_rounded),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Specialities", style: TxtStyle.font18SemiBold),
                        TextButton(
                          onPressed: () {},
                          child: Text("see all", style: TxtStyle.font12W500),
                        ),
                      ],
                    ),
                  ),
                  ListViewSpeciality(),
                  SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Recommended Doctors", style: TxtStyle.font18SemiBold),
                        TextButton(
                          onPressed: () {},
                          child: Text("view all", style: TxtStyle.font12W500),
                        ),
                      ],
                    ),
                  ),
                  BlocBuilder<MockHomeCubit, DoctorsStates>(
                    builder: (context, state) {
                      if (state is DoctorsLoadingState) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      if (state is DoctorsSuccessState) {
                        final List<DoctorModel> doctorList = state.doctors;
                        return ListView.builder(
                          itemCount: doctorList.length,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            final doctor =doctorList[index];

                            return SizedBox(
                              height: 370,
                              child: DoctorCard(
                                photo: doctor.image,
                                doctorName: doctor.name,
                                speciality: doctor.specialization?.name ??
                                    "cardiology ",
                                address: '',
                                isAvailable: true,
                                doctorIndex: index,
                                doctorData: doctor,
                              ),
                            );
                          },
                        );
                      }
                      if (state is DoctorsErrorState) {
                        return Text(state.message);
                      }
                      return SizedBox();
                    },
                  ),

                ],
              ),
            ),
          ),
        ),

        bottomNavigationBar: BlocBuilder<NavigationCubit, NavigationState>(
          builder: (context, state) {
            final currentIndex1 = context.watch<NavigationCubit>().currentIndex;
            return MainLayout();
          },
        ),
      ),
    );
  }
}
