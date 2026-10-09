import 'package:dio/dio.dart';
import 'package:doctor_appointment/core/constance/api_const.dart';
import 'package:doctor_appointment/features/auth/data/auth_response.dart';
import 'package:doctor_appointment/features/home/data/doctors_model.dart';



class DioHelper {

  final Dio dio = Dio(
    BaseOptions(
      baseUrl: 'https://vcare.integration25.com/api',
      headers: {
        'Accept': 'application/json',
      },
    ),
  );




   Future postData(String url, Map<String,dynamic> data) async{

    try{
      final response = await dio.post(url, data:data );
      if(response.statusCode ==200){
        return AuthResponse.fromJson(response.data);
      }

    }catch(ex){
      rethrow;
    }


  }
   Future getData (String url) async{
    try{
      final response= await dio.get(url);
      if (response.statusCode ==200){
        return AuthResponse.fromJson(response.data);
      }

    }catch(ex){
      rethrow;
    }
  }
  Future<Response> getUserProfile({required String token})async{
    return await  dio.get(ApiConst.getProfileURL,
        options: Options(
          headers: {
            'Authorization': 'Bearer $token'
          },
        ),);
  }
  Future<Response> updateUserProfile({required String token, required Map<String,dynamic> data})async{
    return await dio.post(ApiConst.updateProfileURL,data: data,options: Options(
      headers: {
        'Authorization':'Bearer $token'
      }
    ));
  }
  Future<DoctorModel> getHomeData() async{
    final response= await dio.get(ApiConst.homeURL);
    return DoctorModel.fromJson(response.data);
  }
}