// For ftech data

abstract class fetchDetailsEvent{}

class FetchEvent extends fetchDetailsEvent{}


// For JWT
abstract class LoginEvent {}

class LoginButtonPressed extends LoginEvent {
  final String email;
  final String password;

  LoginButtonPressed({
    required this.email,
    required this.password,
  });
}
