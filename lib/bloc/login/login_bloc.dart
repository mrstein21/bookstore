import 'dart:convert';
import 'package:bookstore/bloc/login/login_event.dart';
import 'package:bookstore/bloc/login/login_state.dart';
import 'package:bloc/bloc.dart';
import 'package:bookstore/models/user.dart';
import 'package:bookstore/resource/auth_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  AuthRepository authRepository;
  LoginBloc({this.authRepository});

  @override
  LoginState get initialState => LoginUnitialized();

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    if (event is LoginAttempt) {
      LoginAttempt loginEvent = event as LoginAttempt;
      var email = loginEvent.username;
      var password = loginEvent.password;
      try {
        var data = await authRepository.LoginUser(email, password);
        var content = json.decode(data);
        if (content["success"] == "0") {
          yield LoginFailure(message: "Username atau password salah !");
        } else {
          User user = User(content["data"]);
          SharedPreferences prefs = await SharedPreferences.getInstance();
          await prefs.setString("name", user.name);
          await prefs.setString("email", user.email);
          await prefs.setString("id", content["data"]["id"].toString());
          yield LoginSuccess();
        }
      } catch (e) {
        yield LoginFailure(message: "Kesalahan jaringan");
      }
    }
    // TODO: implement mapEventToState
  }
}
