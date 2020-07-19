import 'package:bookstore/bloc/transaction_list_bloc/transaction_list_event.dart';
import 'package:bookstore/bloc/transaction_list_bloc/transaction_list_state.dart';
import 'package:bloc/bloc.dart';
import 'package:bookstore/models/transaction.dart';
import 'package:bookstore/resource/transaction_repository.dart';

class TransactionListBloc extends Bloc<TransactionListEvent,TransactionListState>{
  TransactionRepository transactionRepository;

  TransactionListBloc({
     this.transactionRepository,
  });


  @override
  // TODO: implement initialState
  TransactionListState get initialState => TransactionLoadingState();

  @override
  Stream<TransactionListState> mapEventToState(TransactionListEvent event)async * {
    if( event is FetchTransaction){
      if( state is TransactionLoadingState){
          try{
            List<Transaction>list= await transactionRepository.getTransaction(event.id, 1);
            if(list.length==0){
              yield TransactionEmptyState();
            }
            if(list.length<10){
             yield LoadedTransactionList(hasReachMax: true,list: list,page: 2);
            }else if(list.length>=10){
             yield LoadedTransactionList(hasReachMax: false,list: list,page: 2);
            }
          }catch(e){
            yield TransactionErrorState();
          }
      }else{
        print("Eksekuted");
        LoadedTransactionList loadedTransactionList = state as LoadedTransactionList;
        List<Transaction>list= await transactionRepository.getTransaction(event.id, loadedTransactionList.page);
        print(list.isEmpty);
        yield(list.isEmpty)? loadedTransactionList.copyWith(hasReachMax: true):
        loadedTransactionList.copyWith(list:loadedTransactionList.list+list,page:loadedTransactionList.page+1,hasReachMax: false);
        
      }
    }else if(event is RefreshState){
      yield TransactionLoadingState();
    }
    // TODO: implement mapEventToState
  }
  
}