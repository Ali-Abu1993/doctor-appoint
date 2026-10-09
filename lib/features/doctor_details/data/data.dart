class StoreAppointmentResponse{
final int doctorId;
final DateTime startTime;
final String notes; 

StoreAppointmentResponse({
  required this.doctorId,
  required this.startTime,
  required this.notes,
});

factory StoreAppointmentResponse.fromJson(Map<String,dynamic>json){
  return StoreAppointmentResponse(
    doctorId: json['doctor_id'],
    startTime: DateTime.parse(json['start_time']),
    notes: json['notes'],
  );
}

Map<String, dynamic> toJson() => {
  'doctor_id': doctorId,
  'start_time': startTime.toIso8601String(),
  'notes': notes,
};


}