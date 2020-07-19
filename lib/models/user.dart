class User{
  String email;
  String name;

   User(Map<String, dynamic> data) {
    name = data['name'];
    email = data['email'];
  }
}