class User {
  // instance variables
  late String? email;
  late String? password;
  late String? name;
  late String? idNumber;

  User({this.email, this.password, this.name, this.idNumber});

  User.fromJson(Map<String, dynamic> json) {
    email = json["email"];
    password = json["password"];
    name = json["name"];
    idNumber = json["idNumber"];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};

    _data["email"] = email;
    _data["password"] = password;
    _data["name"] = name;
    _data["idNumber"] = idNumber;

    return _data;
  }
}
