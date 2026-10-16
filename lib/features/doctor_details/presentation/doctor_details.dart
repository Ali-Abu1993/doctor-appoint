import 'package:dio/dio.dart';
import 'package:doctor_appointment/core/constance/api_const.dart';
import 'package:doctor_appointment/core/constance/available_doctors.dart';
import 'package:doctor_appointment/core/helper/cache_helper.dart';
import 'package:doctor_appointment/core/mock_data/logic/mock_all_doctors_cubit.dart';
import 'package:doctor_appointment/core/routing/routes.dart';
import 'package:doctor_appointment/core/utils/text_style.dart';
import 'package:doctor_appointment/core/widgets/app_button.dart';
import 'package:doctor_appointment/core/widgets/available_time.dart';
import 'package:doctor_appointment/core/widgets/calendar.dart';
import 'package:doctor_appointment/features/alldoctors/logic/all_doctor_state.dart';
import 'package:doctor_appointment/features/doctor_details/logic/store_appointment_cubit.dart';
import 'package:doctor_appointment/features/doctor_details/logic/store_appointment_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class DoctorDetails extends StatelessWidget {
  const DoctorDetails({
    super.key,
    this.selectedTimeSlot,
    required this.docImage,
    required this.docName,
    required this.docExperience,
    this.docLanguage = "English, Spanish",
    required this.doctorIndex,
    required this.docDescription,
    required this.docSpeciality,
    required this.docEmail,
    required this.docPhoneNumber,
    required this.startTime,
    required this.endTime,
    required this.doctorAddress,
  });

  final String docImage;
  final String docName;
  final String docEmail;
  final String docExperience;
  final String docSpeciality;
  final String docLanguage;
  final String docDescription;
  final String docPhoneNumber;
  final String doctorAddress;
  final String startTime;
  final String endTime;
  final int doctorIndex;
  final String? selectedTimeSlot;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("DocPoint", style: TxtStyle.font20W700Blue),
        centerTitle: true,

        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: InkWell(child: Icon(Icons.notifications_none_outlined)),
          ),

          SizedBox(width: 0),
        ],
        leading: IconButton(
          onPressed: () {
            context.pop();
          },
          icon: Icon(Icons.arrow_back),
        ),
      ),

      body: MultiBlocProvider(
  providers: [
    BlocProvider(
        create: (context) => MockAllDoctorsCubit()..getAllDoctors(),
),
    BlocProvider(
      create: (context) => StoreAppointmentCubit(),
    ),
  ],
  child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 20),
                    child: BlocBuilder<MockAllDoctorsCubit, AllDoctorsStates>(
                      builder: (context, state) {
                        if (state is AllDoctorLoadingState) {
                          return Center(child: CircularProgressIndicator());
                        }
                        if (state is AllDoctorSuccessState) {
                          return Card(
                            elevation: 0,
                            color: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                              side: BorderSide(
                                color: Colors.grey.shade300,
                                width: 1,
                              ),
                            ),
                            margin: EdgeInsets.symmetric(horizontal: 20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              spacing: 5,
                              children: [
                                SizedBox(height: 20),
                                CircleAvatar(
                                  radius: 60,
                                  child: ClipRRect(
                                    borderRadius: BorderRadiusGeometry.circular(
                                      50,
                                    ),
                                    child: Transform.scale(
                                      scale: 1.65,
                                      child: Image.network(
                                        docImage,
                                        fit: BoxFit.contain,
                                        alignment: Alignment.center,
                                        errorBuilder:
                                            (context, error, stackTrace) {
                                              return const Icon(
                                                Icons.account_circle,
                                                size: 50,
                                                color: Colors.grey,
                                              );
                                            },
                                      ),
                                    ),
                                  ),
                                ),
                                Text(docName, style: TxtStyle.font24W600Black),

                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.star,
                                      color: Colors.amberAccent,
                                      size: 16,
                                    ),
                                    Text(
                                      "4.9 (124 reviews)",
                                      style: TxtStyle.font14W700,
                                    ),
                                  ],
                                ),
                                Text(docEmail, style: TxtStyle.font14W700),
                                Text(
                                  docPhoneNumber,
                                  style: TxtStyle.font14W700,
                                ),
                                Text(
                                  docSpeciality,
                                  style: TxtStyle.font16Medium,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  spacing: 5,
                                  children: [
                                    Container(
                                      width: 100,
                                      height: 24,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(
                                          9,
                                        ),
                                        color: Color.fromRGBO(
                                          121,
                                          242,
                                          240,
                                          0.3,
                                        ),
                                      ),
                                      child: Center(
                                        child: Text(
                                          docExperience,
                                          style: TxtStyle.font12W500,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      width: 130,
                                      height: 24,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(
                                          9,
                                        ),
                                        color: Color.fromRGBO(
                                          121,
                                          242,
                                          240,
                                          0.3,
                                        ),
                                      ),
                                      child: Center(
                                        child: Text(
                                          "$startTime-$endTime",
                                          style: TxtStyle.font12W500,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 20),
                              ],
                            ),
                          );
                        }
                        if (state is AllDoctorErrorState) {
                          return Text(state.error);
                        }
                        return SizedBox();
                      },
                    ),
                  ),
                  SizedBox(height: 5),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    child: Column(
                      spacing: 5,

                      crossAxisAlignment: CrossAxisAlignment.start,

                      children: [
                        Text("About", style: TxtStyle.font18SemiBold),

                        Text(
                          "$docDescription\t$docSpeciality\t$docExperience\n"
                          "Languages: $docLanguage\n"
                          "Address is '$doctorAddress'\n"
                          "Available between: $startTime-$endTime",
                          style: TxtStyle.font14RegularBlue,
                        ),
                        SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Select Date", style: TxtStyle.font18SemiBold),
                            TextButton(
                              onPressed: () {},
                              child: Text("choose date"),
                            ),
                          ],
                        ),

                        Calendar(),
                        SizedBox(height: 10),
                        Text("Available Time", style: TxtStyle.font18SemiBold),
                        SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Icon(Icons.light_mode_outlined),
                            SizedBox(width: 3),
                            Text("Morning", style: TxtStyle.font14SemiBold),
                          ],
                        ),

                        BlocBuilder<MockAllDoctorsCubit, AllDoctorsStates>(
                          builder: (context, state) {
                            if (state is AllDoctorLoadingState) {
                              return Center(child: CircularProgressIndicator());
                            }
                            if (state is AllDoctorSuccessState) {
                              final currentDoctor =
                                  state.doctorModel.data![doctorIndex];

                              return AvailableTime(
                                timeSlots: generateMorningSlots(
                                  currentDoctor.startTime,
                                  currentDoctor.endTime,
                                ),
                              );
                            }
                            if (state is AllDoctorErrorState) {
                              return Text(state.error);
                            }
                            return SizedBox(height: 0);
                          },
                        ),

                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Icon(Icons.nightlight_outlined),
                            SizedBox(width: 3),
                            Text("Evening", style: TxtStyle.font14SemiBold),
                          ],
                        ),
                        SizedBox(height: 10),
                        BlocBuilder<MockAllDoctorsCubit, AllDoctorsStates>(
                          builder: (context, state) {
                            if (state is AllDoctorLoadingState) {
                              return Center(child: CircularProgressIndicator());
                            }
                            if (state is AllDoctorSuccessState) {
                              final currentDoctor =
                                  state.doctorModel.data![doctorIndex];
                              return AvailableTime(
                                timeSlots: getEveningSlots(
                                  currentDoctor.startTime,
                                  currentDoctor.endTime,
                                ),
                              );
                            }
                            if (state is AllDoctorErrorState) {
                              return Text(state.error);
                            }
                            return SizedBox();
                          },
                        ),
                        BlocConsumer<
                          StoreAppointmentCubit,
                          StoreAppointmentStates
                        >(
                          listener: (context, state) {
                            if (state is StoreLoadingState) {
                              // 2.show dialog
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return const Center(
                                    child: CircularProgressIndicator(),
                                  );
                                },
                                barrierDismissible: false,
                                // important for modal dialog
                              );
                            } else if ( state is StoreSuccessState){
                              ScaffoldMessenger.of(context).
                              showSnackBar(SnackBar(content: Text('Booking is completed'),
                                backgroundColor:Colors.green ,behavior: SnackBarBehavior.floating,));
                              context.pop();
                            }
                            if (state is StoreErrorState) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(state.message),
                                  backgroundColor: Colors.red,
                                  behavior: SnackBarBehavior.floating,
                                ),
                              );
                              context.pop();
                            }
                          },
                          builder: (context, state) {
                            bool isLoading = state is StoreLoadingState ;
                            return SafeArea(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 16,
                                ),
                                child: AppButton(
                                  barWidth: double.infinity,
                                  txt: isLoading
                                      ? "Loading..."
                                      : "Confirm appointment",
                                  onPress: isLoading
                                      ? (){}
                                      : () {
                                          if (selectedTimeSlot == null) {
                                            ScaffoldMessenger.of(
                                              context,
                                            ).showSnackBar(
                                              SnackBar(
                                                content: Text(
                                                  "Please select a time slot",
                                                ),
                                              ),
                                            );
                                            return;
                                          }
                                          context.read<StoreAppointmentCubit>().storeAppointment();
                                        },
                                ),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
),
    );
  }
}
