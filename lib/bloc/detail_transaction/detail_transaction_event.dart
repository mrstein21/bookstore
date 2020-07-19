


import 'package:equatable/equatable.dart';

abstract class DetailTransactionEvent extends Equatable{}

class FetchDetailTransaction extends DetailTransactionEvent{
  String id_transaction="";
  FetchDetailTransaction({
    this.id_transaction,
  });
  @override
  // TODO: implement props
  List<Object> get props => [id_transaction];
  
}