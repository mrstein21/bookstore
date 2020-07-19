import 'package:equatable/equatable.dart';

abstract class BookEvent extends Equatable{}

class FetchBookEvents extends BookEvent{
  @override
  List<Object> get props => null;
}