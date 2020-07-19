import 'package:bookstore/bloc/transaction_bloc/transaction_state.dart';
import 'package:bookstore/models/transaction.dart';
import 'package:equatable/equatable.dart';

abstract class TransactionListState extends Equatable{}


class LoadedTransactionList extends TransactionListState{
  List<Transaction> list;
  int page;
  bool hasReachMax=false;

  LoadedTransactionList({
    this.list,
    this.hasReachMax,
    this.page
  });

  LoadedTransactionList copyWith({List<Transaction> list,int page,bool hasReachMax}){
    return LoadedTransactionList(
      list:  list ?? this.list,
      page : page ?? this.page,
      hasReachMax: hasReachMax ?? this.hasReachMax
    );
  }

  @override  List<Object> get props => [list,page,hasReachMax];
  
}

class TransactionEmptyState extends TransactionListState{
  @override
  // TODO: implement props
  List<Object> get props => null;
  
}


class TransactionLoadingState extends TransactionListState{
  @override
  // TODO: implement props
  List<Object> get props => null;
  
}


class TransactionErrorState extends TransactionListState{
  @override
  // TODO: implement props
  List<Object> get props => null;

}