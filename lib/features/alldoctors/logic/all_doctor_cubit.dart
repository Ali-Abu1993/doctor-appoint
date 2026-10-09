import 'package:dio/dio.dart';
import 'package:doctor_appointment/core/constance/api_const.dart';
import 'package:doctor_appointment/core/helper/cache_helper.dart';
import 'package:doctor_appointment/features/alldoctors/data/doctor_model.dart';
import 'package:doctor_appointment/features/alldoctors/logic/all_doctor_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AllDoctorCubit extends Cubit<AllDoctorsStates> {
  AllDoctorCubit() :super(AllDoctorInitialState());
  Dio dio = Dio();
  Future getAllDoctors()async{
    emit(AllDoctorLoadingState());
    try{
      print("1: قبل استدعاء التوكن");
      final token = await SecureStorageHelper.getToken();
      print("2: بعد استدعاء التوكن: $token"); // إذا لم يطبع هذا السطر فالـ Storage معلق
       final response =await dio.get(ApiConst.allDoctorsURL,options: Options(headers: {
         "Authorization": "Bearer $token"
       }));
       if(response.statusCode==200){
      final result= DoctorsModel.fromJson(response.data);
      emit(AllDoctorSuccessState(doctorModel: result));
       }
    }catch(ex){
      emit(AllDoctorErrorState(error: ex.toString()));
    }

  }
  Future getSearchDoctors({required String doctorName})async{
    emit(AllDoctorLoadingState());

    try{
      print("1: قبل استدعاء التوكن");
      final token = await SecureStorageHelper.getToken();
      print("2: بعد استدعاء التوكن: $token"); // إذا لم يطبع هذا السطر فالـ Storage معلق
    print("My Device Token is: $token");
    final response = await dio.get(ApiConst.searchDoctorsURL,queryParameters: {'name': doctorName},
        options: Options(
      headers: {

        "Authorization":"Bearer $token"
      }
    ));


      if(response.statusCode==200){
        final result =DoctorsModel.fromJson(response.data);
        emit(AllDoctorSuccessState(doctorModel: result));
      }

    }on DioException catch (e) {
      // هذه السطور ستطبع لك تفاصيل السيرفر والـ JSON في الـ Console الحالي
      print("Status Code: ${e.response?.statusCode}");
      print("Server Response JSON: ${e.response?.data}");
      emit(AllDoctorErrorState(error: e.toString()));
    }
  }
}