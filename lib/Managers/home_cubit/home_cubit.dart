import 'package:cubitproject/Managers/home_cubit/home_state.dart';
import 'package:cubitproject/Services/user_Service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial()) {
    fetchUsers();
  }
  UserService userService = UserService();

  Future<void> fetchUsers() async {
    emit(HomeLoading());
    try {
      final fetchedUsers = await userService.getUsers();

      final users = fetchedUsers!
          .where((user) => user.uid != userService.getCurrentUser().uid)
          .toList();
      emit(HomeFetchedUsers(users));
    } catch (e) {
      emit(HomeFailure("An error occurred: ${e.toString()}"));
    }
  }
}
