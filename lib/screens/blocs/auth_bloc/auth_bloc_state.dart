part of 'auth_bloc.dart';

abstract class AuthBlocState {}

class AuthBlocInitial extends AuthBlocState {}

class LoginSuccess extends AuthBlocState {}

class LoginLoading extends AuthBlocState {}

class LoginFailure extends AuthBlocState {
  String errorMassage;

  LoginFailure({required this.errorMassage});
}

class RegisterSuccess extends AuthBlocState {}

class RegisterFailure extends AuthBlocState {
  String errorMassage;

  RegisterFailure({required this.errorMassage});
}

class RegisterLoading extends AuthBlocState {}
