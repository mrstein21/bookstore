
import 'package:bookstore/bloc/login/login_bloc.dart';
import 'package:bookstore/bloc/login/login_event.dart';
import 'package:bookstore/bloc/login/login_state.dart';
import 'package:bookstore/mixins/users_validator.dart';
import 'package:bookstore/ui/auth/register.dart';
import 'package:bookstore/ui/home.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget{
  @override
    LoginPageState createState() => LoginPageState();
  
}


class LoginPageState extends State<LoginPage> with UserValidator{
  final formKey = GlobalKey<FormState>(); 
  String email="";
  String password="";
LoginBloc loginBloc;



@override
  void initState() {
     loginBloc=BlocProvider.of<LoginBloc>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ProgressDialog progressDialog= new ProgressDialog(context);
    String result="";
    // TODO: implement build
    return MaterialApp(
      debugShowCheckedModeBanner: false,
       home:  Builder(
         builder:(context){
           return Material(
             child: Scaffold(
               body: Container(
                 child: BlocListener<LoginBloc,LoginState>(
                   listener:(context,state){
                     progressDialog.dismiss();
                     if(state is LoginFailure){
                       print("Terekseskusi gan");
                       result=state.message;
                       //authBloc.add(UninitializedEvent());
                     }else if(state is LoginSuccess){
                       progressDialog.dismiss();
                       result="";
                      Navigator.pushReplacement(context, MaterialPageRoute(
                                builder: (context)=> HomePage()
                            ));                       
                     }
                    
                   } ,
                   child:  Center(
                       child: SingleChildScrollView(
                         child: Container(
                           padding: EdgeInsets.all(30),
                           child:Form(
                             key: formKey,
                             child: Column(
                               mainAxisSize: MainAxisSize.max,
                               mainAxisAlignment: MainAxisAlignment.center,
                               crossAxisAlignment: CrossAxisAlignment.center,
                               children: <Widget>[
                                 Center(
                                 child:Text("Mr.Stein's Book Store",textAlign:TextAlign.center,style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontStyle: FontStyle.italic,
                                    fontFamily: "Pacifico",
                                    fontSize: 40)),
                                 ),
                                 SizedBox(height:50),
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
                                 SizedBox(height:30),
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
                                 SizedBox(height:30),
                                 SizedBox(
                                   width: double.infinity,
                                   height: 50,
                                   child: RaisedButton(
                                     color: Colors.blue,
                                     onPressed: (){
                                        if (formKey.currentState.validate()) { 
                                           formKey.currentState.save();
                                           print("JEEEZ");
                                           loginBloc.add(LoginAttempt(username:  email,password: password));
                                           //if(state is AuthLoadingState){
                                            progressDialog.style(
                                                  message: "Loading...",
                                                );
                                              progressDialog.show();
                                           //}
                                        }
                                     },
                                      shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(10.0)),
                                      elevation: 4.0,
                                      child: Text("Login",style:TextStyle( color: Colors.white,fontSize: 15.0,)),
                                    ),                             
                                 ),
                                 SizedBox(height:20),
                                 GestureDetector(
                                   onTap: (){
                                     Navigator.push(context,MaterialPageRoute(
                                       builder: (context)=>RegisterPage()
                                     ));
                                   },
                                   child: Text("Register Now",style:TextStyle( color: Colors.blue,fontSize: 15.0,)),
                                 ),
                                   SizedBox(height:20),
                                   Text(result,style:TextStyle( color: Colors.red,fontSize: 15.0,))
                               ],
                             ),
                           ),
                         ),
                       ),
                     ),
                 ),
               ),
             ),
           );
         }
       )
    );
  }
}