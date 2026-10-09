import 'package:doctor_appointment/core/helper/dio_helper.dart';
import 'package:doctor_appointment/features/home/logic/recomended_doctors_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DoctorsCubit extends Cubit<DoctorsStates> {
  final DioHelper apiService;
  DoctorsCubit(this.apiService):super(DoctorsInitialState());

  void getDoctorsDetails()async{
    emit(DoctorsLoadingState());
  try{
    final doctor= (await apiService.getHomeData()) ;
    emit(DoctorsSuccessState(doctor));

  }catch(error){
    emit(DoctorsErrorState('$error : error Fetching data'));
  }
  }

}