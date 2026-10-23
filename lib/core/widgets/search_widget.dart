import 'package:doctor_appointment/core/helper/debounce.dart';
import 'package:doctor_appointment/core/mock_data/logic/mock_all_doctors_cubit.dart';
import 'package:doctor_appointment/core/utils/colors_manager.dart';
import 'package:doctor_appointment/core/utils/text_style.dart';
import 'package:doctor_appointment/core/widgets/app_text_field.dart';
import 'package:doctor_appointment/core/widgets/main_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class SearchWidget extends StatefulWidget {

  const SearchWidget({super.key,});

  @override
  State<SearchWidget> createState() => SearchWidgetState();
}

class SearchWidgetState extends State<SearchWidget> {
  final searchController = TextEditingController();
  final debounce = Debounce();
  bool hasText = false;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MockAllDoctorsCubit(),
      child: AnnotatedRegion<SystemUiOverlayStyle>(
        
        value: SystemUiOverlayStyle.dark.copyWith(
          statusBarColor: Colors.white,
          statusBarBrightness: Brightness.dark,
          statusBarIconBrightness: Brightness.light,
        ),
        child: SafeArea(
          child: Scaffold(
            appBar: PreferredSize(
              preferredSize: Size.fromHeight(80),
              child: AppBar(
                systemOverlayStyle: SystemUiOverlayStyle(
                  statusBarBrightness: Brightness.light,
                  statusBarColor: ColorsManager.primary,

                ),

                leadingWidth: double.infinity,
                elevation: 5,
                bottom: PreferredSize(preferredSize: Size.fromHeight(10),
                    child:  Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                      child: CustomTextField(
                        hintText: 'Search doctors, specialties, clinics...',
                        hintStyle: TextStyle(
                          color: Colors.grey.shade100,
                          fontSize: 12,
                          fontWeight: FontWeight.normal
                        ),
                        prefixColor: Colors.grey.shade100,
                        suffixColor: Colors.grey.shade100,
                        decoration: InputDecoration(

                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(color: Colors.grey.shade100,
                                style:BorderStyle.solid )
                          )
                        ),

                        controller: searchController,
                        textInput: (value) {
                          return;
                        },
                        mainColor: Colors.grey.shade100,

                        query: (value) {
                          setState(() {
                            hasText=value.isNotEmpty;
                          });
                          debounce.call(() {
                            if (value.isNotEmpty) {
                              context.read<MockAllDoctorsCubit>().getSearchDoctors(
                                doctorName: value,
                              );
                            } else {
                              context.read<MockAllDoctorsCubit>().getAllDoctors();
                            }
                          });
                        },
                        prefixIcon: Icons.search,
                        suffixIcon: hasText
                            ? IconButton(onPressed: (){
                          setState(() {
                            searchController.clear();
                            hasText=false;
                          });
                          context.read<MockAllDoctorsCubit>().getAllDoctors();
                        }
                          , icon: Icon(Icons.close),color: Colors.grey,)
                            : null,
                      ),
                    ),),


                backgroundColor: Colors.lightBlue.shade900,

              ),
            ),
            // body: Padding(
            //   padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
            //   child: Row(
            //     crossAxisAlignment: CrossAxisAlignment.start,
            //     children: [
            //       CircleAvatar(
            //         backgroundColor: Colors.transparent,
            //         foregroundColor: Colors.blue,
            //         child: IconButton(onPressed: (){
            //           context.pop();
            //         }, icon: Icon(Icons.arrow_back, color: ColorsManager.primary,)),
            //       ),
            //       SizedBox(width: 5,),
            //       Expanded(
            //         child: Container(
            //           height: 40,
            //           decoration: BoxDecoration(
            //             borderRadius: BorderRadius.circular(50),
            //             border: Border.all(width: 0.2, color: ColorsManager.primary)
            //           ),
            //           child: TextFormField(
            //             onTap: (){
            //               setState(() {
            //
            //               });
            //             },
            //             controller: searchController,
            //             onChanged: (value){
            //               setState(() {
            //                 hasText = value.isNotEmpty;
            //               });
            //               debounce.call((){
            //                 if(value.isNotEmpty){
            //                   context.read<MockAllDoctorsCubit>().
            //                   getSearchDoctors(doctorName: value);
            //                 } else {
            //                   context.read<MockAllDoctorsCubit>().getAllDoctors();
            //                 }
            //               });
            //             },
            //             decoration: InputDecoration(
            //               hintText: 'Search doctors, specialties, clinics...',
            //               prefixIcon: Icon(Icons.search),
            //               prefixIconColor: Colors.grey,
            //               suffixIcon:hasText?
            //               IconButton(onPressed: (){
            //                 setState(() {
            //                   searchController.clear();
            //                   hasText=false;
            //                 });
            //                 context.read<MockAllDoctorsCubit>().getAllDoctors();
            //               }, icon: Icon(Icons.close),color: Colors.grey,) : null,
            //               border: InputBorder.none,
            //             ),
            //           ),
            //         ),
            //       )
            //     ],
            //   ),
            // ),
            bottomNavigationBar: MainLayout(),
          ),
        ),
      ),
    );
  }
}
