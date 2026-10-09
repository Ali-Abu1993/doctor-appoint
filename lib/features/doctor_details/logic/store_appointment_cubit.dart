import 'package:dio/dio.dart';
import 'package:doctor_appointment/core/constance/api_const.dart';
import 'package:doctor_appointment/core/helper/cache_helper.dart';
import 'package:doctor_appointment/features/doctor_details/logic/store_appointment_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class StoreAppointmentCubit extends Cubit<StoreAppointmentStates>{
  StoreAppointmentCubit():super(StoreIntialState());

  void storeAppointment()async{
    emit(StoreLoadingState());
    try{
    final token= await SecureStorageHelper.getToken();
    final dio =Dio();
     await dio.post(ApiConst.storeAppointmentURL,
    data: {
    'doctor_id': 1,
    'start_time': '2026-10-11 10:00:00',
    'notes': 'standard appointment',
    },
    options: Options(
    headers: {
    'Authorization': 'Bearer $token',
    'Accept':'application/json',
    },
    ),
                                   
    );
    
                               

                            
    }catch(ex){
      print(ex.toString());
      emit(StoreErrorState(message: ex.toString()));
    }
  }
  
}