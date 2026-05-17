import 'package:cubitproject/Managers/signup_cubit/signup_state.dart';
import 'package:cubitproject/Models/UserModel.dart';
import 'package:cubitproject/Services/user_Service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignupCubit extends Cubit<SignupState> {
  SignupCubit() : super(SignupInital());

  void signup(String email, String password, String username) async {
    emit(SignupLoading());

    try {
      UserService userService = UserService();
      final user = await userService.registerWithEmailAndPassword(
        email,
        password,
      );
      if (user != null) {
        await userService.addUserToFirestore(
          UserModel(uid: user.uid, email: email, username: username),
        );
        emit(SignupSuccess());
      } else {
        emit(SignupFailure("Signup failed. Please try again."));
      }
    } catch (e) {
      emit(SignupFailure("Signup failed. Please try again."));
    }
  }
}
