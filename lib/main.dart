import 'package:bookstore/bloc/auth/auth_bloc.dart';
import 'package:bookstore/bloc/auth/auth_event.dart';
import 'package:bookstore/bloc/auth/auth_state.dart';
import 'package:bookstore/bloc/book/book_bloc.dart';
import 'package:bookstore/bloc/cart/cart_bloc.dart';
import 'package:bookstore/bloc/detail_transaction/detail_transaction_bloc.dart';
import 'package:bookstore/bloc/login/login_bloc.dart';
import 'package:bookstore/bloc/register/register_bloc.dart';
import 'package:bookstore/bloc/search_book/search_book_bloc.dart';
import 'package:bookstore/bloc/transaction_bloc/transaction_bloc.dart';
import 'package:bookstore/bloc/transaction_list_bloc/transaction_list_bloc.dart';
import 'package:bookstore/resource/auth_repository.dart';
import 'package:bookstore/resource/book_repository.dart';
import 'package:bookstore/resource/transaction_repository.dart';
import 'package:bookstore/ui/auth/login.dart';
import 'package:bookstore/ui/home.dart';
import 'package:bookstore/ui/screen_splash.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
         home: MultiBlocProvider(
           providers: [
             BlocProvider<LoginBloc>(create: (context)=>LoginBloc(authRepository: AuthRepositoryImp())),
             BlocProvider<RegisterBloc>(create: (context)=>RegisterBloc(authRepository: AuthRepositoryImp())),
             BlocProvider<AuthBloc>(create: (context)=>AuthBloc(),),
             BlocProvider<BookBloc>(create: (context)=>BookBloc(bookRepository: BookRepositoryImp()),),
             BlocProvider<SearchBookBloc>(create: (context)=>SearchBookBloc(bookRepository: BookRepositoryImp()),),
             BlocProvider<CartBloc>(create: (context)=>CartBloc(),),
             BlocProvider<TransactionBloc>(create: (context)=>TransactionBloc(transactionRepository: TransactionRepositoryImp()),),
             BlocProvider<TransactionListBloc>(create: (context)=>TransactionListBloc(transactionRepository: TransactionRepositoryImp()),),
             BlocProvider<DetailTransactionBloc>(create: (context)=>DetailTransactionBloc(transactionRepository: TransactionRepositoryImp()),)
           ], 
           child: Apps()
           ),
    );
  }
}

// class App extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//       AuthBloc authBloc=BlocProvider.of<AuthBloc>(context);
//       authBloc.add(CheckAuthEvent());
//       return MaterialApp(
//       home: BlocBuilder<AuthBloc,AuthState>(builder: (context,state){
//         if(state is AuthAuthenticated){
//           return HomePage();
//         }else if(state is AuthUnauthenticated){
//           return LoginPage();
//         }else{
//           return ScreenPage();
//         }

//       },),
      
//     );
  
//   }
// }

class Apps extends StatefulWidget {
  @override
  _AppsState createState() => _AppsState();
}

class _AppsState extends State<Apps> {
  AuthBloc authBloc;

  @override
  void initState() {
    authBloc=BlocProvider.of<AuthBloc>(context);
    authBloc.add(CheckAuthEvent());
    // TODO: implement initState
    
  }
  @override
  Widget build(BuildContext context) {
     return MaterialApp(
      home: BlocBuilder<AuthBloc,AuthState>(
        builder: (context,state){
        if(state is AuthAuthenticated){
          return HomePage();
        }else if(state is AuthUnauthenticated){
          return LoginPage();
        }else{
          print('elsekuted...');
          return ScreenPage();
        }

      },),
      
    );
  }
}



class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);



  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  AuthBloc authBloc;
  int _counter = 0;

  @override
  void initState() {
    authBloc=BlocProvider.of<AuthBloc>(context);
    authBloc.add(CheckAuthEvent());
    super.initState();
  }

  void _incrementCounter() {
    setState(() {
     
      _counter++;
    });
  }


  @override
  Widget build(BuildContext context) {
  
  }
}
