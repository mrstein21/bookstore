import 'package:equatable/equatable.dart';


abstract class SearchEvent extends Equatable{}

class FetchSearchBook extends SearchEvent{
  String keyword="";
  FetchSearchBook({
    this.keyword
  });


  @override
  // TODO: implement props
  List<Object> get props => [keyword];
}



class LoadMoreBook extends SearchEvent{
  String keyword="";
  LoadMoreBook({
    this.keyword
  });


  @override
  // TODO: implement props
  List<Object> get props => [keyword];
}


class UninitializedEvent extends SearchEvent{

  @override
  // TODO: implement props
  List<Object> get props => null;
  
}


