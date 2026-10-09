import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:doctor_appointment/features/alldoctors/logic/all_doctor_state.dart';
import 'package:doctor_appointment/core/mock_data/data/all_doctors_mock_data.dart';

class MockAllDoctorsCubit extends Cubit<AllDoctorsStates> {
  MockAllDoctorsCubit() : super(AllDoctorInitialState());

  Future<void> getAllDoctors() async {
    emit(AllDoctorLoadingState());
    await Future.delayed(const Duration(milliseconds: 300));
    emit(AllDoctorSuccessState(doctorModel: AllDoctorsMockData.getDoctorsResponse()));
  }

  Future<void> getSearchDoctors({required String doctorName}) async {
    emit(AllDoctorLoadingState());
    await Future.delayed(const Duration(milliseconds: 200));
    final searchResult = AllDoctorsMockData.searchDoctors(doctorName);
    emit(AllDoctorSuccessState(doctorModel: searchResult));
  }
}
