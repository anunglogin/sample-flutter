part of 'welcome_cubit.dart';

@immutable
sealed class WelcomeState {
  final String message;

  const WelcomeState({
    this.message = '',
  });
}

final class WelcomeInitial extends WelcomeState {}

final class WelcomeSetData extends WelcomeState {
  const WelcomeSetData({
    required String message,
  }) : super(message: message);
}
