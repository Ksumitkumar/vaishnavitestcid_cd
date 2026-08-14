import 'package:untitled4/data/models/user_models.dart';

abstract class UserState {}

class UserInitial extends UserState {}

class UserLoading extends UserState {}

class UserComplete extends UserState {
  final List<UserModels> userModel;
  UserComplete(this.userModel);
}

class UserError extends UserState {
  final String errorMessage;
  UserError(this.errorMessage);
}
