import 'package:bookstore/bloc/book/book_event.dart';
import 'package:bookstore/models/book.dart';
import 'package:equatable/equatable.dart';

abstract class SearchState extends Equatable{}



class FetchBook extends SearchState{
  List<Book>book;
  int page;
  bool hasReachMax=false;

  FetchBook({
    this.book,
    this.page,
    this.hasReachMax
  });

  FetchBook copyWith({List<Book> list,int page,bool hasReachMax}){
    return FetchBook(
      book : book ?? this.book,
      page: page ??this.page,
      hasReachMax: hasReachMax ?? this.hasReachMax
    );

  }

  @override
  // TODO: implement props
  List<Object> get props => [book,page,hasReachMax];
}

class StateUnintialized extends SearchState{
    List<Book>book=[];
  @override
  // TODO: implement props
  List<Object> get props => [book];
  
}

class LoadingBook extends SearchState{
  @override
  // TODO: implement props
  List<Object> get props => null;
  
}


class ErrorBook extends SearchState{
  String message;
  ErrorBook({
    this.message
  });

  @override
  // TODO: implement props
  List<Object> get props => [message];
  
}


class EmptySearch extends SearchState{
  @override
  // TODO: implement props
  List<Object> get props => null;
  
}