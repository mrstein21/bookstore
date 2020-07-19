import 'package:bookstore/bloc/cart/cart_event.dart';
import 'package:bookstore/models/book.dart';
import 'package:bloc/bloc.dart';

class CartBloc extends Bloc<CartEvent,List<Book>>{
      List<Book>data;

  @override
  // TODO: implement initialState
  List<Book> get initialState => [];

  @override
  Stream<List<Book>> mapEventToState(CartEvent event) async* {
    if(event is AddToCart){
      List<Book> data=List.from(state,growable: true);
      data.add(event.book);
      yield data;
    }else if(event is RemoveFromCart){
      List<Book> data=List.from(state,growable: true);
      data.removeAt(event.index);
      yield data;
    }else if(event is RemoveAllCart){
      List<Book> data=List.from(state,growable: true);
      data.clear();
      yield data;
    }
   
    // TODO: implement mapEventToState
  }

 
  
}