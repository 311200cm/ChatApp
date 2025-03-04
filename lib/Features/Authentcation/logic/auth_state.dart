part of 'auth_cubit.dart';

@immutable
sealed class AuthState {}

final class AuthInitial extends AuthState {}

class RegisterLoading extends AuthState{}

class RegisterSuccessfully extends AuthState{}

class RegisterWithError extends AuthState{

  String message;

  RegisterWithError({
    required this.message
  });
}

class SignInLoading extends AuthState{}
class SignInSuccessfully extends AuthState{}
class SignInWithError extends AuthState{

  String message;

  SignInWithError({
    required this.message
}){}
}
