
import 'dart:convert';

import 'package:bookstore/bloc/transaction_bloc/transaction_event.dart';
import 'package:bookstore/bloc/transaction_bloc/transaction_state.dart';
import 'package:bloc/bloc.dart';
import 'package:bookstore/models/book.dart';
import 'package:bookstore/resource/transaction_repository.dart';

class TransactionBloc extends Bloc<TransactionEvent,TransactionState>{
  @override
  // TODO: implement initialState
  TransactionState get initialState => TransactionUninitialized();
  TransactionRepository transactionRepository;

  TransactionBloc({
    this.transactionRepository
  });

  @override
  Stream<TransactionState> mapEventToState(TransactionEvent event) async* {
    if(event is AddTransaction){

      List<Book> list=event.list;
      var user_id=event.user_id;
      List<Map<String,dynamic>> request_BOOK= new List();
      for(int i=0;i<list.length;i++){
        Map<String,dynamic> json2;
        Book book=list[i];
        json2=book.toJson();
        print("eXECUTED, "+json2.toString());
        request_BOOK.add(json2);

      }



      var body=json.encode(
        {
          "user_id":user_id,
          "books":request_BOOK,
        }
      );


      try{
        var data=await transactionRepository.addTransaction(body);
        var content=json.decode(data);
        print(data);
        if(content["success"]=="1"){
          yield TransactionSuccess();
        }else{
          yield TransactionFailed();
        }
      }catch(e){
          yield TransactionFailed();
      }


    }
  }

}