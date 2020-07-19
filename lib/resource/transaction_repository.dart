import 'package:bookstore/bloc/transaction_bloc/transaction_state.dart';
import 'package:bookstore/models/transaction.dart';
import 'package:bookstore/server/server.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;


abstract class TransactionRepository{
  Future<String> addTransaction(var body);
  Future<List<Transaction>> getTransaction(String id,int page);
  Future<String> fetchTransactionDetail(String trans_id);
}

class TransactionRepositoryImp extends TransactionRepository{
  String base_url=Server.url;

  @override
  Future<String> addTransaction(body) async{
    var url=Server.url+"/transaction";
    var res = await http.post(Uri.encodeFull(url), body : body,headers: {'Content-type': 'application/json'});
    if (res.statusCode == 200) {
       return res.body;
    }else{
      throw Exception();
    }
    

  }

  @override
  Future<List<Transaction>> getTransaction(String id, int page) async {
   var response = await http.get(base_url+"/transaction_list/"+id+"?page="+page.toString());
   print(base_url+"/transaction_list/"+id+"?page="+page.toString());
   if(response.statusCode==200){
     return compute(transactionFromJson,response.body);
   }else{
       throw Exception();

   }
  }

  @override
  Future<String> fetchTransactionDetail(String trans_id)async {
    var response = await http.get(base_url+"/transaction_detail/"+trans_id);
    if(response.statusCode==200){
      return response.body;

    }else{
      throw Exception();
    }
 }
 
  
}