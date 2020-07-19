import 'package:bookstore/models/book.dart';
import 'package:equatable/equatable.dart';

abstract class CartEvent extends Equatable{}


class AddToCart extends CartEvent{
  Book book;
  AddToCart({
    this.book
  });
  @override
  // TODO: implement props
  List<Object> get props => [book];
  
}

class RemoveFromCart extends CartEvent{
  int index;
  RemoveFromCart({
    this.index
  });
  @override
  // TODO: implement props
  List<Object> get props => [index];
  
}

class RemoveAllCart extends CartEvent{
  
  @override
  // TODO: implement props
  List<Object> get props => [];
  
}