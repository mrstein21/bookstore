import 'package:bookstore/bloc/cart/cart_bloc.dart';
import 'package:bookstore/bloc/cart/cart_event.dart';
import 'package:bookstore/bloc/transaction_bloc/transaction_bloc.dart';
import 'package:bookstore/bloc/transaction_bloc/transaction_event.dart';
import 'package:bookstore/bloc/transaction_bloc/transaction_state.dart';
import 'package:bookstore/models/book.dart';
import 'package:bookstore/server/server.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'detail_book.dart';

class BookCartPage extends StatefulWidget {
  @override
  BookCartState createState() => BookCartState();
  // TODO: implement createSta
}

class BookCartState extends State<BookCartPage> {
  var format = new NumberFormat.currency(decimalDigits: 0, symbol: "");
  String base_url = Server.url;
  CartBloc cartBloc;
  String id = "";
  TransactionBloc transactionBloc;
  void init() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      id = sharedPreferences.getString("id");
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ProgressDialog progressDialog = new ProgressDialog(context);
    cartBloc = BlocProvider.of<CartBloc>(context);
    transactionBloc = BlocProvider.of<TransactionBloc>(context);
    int total = 0;
    return BlocListener<TransactionBloc, TransactionState>(
      listener: (context, state) {
        progressDialog.dismiss();
        if (state is TransactionSuccess) {
          cartBloc.add(RemoveAllCart());
          final snackbar = SnackBar(content: Text("Transaction Success !"));
          Scaffold.of(context).showSnackBar(snackbar);
        } else {
          final snackbar = SnackBar(content: Text("Transaction Failed !"));
          Scaffold.of(context).showSnackBar(snackbar);
        }
      },
      child: Container(child: BlocBuilder<CartBloc, List<Book>>(
        builder: (context, book) {
          total = 0;
          for (int i = 0; i < book.length; i++) {
            total = total + book[i].price;
          }
          if (book.length > 0) {
            return Column(
              children: <Widget>[
                Expanded(child: buildList(book)),
                Container(
                  decoration: BoxDecoration(boxShadow: [
                    new BoxShadow(
                      color: Colors.black38,
                      blurRadius: 2.0,
                    ),
                  ], color: Colors.white),
                  padding: EdgeInsets.all(20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "Total : Rp. " + format.format(total),
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 15),
                      ),
                      SizedBox(height: 20),
                      SizedBox(
                        height: 40,
                        width: double.infinity,
                        child: RaisedButton(
                          color: Colors.blue,
                          onPressed: () {
                            transactionBloc
                                .add(AddTransaction(user_id: id, list: book));
                            progressDialog.style(message: "Loading....");
                            progressDialog.show();
                          },
                          shape: new RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(10.0)),
                          elevation: 4.0,
                          child: Text("Checkout",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 15.0,
                              )),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            );
          } else {
            return buildEmppty("Your cart is empty");
          }
        },
      )),
    );
  }

  Widget buildList(List<Book> book) {
    return ListView.separated(
        separatorBuilder: (context, index) {
          return Divider();
        },
        itemCount: book.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => DetailBook(
                            book: book[index],
                          )));
            },
            child: Container(
              padding: EdgeInsets.only(left: 10, top: 10, bottom: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    height: 90,
                    width: 89,
                    decoration: BoxDecoration(
                        borderRadius: new BorderRadius.circular(5.0),
                        image: DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(base_url +
                                "/book/image/" +
                                book[index].photo))),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Container(
                            width: 200,
                            child: Text(
                              book[index].title,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 15),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            )),
                        Container(
                            width: 200,
                            child: Text(
                              book[index].description,
                              style: TextStyle(
                                fontSize: 12,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            )),
                        SizedBox(
                          height: 10,
                        ),
                        Text("Rp. " + format.format(book[index].price),
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 13,
                                color: Colors.blue)),
                        SizedBox(
                          height: 7,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 18,
                    width: 50,
                    child: RaisedButton(
                        color: Colors.red,
                        onPressed: () {
                          cartBloc.add(RemoveFromCart(index: index));
                          final snackbar =
                              SnackBar(content: Text("Removed From Cart"));
                          Scaffold.of(context).showSnackBar(snackbar);
                        },
                        shape: new CircleBorder(),
                        elevation: 4.0,
                        child: Icon(
                          Icons.close,
                          color: Colors.white,
                          size: 13,
                        )),
                  ),
                ],
              ),
            ),
          );
        });
  }

  Widget buildEmppty(String message) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Icon(
              Icons.shopping_cart,
              color: Colors.grey,
              size: 70,
            ),
            Text(
              message,
              style: TextStyle(
                  color: Colors.grey,
                  fontWeight: FontWeight.bold,
                  fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}
