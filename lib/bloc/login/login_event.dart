import 'package:equatable/equatable.dart';

abstract class LoginEvent extends Equatable{}

class LoginAttempt extends LoginEvent{
  String username="";
  String password="";
  LoginAttempt({
    this.username,
    this.password
  });

  @override
  // TODO: implement props
  List<Object> get props => [username,password];
  
}