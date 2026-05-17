import 'package:cubitproject/Managers/login_cubit/login_state.dart';
import 'package:cubitproject/Services/user_Service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());

  void login(String email, String password) async {
    emit(LoginLoading());
    try {
      UserService userService = UserService();
      final user = await userService.signInWithEmailAndPassword(
        email,
        password,
      );
      if (user != null) {
        emit(LoginSuccess());
      } else {
        emit(LoginFailure("Login failed. Please try again."));
      }
    } catch (e) {
      emit(LoginFailure("An error occurred: ${e.toString()}"));
    }
  }
}
