class StoreAppointmentStates {}
class StoreIntialState extends StoreAppointmentStates{}
class StoreLoadingState extends StoreAppointmentStates{}
class StoreSuccessState extends StoreAppointmentStates{}
class StoreErrorState extends StoreAppointmentStates{
  final String message;
  StoreErrorState({required this.message});
}