import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:doctor_appointment/features/home/logic/recomended_doctors_states.dart';
import 'package:doctor_appointment/core/mock_data/data/home_mock_data.dart';

class MockHomeCubit extends Cubit<DoctorsStates> {
  MockHomeCubit() : super(DoctorsInitialState());

  Future<void> getDoctorsDetails() async {
    emit(DoctorsLoadingState());
    await Future.delayed(const Duration(milliseconds: 300));
    emit(DoctorsSuccessState(HomeMockData.mockHomeDoctor));
  }
}
