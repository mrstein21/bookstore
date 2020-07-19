

import 'package:bookstore/models/book.dart';
import 'package:equatable/equatable.dart';

abstract class BookState extends Equatable{}


class BookLoadingState extends BookState{
  @override
  // TODO: implement props
  List<Object> get props => null;
}


class BookErrorState extends BookState{
  String message;
  BookErrorState({
    this.message,
  });
  @override
  List<Object> get props => [message];
}


class BookLoadedState extends BookState{
  List<Book> list;
  int page=1;
  bool hasReachedMax=false;
  BookLoadedState({
    this.hasReachedMax,
    this.list,
    this.page
  });

  BookLoadedState copyWith({List<Book>list,int page,bool hasReachedMax}){
    return BookLoadedState(
      list : list?? this.list,
      page : page?? this.page,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax
    );
  }

  @override
  // TODO: implement props
  List<Object> get props => [list,page,hasReachedMax];
  
}


class BookHasReachEnd extends BookState{
  List<Book> list;
  int page=1;
  bool hasReachedMax=false;

  BookHasReachEnd({
    this.list,
    this.hasReachedMax,
    this.page,
  });
  @override
  List<Object> get props => null;
  
}