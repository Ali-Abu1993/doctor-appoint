import 'package:doctor_appointment/features/home/data/doctors_model.dart';

class DoctorsStates {}
class DoctorsInitialState extends DoctorsStates{}
class DoctorsLoadingState extends DoctorsStates{}
class DoctorsSuccessState extends DoctorsStates{
final List<DoctorModel> doctors;
DoctorsSuccessState(this.doctors);
}
class DoctorsErrorState extends DoctorsStates{
  final String message;
  DoctorsErrorState(this.message);
}