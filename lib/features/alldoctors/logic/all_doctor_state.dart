import 'package:doctor_appointment/features/alldoctors/data/doctor_model.dart';

class AllDoctorsStates{}
class AllDoctorInitialState extends AllDoctorsStates{}
class AllDoctorLoadingState extends AllDoctorsStates{}
class AllDoctorSuccessState extends AllDoctorsStates{
  DoctorsModel doctorModel;
  AllDoctorSuccessState({required this.doctorModel});
}
class AllDoctorErrorState extends AllDoctorsStates{
  String error;
  AllDoctorErrorState({required this.error});
}