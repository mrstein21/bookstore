import 'dart:async';

import 'package:bookstore/main.dart';
import 'package:bookstore/ui/book_list.dart';
import 'package:bookstore/ui/cart_book.dart';
import 'package:bookstore/ui/history.dart';
import 'package:bookstore/ui/profil.dart';
import 'package:bookstore/ui/search_book.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget{


  @override
  HomeState createState()=>HomeState();

}

class HomeState extends State<HomePage>with SingleTickerProviderStateMixin{
  int current_index=0;

  final List<Widget> view=[
    new BookPage(),
    new SearchBookPage(),
    new BookCartPage(),
    new HistoryPage(),
  ];
  
  @override
  void initState() {

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
      home: Builder(
        builder: (context){
          return Material(
            child: Scaffold(
              appBar: AppBar(                
                title: Text("Mr.Stein's Book Store",style: TextStyle(fontFamily:"Pacifico" ),),
                actions: <Widget>[
                     GestureDetector(
                         onTap: (){
                           Navigator.push(context,MaterialPageRoute(
                            builder: (context)=>ProfilPage()
                            ));
                         },
                         child: Container(
                         margin: EdgeInsets.only(right: 10),
                         child: CircleAvatar(
                            child: ClipOval(
                              child: Image.asset('dazai.jpg'),
                            ),
                          ),
                       ),
                     ),
             
           
                

                  // IconButton(icon: Icon(Icons.exit_to_app), onPressed: ()async{
                  //    SharedPreferences prefs = await SharedPreferences.getInstance();
                  //    await  prefs.remove("name");
                  //    await  prefs.remove("email");
                  //      Navigator.pushReplacement(context, MaterialPageRoute(
                  //               builder: (context)=> MyApp()
                  //     ));  
                  // })
                ],
              ),
              body: Container(
                child: view[current_index],
              ),
              bottomNavigationBar: BottomNavigationBar(
                type: BottomNavigationBarType.fixed,
                elevation: 5,
                showSelectedLabels: true,
                showUnselectedLabels: false,
                backgroundColor: Colors.blue,
                currentIndex: current_index,
                onTap: (index){
                  setState(() {
                    current_index=index;
                  });
                },
                items: [
                    new BottomNavigationBarItem(
                      icon: Icon(Icons.book,color: Colors.white,),
                      title: Text('List Book',style: TextStyle(color: Colors.white,)),
                    ),
                     new BottomNavigationBarItem(
                      icon: Icon(Icons.search,color: Colors.white,),
                      title: Text('Find Book',style: TextStyle(color: Colors.white,)),
                    ),
                      new BottomNavigationBarItem(
                      icon: Icon(Icons.shopping_cart,color: Colors.white,),
                      title: Text('Cart',style: TextStyle(color: Colors.white,)),
                    ),
                     new BottomNavigationBarItem(
                      icon: Icon(Icons.payment,color: Colors.white,),
                      title: Text('Transaction',style: TextStyle(color: Colors.white,)),
                    ),
                ]
              ),
            ),
          );
        }
      ),
    );
  }
}