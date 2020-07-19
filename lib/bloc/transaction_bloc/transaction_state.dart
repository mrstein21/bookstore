import 'package:equatable/equatable.dart';

abstract class TransactionState extends Equatable{}


class TransactionSuccess extends TransactionState{
  @override
  // TODO: implement props
  List<Object> get props => null;
  
}

class TransactionUninitialized extends TransactionState{
  @override
  // TODO: implement props
  List<Object> get props => null;
}

class TransactionFailed extends TransactionState{

  @override
  // TODO: implement props
  List<Object> get props => null;

}