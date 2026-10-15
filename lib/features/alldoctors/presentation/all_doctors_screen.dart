import 'package:doctor_appointment/core/constance/available_doctors.dart';
import 'package:doctor_appointment/core/helper/debounce.dart';
import 'package:doctor_appointment/core/mock_data/logic/mock_all_doctors_cubit.dart';
import 'package:doctor_appointment/core/routing/routes.dart';
import 'package:doctor_appointment/core/utils/colors_manager.dart';
import 'package:doctor_appointment/core/utils/text_style.dart';
import 'package:doctor_appointment/core/widgets/app_text_field.dart';
import 'package:doctor_appointment/core/widgets/main_layout.dart';
import 'package:doctor_appointment/features/alldoctors/logic/all_doctor_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../core/widgets/doctor_card.dart';

class AllDoctorsScreen extends StatefulWidget {
  const AllDoctorsScreen({super.key});

  @override
  State<AllDoctorsScreen> createState() => _AllDoctorsScreenState();
}

class _AllDoctorsScreenState extends State<AllDoctorsScreen> {
  final doctorDetails = TextEditingController();
  final debounce = Debounce(milliseconds: 500);

  @override
  void dispose() {
    doctorDetails.text;
    debounce.dispose();
    super.dispose();
  }

int selectedIndex =0;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MockAllDoctorsCubit()..getAllDoctors(),
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "Find a Doctor",
            style:TxtStyle.font20W700Blue
          ),
          centerTitle: true,
          backgroundColor: Colors.white,
          actions: [
            InkWell(
              onTap: () {},
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Icon(Icons.notifications_none, color: ColorsManager.primary,),
              ),
            ),
          ],
          leading: IconButton(onPressed: (){
            context.pop();
          }, icon: Icon(Icons.arrow_back,
          color: ColorsManager.primary,)),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                child: Builder(
                  builder: (context) {
                    return CustomTextField(
                      hintText: "Cardiologist",
                      controller: doctorDetails,
                      textInput: (value) {
                        return null;
                      },
                      query: (value) {
                        debounce.call(
                          () {
                            if(value.isNotEmpty){
                             context.read<MockAllDoctorsCubit>().getSearchDoctors(doctorName: value);
                          }
                            else{
                              context.read<MockAllDoctorsCubit>().getAllDoctors();
                            }
                          },
                        );
                      },
                      prefixIcon: Icons.search,
                      suffixIcon: Icon(Icons.mic),
                    );
                  },
                ),
              ),
               SingleChildScrollView(
                 child: ListView(
                    shrinkWrap: true,
                    physics:const NeverScrollableScrollPhysics(),
                 
                    children: [
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            Align(
                              alignment: Alignment.centerLeft,
                              child: SizedBox(width: 122,
                                child: ElevatedButton.icon(style: ElevatedButton.styleFrom(
                                    iconColor:Color.fromRGBO(0, 110, 109, 1),
                                    iconAlignment: IconAlignment.start
                                ),
                                    onPressed: (){},
                                  icon: Icon(Icons.filter_alt_outlined),
                                  label: const Text("Filters (2)",
                                  maxLines: 1, overflow: TextOverflow.ellipsis,),
                                    ),
                              ),
                            ),
                            SizedBox(width: 5,),
                            Align(
                              alignment: Alignment.center,
                              child: SizedBox(width: 122,
                                child: ElevatedButton(style: ElevatedButton.styleFrom(

                                ),
                                  onPressed: (){}, child: Text("Rating 4.5+",
                                    maxLines:1 ,overflow: TextOverflow.ellipsis,textAlign: TextAlign.center,
                                  softWrap: false,),),
                              ),
                            ),
                            SizedBox(width: 5,),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: SizedBox(width: 122,
                                child: ElevatedButton(style: ButtonStyle(),
                                  onPressed: (){}, child: Text("Distance: < 5mi",
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,),),
                              ),
                            ),
                            SizedBox(width: 5,),
                            Align(
                              alignment: Alignment.center,
                              child: ElevatedButton(style: ElevatedButton.styleFrom(
                                  fixedSize: Size(122, 40)
                              ),
                                onPressed: (){}, child: Text(""),),
                            ),
                          ],
                        ),
                      ),
                 
                 
                 
                    ],
                  ),
               ),


              BlocBuilder<MockAllDoctorsCubit, AllDoctorsStates>(
                builder: (context, state) {
                  if (state is AllDoctorLoadingState) {
                    return Center(child: CircularProgressIndicator());
                  }
                  if (state is AllDoctorSuccessState) {
                    final path = state.doctorModel;

                    return
                       ListView.separated(
                         shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: path.data!.length,
                        separatorBuilder: (context, index) =>
                            const SizedBox(height: 0),
                        itemBuilder: (BuildContext context, int index) {
                          final  currentDoctor = state.doctorModel.data![index];
                          final checkGender = state.doctorModel.data![index].gender!;
                          return SizedBox(
                            height: 370,
                            child: DoctorCard(
                              doctorData: currentDoctor,
                              doctorIndex:index ,
                              photo:(checkGender=="male")?"assets/images_and_icons/stock-vector-a-faceless-male-doctor-avatar-with-a-stethoscope-in-a-flat-design-ideal-for-healthcare-medical-2644008685.jpg":
                              "assets/images_and_icons/stock-vector-a-faceless-female-doctor-avatar-with-a-stethoscope-in-a-flat-design-circular-frame-ideal-for-2644131371.jpg",
                              doctorName: state.doctorModel.data![index].name!,
                              appointPrice: path.data![index].appointPrice,
                              address: path.data![index].address!,
                              speciality: path.data![index].specialization!.name!,
                              isAvailable: AvailableDoctors.checkAvailability(path.data![index].startTime, path.data![index].endTime),

          
                            ),
                          );
                        },
                      );
          
                  }
                  if (state is AllDoctorErrorState) {
                    return Text(state.error);
                  }
                  return SizedBox();
                },
              ),
            ],
          ),
        ),

          bottomNavigationBar: MainLayout()
      ),
    );
  }
}
