import 'package:equatable/equatable.dart';

abstract class RegisterEvent extends Equatable{}


class RegisterAttempt extends RegisterEvent{
  String email;
  String password;
  String name;
  String confirmation_password;

  RegisterAttempt({
    this.email,
    this.password,
    this.name,
    this.confirmation_password,
  });

  @override
  // TODO: implement props
  List<Object> get props => [email,password,name,confirmation_password];
  
}