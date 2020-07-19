

import 'dart:convert';



List<Book> bookFromJson(String response){
  final jsonData = json.decode(response);
  final data=jsonData["data"];
  return new List<Book>.from(data.map((x) => Book.fromJson(x)));
}


String movieToJson(List<Book> data) {
    final dyn = new List<dynamic>.from(data.map((x) => x.toJson()));
    return json.encode(dyn);
}



class Book{
  int id;
  String title;
  String description;
  String author;
  int price;
  String photo;
  String publisher;


  Book({
    this.id,
    this.author,
    this.description,
    this.price,
    this.title,
    this.photo,
    this.publisher
  });

   factory Book.fromJson(Map<String,dynamic> json)=>new Book(
    id   :   json["id"],
    title: json["title"],
    description: json["description"],
    author:  json["author"],
    price: json["price"],
    photo: json["photo"],
    publisher: json["publisher"],
  );

   Map<String,dynamic>toJson()=>{
    "id" : id,
    "title" : title,
    "description":description,
    "author":author,
    "price":price,
    "photo":photo,
    "publisher":publisher
  };

}