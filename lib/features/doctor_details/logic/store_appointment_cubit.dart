import 'package:dio/dio.dart';
import 'package:doctor_appointment/core/constance/api_const.dart';
import 'package:doctor_appointment/core/helper/cache_helper.dart';
import 'package:doctor_appointment/features/doctor_details/logic/store_appointment_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class StoreAppointmentCubit extends Cubit<StoreAppointmentStates> {
  StoreAppointmentCubit() : super(StoreInitialState());

  void storeAppointment() async {
    emit(StoreLoadingState());
    try {
      final token = await SecureStorageHelper.getToken();
      final dio = Dio();
      final response =await dio.post(
        ApiConst.storeAppointmentURL,
        data: {
          'doctor_id': 1,
          'start_time': '2026-10-11 10:00:00',
          'notes': 'standard appointment',
        },
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Accept': 'application/json',
          },
        ),
      );
      if(response.statusCode ==200){
      emit(StoreSuccessState());
      }
    } on DioException catch (e){
      final message = e.response?.data['message'] ?? e.message ?? 'Booking Failed!';
      emit(StoreErrorState(message: message));
    }
    catch (ex) {
      print(ex.toString());
      emit(StoreErrorState(message: ex.toString()));
    }
  }
}
