import 'package:doctor_appointment/core/helper/debounce.dart';
import 'package:doctor_appointment/core/mock_data/logic/mock_all_doctors_cubit.dart';
import 'package:doctor_appointment/core/utils/colors_manager.dart';
import 'package:doctor_appointment/core/utils/text_style.dart';
import 'package:doctor_appointment/core/widgets/app_text_field.dart';
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
            // appBar: AppBar(
            //   backgroundColor: ColorsManager.primary,
            //   actions: [
            //     CustomTextField(
            //       hintText: 'Search doctors, specialties, clinics...',
            //       controller: searchController,
            //       textInput: (value) {
            //         return;
            //       },
            //       query: (value) {
            //         debounce.call(() {
            //           if (value.isNotEmpty) {
            //             context.read<MockAllDoctorsCubit>().getSearchDoctors(
            //               doctorName: value,
            //             );
            //           } else {
            //             context.read<MockAllDoctorsCubit>().getAllDoctors();
            //           }
            //         });
            //       },
            //       prefixIcon: Icons.search,
            //       suffixIcon: !isActive
            //           ? null
            //           : Icon(Icons.close, color: Colors.grey),
            //     ),
            //   ],
            // ),
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.transparent,
                    foregroundColor: Colors.blue,
                    child: IconButton(onPressed: (){
                      context.pop();
                    }, icon: Icon(Icons.arrow_back, color: ColorsManager.primary,)),
                  ),
                  SizedBox(width: 5,),
                  Expanded(
                    child: Container(
                      height: 40,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        border: Border.all(width: 0.2, color: ColorsManager.primary)
                      ),
                      child: TextFormField(
                        onTap: (){
                          setState(() {
        
                          });
                        },
                        controller: searchController,
                        onChanged: (value){
                          setState(() {
                            hasText = value.isNotEmpty;
                          });
                          debounce.call((){
                            if(value.isNotEmpty){
                              context.read<MockAllDoctorsCubit>().
                              getSearchDoctors(doctorName: value);
                            } else {
                              context.read<MockAllDoctorsCubit>().getAllDoctors();
                            }
                          });
                        },
                        decoration: InputDecoration(
                          hintText: 'Search doctors, specialties, clinics...',
                          prefixIcon: Icon(Icons.search),
                          prefixIconColor: Colors.grey,
                          suffixIcon:hasText?
                          IconButton(onPressed: (){
                            setState(() {
                              searchController.clear();
                              hasText=false;
                            });
                            context.read<MockAllDoctorsCubit>().getAllDoctors();
                          }, icon: Icon(Icons.close),color: Colors.grey,) : null,
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
