import 'package:cubitproject/Models/UserModel.dart';

class HomeState {}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeFetchedUsers extends HomeState {
  final List<UserModel> users;

  HomeFetchedUsers(this.users);
}

class HomeFailure extends HomeState {
  final String errorMessage;

  HomeFailure(this.errorMessage);
}
