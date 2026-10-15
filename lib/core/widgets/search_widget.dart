import 'package:doctor_appointment/core/helper/debounce.dart';
import 'package:doctor_appointment/core/mock_data/logic/mock_all_doctors_cubit.dart';
import 'package:doctor_appointment/core/utils/text_style.dart';
import 'package:doctor_appointment/core/widgets/app_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchWidget extends StatefulWidget {
  const SearchWidget({super.key});

  @override
  State<SearchWidget> createState() => SearchWidgetState();
}

class SearchWidgetState extends State<SearchWidget> {
  final searchController = TextEditingController();
  final debounce = Debounce();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MockAllDoctorsCubit(),
      child: Scaffold(
        appBar: AppBar(title: Center(child: Text("Search Doctor", style: TxtStyle.font16W400Regular))),
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CustomTextField(
                hintText: 'Search doctors, specialties, clinics...',
                controller: searchController,
                textInput: (value) {
                  return;
                },
                query: (value) {
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
                suffixIcon: Icon(Icons.delete, color: Colors.grey,),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
