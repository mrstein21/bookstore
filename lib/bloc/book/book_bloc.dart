

import 'package:bookstore/bloc/book/book_event.dart';
import 'package:bookstore/bloc/book/book_state.dart';
import 'package:bloc/bloc.dart';
import 'package:bookstore/models/book.dart';
import 'package:bookstore/resource/book_repository.dart';


class BookBloc extends Bloc<BookEvent,BookState>{
   BookRepository bookRepository;

   BookBloc({
     this.bookRepository,
   });

  @override
  // TODO: implement initialState
  BookState get initialState => BookLoadingState();

  @override
  Stream<BookState> mapEventToState(BookEvent event) async*{
    if(event is FetchBookEvents){
      if(state is BookLoadingState){
        try{ 
        List<Book> data=await bookRepository.getBook(1);
        yield BookLoadedState(hasReachedMax: false,page: 2,list: data);
        }catch(e){
          yield BookErrorState(message: e.toString());
        }
      }else{
        BookLoadedState bookLoadedState = state as BookLoadedState;
        try{
            List<Book> list=await bookRepository.getBook(bookLoadedState.page);
            yield (list.isEmpty)?bookLoadedState.copyWith(
              hasReachedMax: true,
              ):bookLoadedState.copyWith(list: bookLoadedState.list+list,page:bookLoadedState.page+1,hasReachedMax:false);
        }catch(e){
          print('error'+e.toString());
          yield BookErrorState(message: e.toString());
        }
      }
    }
  }
  
}