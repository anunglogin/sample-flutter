import 'package:bloc/bloc.dart';
import 'package:flutter_navigation_3/api/AuthServices.dart';
import 'package:flutter_navigation_3/model/AuthModel.dart';
import 'package:meta/meta.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());


 void loginUser({
  required String username, 
  required String password
 }) async {
    try {
      emit(AuthLoading());

      AuthModel authModel = await AuthServices().login(username, password);

      emit(AuthSuccess(authModel));

    } catch (e) {
      emit(AuthFailed(e.toString()));
    }
 }
}
