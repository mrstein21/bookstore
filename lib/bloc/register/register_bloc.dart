import 'dart:convert';

import 'package:bookstore/bloc/register/register_event.dart';
import 'package:bookstore/bloc/register/register_state.dart';
import 'package:bloc/bloc.dart';
import 'package:bookstore/resource/auth_repository.dart';

class RegisterBloc extends Bloc<RegisterEvent,RegisterState>{
  AuthRepository authRepository;
  RegisterBloc({
    this.authRepository
  });
  
  @override
  // TODO: implement initialState
  RegisterState get initialState => RegisterUninitialized();

  @override
  Stream<RegisterState> mapEventToState(RegisterEvent event) async* {
    if(event is RegisterAttempt){
        RegisterAttempt registerEvent=event as RegisterAttempt;
        var name=registerEvent.name;
        var email=registerEvent.email;
        var password=registerEvent.password;
        var confirmation_password=registerEvent.confirmation_password;
        print("tess "+name);
        try{
          var data=await authRepository.RegisterUser(name, email, password, confirmation_password);
          var content=json.decode(data);
          print("hasil "+content["success"]);
          if(content["success"].toString()=="0"){
          print("KESINI "+content["success"]);
            yield RegisterSuccess();
          }else{
            print("KESINI "+content["success"]);
            yield RegisterFailure(message:content["message"]);
          }
        }catch(e){
          yield RegisterFailure(message:"Kesalahan Jaringan");
        }
    }
      
    // TODO: implement mapEventToState
  }

}