import 'package:bookstore/models/book.dart';
import 'package:equatable/equatable.dart';

abstract class DetailTransactionState extends Equatable{}


class LoadedDetailState extends DetailTransactionState{
  String date;
  String no_transaksi;
  String total;
  List<Book>list;
  LoadedDetailState({
    this.date,
    this.no_transaksi,
    this.total,
    this.list,
  });
  @override
  List<Object> get props => [date,no_transaksi,total,list]; 
}

class UninitializedState extends DetailTransactionState{
  @override
  // TODO: implement props
  List<Object> get props => null;
  
}

class ErrorDetailState extends DetailTransactionState{
  @override
  // TODO: implement props
  List<Object> get props => null;
  
}