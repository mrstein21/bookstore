import 'package:bookstore/server/server.dart';
import 'package:http/http.dart' as http;

abstract class AuthRepository{
  Future<String> RegisterUser(String name,String email,String password,String confirmation_password);
  Future<String> LoginUser(String email,String password);
}
String base_url=Server.url;



class AuthRepositoryImp implements AuthRepository{
  @override
  Future<String> LoginUser(String email, String password) async {
    var url=Server.url+"/login";
    var res = await http.post(Uri.encodeFull(url), body : {
      "email"       : email,
      "password"    : password,
    });
    if (res.statusCode == 200) {
       return res.body;
    }else{
      throw Exception();
    }
  }

  @override
  Future<String>RegisterUser(String name, String email, String password,String confirmation_password) async {
    var url=base_url+"/register";
    var res = await http.post(Uri.encodeFull(url), body : {
      "name"        : name,
      "email"       : email,
      "password"    : password,
      "confirmation_password":confirmation_password,
    });

    if (res.statusCode == 200) {
       return res.body;
    }else{
      throw Exception();
    }
  }
}