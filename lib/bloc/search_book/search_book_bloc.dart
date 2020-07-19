

import 'package:bookstore/bloc/search_book/search_book_event.dart';
import 'package:bookstore/bloc/search_book/search_book_state.dart';
import 'package:bloc/bloc.dart';
import 'package:bookstore/models/book.dart';
import 'package:bookstore/resource/book_repository.dart';

class SearchBookBloc extends Bloc<SearchEvent,SearchState>{
  @override
  // TODO: implement initialState
  SearchState get initialState => StateUnintialized();

  BookRepository bookRepository;

  SearchBookBloc({
    this.bookRepository,
  });

  @override
  Stream<SearchState> mapEventToState(SearchEvent event) async* {
    if(event  is FetchSearchBook){
        String keyword=event.keyword;
        yield LoadingBook();
        if(state is LoadingBook){
          try{
            List<Book> data=await bookRepository.searchBook(keyword, 1);
            if(data.isEmpty){
              yield EmptySearch();
            }else{
              if(data.length<10){
              yield FetchBook(book: data,page: 2,hasReachMax: true);
              }else{
              yield FetchBook(book: data,page: 2,hasReachMax: false);
              }
            }
          }catch(e){
            yield ErrorBook(message: e.toString());
          }

        }
    }else if(event is LoadMoreBook){
      print('eksses');
      String keyword=event.keyword;
          try{
            FetchBook fetchBook =state as FetchBook;
            List<Book> data=await bookRepository.searchBook(keyword, fetchBook.page);
            yield(data.isEmpty)?fetchBook.copyWith(hasReachMax: true):
            fetchBook.copyWith(list: fetchBook.book+data,page: fetchBook.page+1,hasReachMax: false);
          }catch(e){
             yield ErrorBook(message: e.toString());
          }
    }else if(event is UninitializedEvent){
      yield StateUnintialized();
    }
  }
  
}