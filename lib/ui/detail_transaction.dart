import 'package:bookstore/bloc/detail_transaction/detail_transaction_bloc.dart';
import 'package:bookstore/bloc/detail_transaction/detail_transaction_event.dart';
import 'package:bookstore/bloc/detail_transaction/detail_transaction_state.dart';
import 'package:bookstore/models/book.dart';
import 'package:bookstore/server/server.dart';
import 'package:bookstore/ui/detail_book.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class DetailTransaction extends StatefulWidget {
  final String trans_id;

  DetailTransaction({
    Key key,
    this.trans_id,
  }):super(key:key);

  @override
  _DetailTransactionState createState() => _DetailTransactionState();
}


class _DetailTransactionState extends State<DetailTransaction> {
   DetailTransactionBloc detailTransactionBloc;
    String base_url=Server.url;

 var format = new NumberFormat.currency(decimalDigits: 0,
      symbol: "");

   @override
  void initState() {
    detailTransactionBloc=BlocProvider.of<DetailTransactionBloc>(context);
    detailTransactionBloc.add(FetchDetailTransaction(id_transaction:widget.trans_id));
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home:Builder(
        builder: (context){
          return Material(
            child: Scaffold(
              appBar: AppBar(
                title: Text("Transaction Detail"),
              ),
              body: Container(
                child: SingleChildScrollView(
                  child: BlocBuilder<DetailTransactionBloc,DetailTransactionState>
                  (
                    builder: (context,state){
                      if(state is LoadedDetailState){
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            _buildNoTransField(state.no_transaksi),
                             Divider(),
                            _buildDateField(state.date),
                             Divider(),
                             Container(
                               margin: EdgeInsets.only(left: 10,bottom: 10,top: 20),
                               child:Text("Detail Book :",style:TextStyle(fontSize: 16,fontWeight: FontWeight.bold,color: Colors.black)) ,
                             ),
                            _buildListBook(state.list),
                             Divider(),
                            _buildTotalField(state.total),
                             Divider()
                          ],
                        );
                      }else if(state is UninitializedState){
                        return _buildLoading();
                      }else{
                        _buildErrorUi("Network Error", Icons.signal_cellular_connected_no_internet_4_bar);

                      }
                    }
                  
                  )
                ),
              ),
            ),

          );
        }
      )
    );
  }

   Widget _buildLoading() {
    return Container(
     
      child: Center(
          child: CircularProgressIndicator(),
        ),
    );
  }
    Widget _buildNoTransField(String no_trans){
      return ListTile(
        leading: Icon(Icons.payment,color: Colors.grey,size: 40,),
        title: Text("No.Transaction :",style:TextStyle(fontSize: 12,)),
        subtitle:Text(no_trans,style:TextStyle(fontSize: 14,fontWeight: FontWeight.bold,color: Colors.black)), 
      );
    }

    Widget _buildTotalField(String total){
      return ListTile(
        title: Text("Total :",style:TextStyle(fontSize: 16,fontWeight: FontWeight.bold,color: Colors.black)),
        trailing:Text("Rp. "+total,style:TextStyle(fontSize: 14,fontWeight: FontWeight.bold,color: Colors.blue)), 
      );
    }

     Widget _buildDateField(String date){
      return ListTile(
        leading: Icon(Icons.event_note,color: Colors.grey,size: 40,),
        title: Text("Date :",style:TextStyle(fontSize: 12,)),
        subtitle:Text(date,style:TextStyle(fontSize: 14,fontWeight: FontWeight.bold,color: Colors.black)), 
      );
    }


    Widget _buildListBook(List<Book>list){
      return ListView.separated(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemBuilder: (context,index){
          return _buildRowBook(list[index]);
        }, 
        separatorBuilder:(context,index){
          return Divider();
        }, 
        itemCount: list.length
        );
    }

     Widget _buildErrorUi(String message,IconData iconData) {
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

    Widget _buildRowBook(Book book){
         return GestureDetector(
              onTap: (){
                 Navigator.push(context,MaterialPageRoute(
                   builder: (context)=>DetailBook(book: book,)
                  ));
              },
              child: Container(
              padding: EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment:MainAxisAlignment.start,
                crossAxisAlignment:CrossAxisAlignment.start,
                children: <Widget>[
                   Container(
                     height:60,
                     width: 60,
                     decoration: BoxDecoration(
                       borderRadius:  new BorderRadius.circular(5.0),
                       image: DecorationImage(
                         fit: BoxFit.cover,
                         image:NetworkImage(base_url+"/book/image/"+book.photo)
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
                           Container(width: 200,child: Text(book.title,style:TextStyle(fontWeight: FontWeight.bold,fontSize: 13),maxLines: 1,overflow: TextOverflow.ellipsis,)),
                           Container(width:200,child: Text(book.description,style:TextStyle(fontSize: 12,),maxLines: 2,overflow: TextOverflow.ellipsis,)),
                           SizedBox(
                             height:10,
                           ),
                           Text("Rp "+format.format(book.price),style:TextStyle(fontWeight: FontWeight.bold,fontSize: 12,color: Colors.blue)) ,
                           SizedBox(
                             height: 7,
                           ),
                        ],
                     ),
                   )
                ],
              ),
            ),
         );

    }
}