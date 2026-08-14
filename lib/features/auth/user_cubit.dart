import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled4/data/api_service.dart';
import 'package:untitled4/features/auth/user_state.dart';

class UserCubit extends Cubit<UserState> {
  final ApiService apiService;

  UserCubit(this.apiService) : super(UserInitial());

  void getUser() async {
    emit(UserLoading());
    var responsUser = await apiService.getUserList();
    emit(UserComplete(responsUser));
  }
}
