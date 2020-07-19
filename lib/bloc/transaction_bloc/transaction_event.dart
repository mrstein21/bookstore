import 'package:bookstore/models/book.dart';
import 'package:equatable/equatable.dart';

abstract class TransactionEvent extends Equatable{}




class AddTransaction extends TransactionEvent{

   String user_id="";
   List<Book>list;

   AddTransaction({
     this.user_id,
     this.list
   });

  @override
  // TODO: implement props
  List<Object> get props => [user_id,list];
  
}