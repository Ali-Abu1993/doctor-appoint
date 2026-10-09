import 'package:dio/dio.dart';
import 'package:doctor_appointment/core/constance/api_const.dart';
import 'package:doctor_appointment/core/helper/cache_helper.dart';
import 'package:doctor_appointment/features/auth/data/auth_response.dart';
import 'package:doctor_appointment/features/auth/data/login_body.dart';
import 'package:doctor_appointment/features/auth/logic/state.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../data/register_body.dart';

class AuthCubit extends Cubit<AuthStates>{
  AuthCubit() : super(AuthInitialState());

  Dio dio =Dio();

  Future register (RegisterBody body) async {
    emit((AuthLoadingState()));
    final response = await dio.post(ApiConst.registerURL,data:body.toJson());
    try{
      if (response.statusCode==200){
        final result = AuthResponse.fromJson(response.data);
        // FlutterSecureStorage storage =FlutterSecureStorage();
        // storage.write(key: "auth_token", value: result.data?.token);
        SecureStorageHelper.saveToken(result.data.token);
        emit(AuthSuccessState());
      }

    }catch(ex){
      emit(AuthErrorState(em: ex.toString()));
    }
  }
  Future login (LoginRequestBody body) async {
    emit((AuthLoadingState()));
    final response = await dio.post(ApiConst.loginURL,data:body.toJson());
    try{
      if (response.statusCode==200){
        final result = AuthResponse.fromJson(response.data);
        SecureStorageHelper.saveToken(result.data.token);
        emit(AuthSuccessState());
      }

    }catch(ex){
      emit(AuthErrorState(em: ex.toString()));
    }
  }
  final FirebaseAuth auth =FirebaseAuth.instance;
  final GoogleSignIn googleSignIn =GoogleSignIn.instance;
  Future<UserCredential?> signInWithGoogle() async{

    emit(AuthLoadingState());
    try {
      final GoogleSignInAccount googleUser = await googleSignIn.authenticate();
      
        final String? idToken =
          googleUser.authentication.idToken;

       final authorization = await googleUser.authorizationClient.authorizeScopes([
        'email','profile'
       ]);
       final String? accessToken = authorization.accessToken;
       final OAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: accessToken,
        idToken: idToken,
       );
       return await auth.signInWithCredential(credential);
       } on FirebaseAuthException catch (e){
        emit(AuthErrorState(em: e.message?? "Something went wrong"));
        return null;
      } catch (e) {
      emit(AuthErrorState(em: e.toString()));
      return null;
    }
  }
  Future signOut()async{
    await googleSignIn.signOut();
    await auth.signOut();
    
  }
  

}