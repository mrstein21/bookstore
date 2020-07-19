import 'dart:convert';

import 'package:bookstore/bloc/detail_transaction/detail_transaction_event.dart';
import 'package:bookstore/bloc/detail_transaction/detail_transaction_state.dart';
import 'package:bloc/bloc.dart';
import 'package:bookstore/models/book.dart';
import 'package:bookstore/resource/transaction_repository.dart';
import 'package:flutter/foundation.dart';

class DetailTransactionBloc extends Bloc<DetailTransactionEvent,DetailTransactionState>{

TransactionRepository transactionRepository;
DetailTransactionBloc({
 this.transactionRepository
});

  @override
  // TODO: implement initialState
  DetailTransactionState get initialState => UninitializedState();

  @override
  Stream<DetailTransactionState> mapEventToState(DetailTransactionEvent event) async*{
    if(event is FetchDetailTransaction){
      try{

        String response=await transactionRepository.fetchTransactionDetail(event.id_transaction);
        var content=json.decode(response);
        var date=content["info"]["date"];
        var no_transaksi=content["info"]["trans_id"];
        var total=content["info"]["total"];
        List<Book>book=bookFromJson(response);
        for(int i=0;i<book.length;i++){
         print(book[i].title);
        }

        yield LoadedDetailState(list:book,no_transaksi:no_transaksi,date:date,total:total);


      }catch(e){
        yield ErrorDetailState();
      }

    }
    
  }

}