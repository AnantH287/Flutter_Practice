abstract class FetchState{}

class FetchInitial extends FetchState{}
class FetchLoading extends FetchState{}
class FetchFailed extends FetchState{
  String? error;

  FetchFailed({ required this.error});
}
class FetchSuccess extends FetchState{
  List<dynamic>  data = [];

  FetchSuccess({ required this.data});
}


// For JWT

// State.dart

abstract class LoginState {}

class LoginInitial extends LoginState {}
class LoginLoading extends LoginState {}

class LoginSuccess extends LoginState {
  final String token;
  LoginSuccess({required this.token});
}

class LoginFailed extends LoginState {
  final String error;
  LoginFailed({required this.error});
}
