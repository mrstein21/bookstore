

import 'dart:convert';

import 'package:bookstore/models/book.dart';
import 'package:bookstore/server/server.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

abstract class BookRepository{
  Future<List<Book>>getBook(int page);
   Future<List<Book>>searchBook(String keyword,int page);
}


class BookRepositoryImp implements BookRepository{
  String base_url=Server.url;

  @override
  Future<List<Book>> getBook(int page) async {
    var response = await http.get(base_url+"/book?page="+page.toString());
    // print(response.body);
    if (response.statusCode == 200) {
      //print("hello");
      return compute(bookFromJson,response.body);
    } else {
      throw Exception();
    }
  }

  @override
  Future<List<Book>> searchBook(String keyword, int page) async {
       var response = await http.get(base_url+"/book/search/"+keyword+"?page="+page.toString());
    // print(response.body);
    if (response.statusCode == 200) {
      //print("hello");
      return compute(bookFromJson,response.body);
    } else {
      throw Exception();
    }
    // TODO: implement searchBook
  }
  
}