
import 'package:bookstore/bloc/auth/auth_bloc.dart';
import 'package:bookstore/bloc/auth/auth_event.dart';
import 'package:bookstore/bloc/auth/auth_state.dart';
import 'package:bookstore/bloc/register/register_bloc.dart';
import 'package:bookstore/bloc/register/register_event.dart';
import 'package:bookstore/bloc/register/register_state.dart';
import 'package:bookstore/mixins/users_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:progress_dialog/progress_dialog.dart';

class RegisterPage extends StatefulWidget{

  @override
  RegisterPageState createState() =>RegisterPageState();
  
}

class RegisterPageState extends State<RegisterPage> with UserValidator{
  RegisterBloc registerBloc;
  final formKey = GlobalKey<FormState>(); //MEMBUAT GLOBAL KEY UNTUK VALIDASI 

  String name = '';
  String email = '';
  String password = '';
  String confirmation_password='';

  @override
  void initState() {
    registerBloc=BlocProvider.of<RegisterBloc>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
   ProgressDialog progressDialog= new ProgressDialog(context);
   String result="";
    // TODO: implement build
    return MaterialApp(
       home: Builder(builder: (context){
         return Material(
           child: Scaffold(
             appBar: AppBar(
               title: Text("Register"),
             ),
             body: Container(
               child: BlocBuilder<RegisterBloc,RegisterState>(builder: (context,state){
                 progressDialog.dismiss();
                 if(state is RegisterSuccess){
                      progressDialog.dismiss();
                      result="Berhasil mendaftar";
                     // authBloc.add(UninitializedEvent());
                  

                  }else if(state is RegisterFailure){
                       progressDialog.dismiss();
                       result=state.message;
                       //authBloc.add(UninitializedEvent());
                }
                 return Container(
                   padding: EdgeInsets.all(20),
                   margin: EdgeInsets.only(top:20),
                   child  :SingleChildScrollView(
                        child: Form(
                          key: formKey,
                          child: Column(
                          children: <Widget>[
                            TextFormField(
                              validator: validateName,
                              onSaved: (String value){
                                name=value;
                              },
                              style:  new TextStyle(
                                  fontFamily: "Poppins",
                               ),
                               decoration: InputDecoration(
                                 labelText: "Name",
                                 border: OutlineInputBorder(
                                     borderRadius: new BorderRadius.circular(10.0),
                                    borderSide: new BorderSide(),
                                 )
                               ),
                            ),
                            SizedBox(
                              height: 30,
                            ),
                              TextFormField(
                              validator: validateEmail,
                              onSaved: (String value){
                                email=value;
                              },
                              style:  new TextStyle(
                                  fontFamily: "Poppins",
                               ),
                               decoration: InputDecoration(
                                 labelText: "Email",
                                 border: OutlineInputBorder(
                                     borderRadius: new BorderRadius.circular(10.0),
                                    borderSide: new BorderSide(),
                                 )
                               ),
                            ),
                             SizedBox(
                              height: 30,
                            ),
                              TextFormField(
                              obscureText: true,
                              validator: validatePassword,
                              onSaved: (String value){
                                password=value;
                              },
                              style:  new TextStyle(
                                  fontFamily: "Poppins",
                               ),
                               decoration: InputDecoration(
                                 labelText: "Password",
                                 border: OutlineInputBorder(
                                     borderRadius: new BorderRadius.circular(10.0),
                                    borderSide: new BorderSide(),
                                 )
                               ),
                            ),
                             SizedBox(
                              height: 30,
                            ),
                              TextFormField(
                              obscureText: true,
                              validator: validateConfirmatePassword,
                              onSaved: (String value){
                                confirmation_password=value;
                              },
                              style:  new TextStyle(
                                  fontFamily: "Poppins",
                               ),
                               decoration: InputDecoration(
                                 labelText: "Confirmation Password",
                                 border: OutlineInputBorder(
                                     borderRadius: new BorderRadius.circular(10.0),
                                    borderSide: new BorderSide(),
                                 )
                               ),
                            ),
                             SizedBox(
                              height: 30,
                            ),
                            SizedBox(
                              width:double.infinity,
                              height: 50,
                              child: RaisedButton(
                              color: Colors.blue,
                              onPressed: (){
                                if (formKey.currentState.validate()) { 
                                   formKey.currentState.save();
                                   registerBloc.add(
                                   RegisterAttempt(
                                   confirmation_password: confirmation_password,
                                   password: password,
                                   name :name,
                                   email:email)
                                  );
                                
                                  progressDialog.style(
                                              message: "Loading...",
                                            );
                                     progressDialog.show();
                                }//JIKA TRUE
                              },
                               shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(10.0)),
                               elevation: 4.0,
                               child: Text("Register",style:TextStyle( color: Colors.white,fontSize: 15.0,)),
                            ),
                            ),SizedBox(
                              height:20,
                            ),
                            Text(result,style: TextStyle(color: Colors.blue,fontSize: 12.0),)
                          ],
                     ),
                        ),
                   ) ,
                 );
               }),
             ),
           ),
         );
       }),
    );
  }
  
}