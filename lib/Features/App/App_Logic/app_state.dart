part of 'app_cubit.dart';

@immutable
sealed class AppState {}

final class AppInitial extends AppState {}

class GetHomeLoading extends AppState{}
class GetHomeSuccessfully extends AppState{}
class GetHomeWithError extends AppState{

  String message;
  GetHomeWithError({
    required this.message
}){}
}


class SendMessageSuccessfully extends AppState{}
class SendMessageWithError extends AppState{

  String message;
  SendMessageWithError({
    required this.message
}){}
}

class  GetAllMessageLoading extends AppState{}
class GetAllMessagesSuccessfully extends AppState{}
