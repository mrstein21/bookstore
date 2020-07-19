import 'package:equatable/equatable.dart';

abstract class LoginState extends Equatable{}

class LoginUnitialized extends LoginState{
  @override
  // TODO: implement props
  List<Object> get props => null;
  
}


class LoginSuccess extends LoginState{
  @override
  // TODO: implement props
  List<Object> get props => null;
  
}


class LoginFailure extends LoginState{
  String message="";
  LoginFailure({
    this.message
  });
  @override
  List<Object> get props => [message];
  
}