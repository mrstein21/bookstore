import 'package:equatable/equatable.dart';

abstract class RegisterState extends Equatable{}


class RegisterUninitialized extends RegisterState{
  @override
  // TODO: implement props
  List<Object> get props => null;
  
}


class RegisterSuccess extends RegisterState{
  @override
  // TODO: implement props
  List<Object> get props => null;
  
}


class RegisterFailure extends RegisterState{
  String message;
  RegisterFailure({
    this.message
  });

  @override
  // TODO: implement props
  List<Object> get props => [message];
  
}