part of 'auth_cubit.dart';

@immutable
sealed class AuthState {}

final class AuthInitial extends AuthState {}

final class AuthLoading extends AuthState{}

final class AuthSuccess extends AuthState{
  final AuthModel authModel;

  AuthSuccess(this.authModel);

  @override
  List<Object> get props => [authModel]; 
}

final class AuthFailed extends AuthState{
  final String message;

  AuthFailed(this.message);

  @override
  List<Object> get props => [message]; 
}
