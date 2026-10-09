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
import 'package:doctor_appointment/features/home/data/list_view_speciality.dart';
import 'package:doctor_appointment/features/home/logic/recomended_doctors_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final searchController = TextEditingController();
  final debounce = Debounce();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers:[

        BlocProvider(
          create: (context) => MockHomeCubit()..getDoctorsDetails(),
        ),
        BlocProvider(
          create: (context) => MockAllDoctorsCubit()..getAllDoctors(),
        ),
      ],
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {},
            icon: Icon(Icons.person, color: ColorsManager.primary),
          ),
          title: Text("DocPoint", style: TxtStyle.font24W600Black),
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
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 5,
            children: [
              Text("Good Morning", style: TxtStyle.font18SemiBold),
              Text("Hello, Sarah!", style: TxtStyle.font26W700Black),
              SizedBox(height: 5),
              CustomTextField(
                hintText: 'Search doctors, specialties, clinics...',
                controller: searchController,
                textInput: (value) {
                  return;
                },
                query: (value){
                  debounce.call((){
                    if(value.isNotEmpty){
                      context.read<MockAllDoctorsCubit>().getSearchDoctors(doctorName: value);
                    }
                    else{
                      context.read<MockAllDoctorsCubit>().getAllDoctors();
                    }
          
                  });
                },
                prefixIcon: Icons.search,
                suffixIcon: Icon(Icons.tune_rounded),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Specialities", style: TxtStyle.font18SemiBold),
                  TextButton(
                    onPressed: () {},
                    child: Text("see all", style: TxtStyle.font12W500),
                  ),
                ],
              ),
              ListViewSpeciality(),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Recommended Doctors", style: TxtStyle.font18SemiBold),
                  TextButton(
                    onPressed: () {},
                    child: Text("view all", style: TxtStyle.font12W500),
                  ),
                ],
              ),
              BlocBuilder<MockHomeCubit, DoctorsStates>(
                builder: (context, state) {
                  if (state is DoctorsLoadingState) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (state is DoctorsSuccessState) {
                    final doctorList = state.doctors;
                    return ListView.builder(
                      itemCount: 1,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return SizedBox(
                          height: 370,
                          child: DoctorCard(
                            photo: doctorList.image,
                            doctorName: doctorList.name,
                            speciality: doctorList.specialization?.name??"cardiology ",
                            address: '',
                            isAvailable: true,
                            doctorIndex: index,
                            doctorData: AllDoctorsMockData.doctorsList[index],
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
        bottomNavigationBar: BottomNavigationBar(
          selectedItemColor: ColorsManager.secondary,
          unselectedItemColor: ColorsManager.unselectedIcon,
          unselectedLabelStyle: TxtStyle.font12W500,
          currentIndex: context.read<NavigationCubit>().currentIndex,
          onTap: (val) {
            context.read<NavigationCubit>().changeIndex(val);
          },
          type: BottomNavigationBarType.fixed,
          items: [
            BottomNavigationBarItem(
              icon: InkWell(
                onTap: () {
                  context.read<NavigationCubit>().changeIndex(0);
                },
                child: Icon(Icons.home_outlined),
              ),
              label: "Home",
            ),
            BottomNavigationBarItem(
              icon: InkWell(
                onTap: () {
                  context.read<NavigationCubit>().changeIndex(1);
                  context.pushNamed(AppRouter.kSearchScreen);
                },
                child: Icon(Icons.search),
              ),
              label: "Search",
              backgroundColor: ColorsManager.unselectedIcon,
            ),
            BottomNavigationBarItem(
              icon: InkWell(
                onTap: () {
                  context.read<NavigationCubit>().changeIndex(2);
                },
                child: Icon(Icons.calendar_today_outlined),
              ),
              label: "Booking",
            ),
            BottomNavigationBarItem(
              icon: InkWell(
                onTap: () {
                  context.read<NavigationCubit>().changeIndex(3);
                  context.pushNamed(AppRouter.kProfileScreen);
                },
                child: Icon(Icons.person),
              ),
              label: "profile",
            ),
          ],
        ),
      ),
    );
  }
}
