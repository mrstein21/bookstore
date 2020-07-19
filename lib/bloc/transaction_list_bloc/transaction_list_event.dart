
import 'package:equatable/equatable.dart';

abstract class TransactionListEvent extends Equatable{}


class FetchTransaction extends TransactionListEvent{
  String id;
  FetchTransaction({
    this.id
  });
  @override
  // TODO: implement props
  List<Object> get props => [id];
}

class RefreshState extends TransactionListEvent{
  @override
  // TODO: implement props
  List<Object> get props => null;
  
}