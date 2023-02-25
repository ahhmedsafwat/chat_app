import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

part 'auth_bloc_event.dart';
part 'auth_bloc_state.dart';

class AuthBloc extends Bloc<AuthBlocEvent, AuthBlocState> {
  AuthBloc() : super(AuthBlocInitial()) {
    on((event, emit) async {
      if (event is LoginEvent) {
        emit(LoginLoading());

        try {
          UserCredential user = await FirebaseAuth.instance
              .signInWithEmailAndPassword(
                  email: event.email, password: event.password);
          emit(LoginSuccess());
        } on FirebaseAuthException catch (error) {
          if (error.code == 'wrong-password') {
            emit(LoginFailure(
                errorMassage:
                    'Your Email or Password are wrong please try again'));
          } else if (error.code == 'user-not-found') {
            emit(LoginFailure(
                errorMassage:
                    'User is not found, create a new account or try again'));
          } else if (error.code == 'invalid-email') {
            emit(LoginFailure(errorMassage: 'Invalid Email'));
          }
        } on Exception catch (e) {
          emit(LoginFailure(errorMassage: 'Something went wrong'));
        }
      }
    });
  }
}
