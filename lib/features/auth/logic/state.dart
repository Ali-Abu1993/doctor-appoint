import 'package:firebase_auth/firebase_auth.dart';

class AuthStates{}
class AuthInitialState extends AuthStates{}
class AuthLoadingState extends AuthStates{}
class AuthSuccessState extends AuthStates{
final UserCredential? userCredential;
AuthSuccessState({ this.userCredential});
}
class AuthErrorState extends AuthStates{
  final String em;
  AuthErrorState({required this.em});
}