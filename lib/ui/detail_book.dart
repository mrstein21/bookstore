

import 'package:bookstore/bloc/cart/cart_bloc.dart';
import 'package:bookstore/bloc/cart/cart_event.dart';
import 'package:bookstore/models/book.dart';
import 'package:bookstore/server/server.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';


class DetailBook extends StatefulWidget {
  final Book book;

  const DetailBook({Key key, this.book}) : super(key: key);

  @override
  _DetailBookState createState() => _DetailBookState();
}

class _DetailBookState extends State<DetailBook> {
 CartBloc cartBloc;
 String base_url=Server.url;
 var format = new NumberFormat.currency(decimalDigits: 0,
      symbol: "");
  @override
  void initState() {
    cartBloc=BlocProvider.of<CartBloc>(context);
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return 
    Scaffold(
        body: BlocBuilder<CartBloc,List<Book>>(
        builder: (context,list)=> Container(
          decoration: BoxDecoration(
            color: Colors.white
            
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  width: double.infinity,
                  height:300,
                  child:Image.network(base_url+"/book/image/"+widget.book.photo,fit: BoxFit.cover,)
                ),
                Container(
                  margin: EdgeInsets.only(top: 10),
                  padding: EdgeInsets.all(10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                           Container(
                             width: 200,
                             child: 
                           Text(widget.book.title,style:TextStyle(fontWeight: FontWeight.bold,fontSize: 18),maxLines: 2,overflow: TextOverflow.ellipsis,))
                        ],
                      ),
                           Text("Rp."+format.format(widget.book.price),style:TextStyle(fontWeight: FontWeight.bold,fontSize: 18,color: Colors.blue),maxLines: 1,overflow: TextOverflow.ellipsis,)
                    ],
                  ),
                ),
                Divider(),
                Container(
                  alignment: Alignment.topLeft,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                     ListTile(
                       leading:Icon(Icons.person,color: Colors.grey,size: 40,),
                       title: Text("Author",textAlign:TextAlign.start,style:TextStyle(fontWeight: FontWeight.bold,fontSize: 16),maxLines: 2,overflow: TextOverflow.ellipsis,),
                       subtitle: Text(widget.book.author,textAlign:TextAlign.start,style:TextStyle(fontSize: 16),maxLines: 2,overflow: TextOverflow.ellipsis,)
,
                     )

                    ],
                  ),
                ),
                Divider(),
                Container(
                  child:   ListTile(
                       leading:Icon(Icons.pages,color: Colors.grey,size: 40,),
                       title: Text("Description",textAlign:TextAlign.start,style:TextStyle(fontWeight: FontWeight.bold,fontSize: 16),maxLines: 2,overflow: TextOverflow.ellipsis,),
                       subtitle: Text(widget.book.description,textAlign:TextAlign.start,style:TextStyle(fontSize: 16),maxLines: 2,overflow: TextOverflow.ellipsis,),
                     )
                ),
                Divider(),
                Container(
                  child:   ListTile(
                       leading:Icon(Icons.language,color: Colors.grey,size: 40,),
                       title: Text("Publisher",textAlign:TextAlign.start,style:TextStyle(fontWeight: FontWeight.bold,fontSize: 16),maxLines: 2,overflow: TextOverflow.ellipsis,),
                       subtitle: Text(widget.book.publisher,textAlign:TextAlign.start,style:TextStyle(fontSize: 16),maxLines: 2,overflow: TextOverflow.ellipsis,),
                     )
                ),
                
                 
                   Container(
                     margin: EdgeInsets.only(top:20,bottom: 10),
                     padding: EdgeInsets.only(left: 10,right: 10),
                     child: SizedBox(
                              height: 40,
                              width: double.infinity,
                              child: RaisedButton(
                              color: Colors.blue,
                              onPressed: (){
                                  bool same=false;
                                for(int i=0;i<cartBloc.state.length;i++){
                                  if(cartBloc.state[i].id==widget.book.id){
                                      same=true;
                                  }
                                }
                                if(same==true){
                                   final snackbar=SnackBar(content: Text("Already added to cart"));
                                    Scaffold.of(context).showSnackBar(snackbar);
                                } else{
                                    cartBloc.add(AddToCart(book:widget.book));
                                    final snackbar=SnackBar(content: Text("Added To Cart"));
                                    Scaffold.of(context).showSnackBar(snackbar);
                                }
                              
                              },
                              shape: new RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(10.0)),
                              elevation: 4.0, 
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment:CrossAxisAlignment.center ,
                                children: <Widget>[
                                  Icon(Icons.shopping_cart,size: 30,color: Colors.white,),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text("Add To Chart",style:TextStyle( color: Colors.white,fontSize: 15.0,)),
                                ],
                              ),
                          ),
                        ),
                   ),
              ],
            ),

          ),
      ),
        ),
    );
  }
}