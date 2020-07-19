
import 'package:bookstore/bloc/book/book_bloc.dart';
import 'package:bookstore/bloc/book/book_event.dart';
import 'package:bookstore/bloc/book/book_state.dart';
import 'package:bookstore/bloc/cart/cart_bloc.dart';
import 'package:bookstore/bloc/cart/cart_event.dart';
import 'package:bookstore/models/book.dart';
import 'package:bookstore/server/server.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import 'detail_book.dart';



class BookPage extends StatefulWidget{
  @override
  BooksState createState()=>BooksState();
}


class BooksState extends State<BookPage>{
    String base_url=Server.url;

 var format = new NumberFormat.currency(decimalDigits: 0,
      symbol: "");


  BookBloc bookBloc;
  CartBloc cartBloc;
  ScrollController controller=ScrollController();

  void onScroll(){
     double maxScroll=controller.position.maxScrollExtent;
     double currentScroller=controller.position.pixels;
     if(maxScroll==currentScroller){
       bookBloc.add(FetchBookEvents());
     }
  }

 @override
  void initState() {
    print("hello ganting");
    bookBloc=BlocProvider.of<BookBloc>(context);
    cartBloc=BlocProvider.of<CartBloc>(context);
    bookBloc.add(FetchBookEvents());
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
   
    controller.addListener(onScroll);
    return  BlocBuilder<BookBloc,BookState>(
      builder: (context,state){
        print(state.toString());
        if(state is BookLoadingState){
          return buildLoading();
        }else if(state is BookErrorState){
          return buildErrorUi("Network Error",Icons.signal_cellular_connected_no_internet_4_bar);
        }else if(state is BookLoadedState){
          return buildList(state.hasReachedMax,state.list);
        }
      });
  }

  
  Widget buildList(bool hasReachedMax,List<Book> book){
    return ListView.separated(
      separatorBuilder: (context,index){
        return Divider();
      },
      controller: controller,
      itemCount: (hasReachedMax)?book.length:book.length+1,
      itemBuilder: (context,index){
        if(index<book.length){
         // print("indeks ke"+index.toString());
         // print(book.length);
          return GestureDetector(
              onTap: (){
                 Navigator.push(context,MaterialPageRoute(
                   builder: (context)=>DetailBook(book: book[index],)
                  ));

              },
              child: Container(
              padding: EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment:MainAxisAlignment.start,
                crossAxisAlignment:CrossAxisAlignment.start,
                children: <Widget>[
                   Container(
                     height:90,
                     width: 120,
                     decoration: BoxDecoration(
                       borderRadius:  new BorderRadius.circular(5.0),
                       image: DecorationImage(
                         fit: BoxFit.cover,
                         image:NetworkImage(base_url+"/book/image/"+book[index].photo)
                       )
                     ),
                   ),
                   SizedBox(
                     width: 20,
                   ),
                  Container(
                       child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                           Container(width: 200,child: Text(book[index].title,style:TextStyle(fontWeight: FontWeight.bold,fontSize: 15),maxLines: 1,overflow: TextOverflow.ellipsis,)),
                           Container(width:200,child: Text(book[index].description,style:TextStyle(fontSize: 12,),maxLines: 2,overflow: TextOverflow.ellipsis,)),
                           SizedBox(
                             height:10,
                           ),
                           Text("Rp "+format.format(book[index].price),style:TextStyle(fontWeight: FontWeight.bold,fontSize: 13,color: Colors.blue)) ,
                           SizedBox(
                             height: 7,
                           ),
                           SizedBox(
                               height: 20,
                               child: RaisedButton(
                               color: Colors.blue,
                               onPressed: (){
                                bool same=false;
                                for(int i=0;i<cartBloc.state.length;i++){
                                  if(cartBloc.state[i].id==book[index].id){
                                      same=true;
                                  }
                                }
                                if(same==true){
                                   final snackbar=SnackBar(content: Text("Already added to cart"));
                                    Scaffold.of(context).showSnackBar(snackbar);
                                } else{
                                    cartBloc.add(AddToCart(book:book[index]));
                                    final snackbar=SnackBar(content: Text("Added To Cart"));
                                    Scaffold.of(context).showSnackBar(snackbar);
                                }
                               },
                               shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(10.0)),
                               elevation: 4.0,
                               child: Text("Add To Cart",style:TextStyle( color: Colors.white,fontSize: 12.0,)),

                             ),
                           ),
                           
                        ],
                     ),
                   )
                ],
              ),
            ),
          );
        }else{
           return 
           Container(
                 child: Center(
                    child: SizedBox(
                         width:30,
                          height:30,
                          child:CircularProgressIndicator()
                 ) ,
               ),
            );
        }

      });
 }

  Widget buildLoading() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }


    Widget buildErrorUi(String message,IconData iconData) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
              Icon(iconData,color: Colors.grey,size: 70,),
            Text(
              message,
              style: TextStyle(color: Colors.grey,fontWeight: FontWeight.bold,fontSize: 18),
            ),

          ],
        ),
      ),
    );
  }



  
}