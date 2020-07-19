import 'package:bookstore/bloc/auth/auth_event.dart';
import 'package:bookstore/bloc/auth/auth_state.dart';
import 'package:bloc/bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';



class AuthBloc extends Bloc<AuthEvent,AuthState>{
  @override
  // TODO: implement initialState
  AuthState get initialState => AuthUninitialized();

  @override
  Stream<AuthState> mapEventToState(AuthEvent event) async*{
    if(event is CheckAuthEvent){
      print("Checking AUth...");
      SharedPreferences prefs = await SharedPreferences.getInstance();
         var name= prefs.getString("name");
         if(name!=null){
           print("Passing Checking AUth...");
           yield AuthAuthenticated();
         }else{
            print("Failed Checking AUth...");
            yield AuthUnauthenticated();
         }
    }
  }
  
}
// class AuthBloc extends Bloc<AuthEvent,AuthState>{
 

//   @override
//   // TODO: implement initialState
//   AuthState get initialState => AuthUninitialized();

//   @override
//   Stream<AuthState> mapEventToState(AuthEvent event) async* { 
//     if(event is CheckAuthEvent){
//        print("Halloess");
//         SharedPreferences prefs = await SharedPreferences.getInstance();
//          var name= prefs.getString("name");
//          if(name!=null){
//            yield AuthAuthenticated();
//          }
//         yield AuthUnauthenticated();
//     }
//     // TODO: implement mapEventToState
//   }

// }