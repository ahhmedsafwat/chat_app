import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

part 'auth_cubit_state.dart';

class AuthCubit extends Cubit<AuthCubitState> {
  AuthCubit() : super(AuthCubitInitial());
  Future<void> registerUser(
      {required String email, required String password}) async {
    RegisterLoading();
    try {
      UserCredential user = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      RegisterSuccess();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        emit(RegisterFailure(errorMassage: 'This password is weak'));
      } else if (e.code == 'email-already-in-use') {
        emit(RegisterFailure(errorMassage: 'This email is already used'));
      } else if (e.code == 'invalid-email') {
        emit(RegisterFailure(errorMassage: 'This Email can\'t be used'));
      }
    } on Exception catch (e) {
      emit(RegisterFailure(errorMassage: 'Something went wrong'));
    }
  }
}
