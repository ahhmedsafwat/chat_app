part of 'auth_cubit.dart';

abstract class AuthCubitState {}

class AuthCubitInitial extends AuthCubitState {}

class LoginSuccess extends AuthCubitState {}

class LoginLoading extends AuthCubitState {}

class LoginFailure extends AuthCubitState {
  String errorMassage;

  LoginFailure({required this.errorMassage});
}

class RegisterSuccess extends AuthCubitState {}

class RegisterFailure extends AuthCubitState {
  String errorMassage;

  RegisterFailure({required this.errorMassage});
}

class RegisterLoading extends AuthCubitState {}
