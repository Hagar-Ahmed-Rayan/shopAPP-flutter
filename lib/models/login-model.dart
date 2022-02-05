class ShopLoginModel
{
  late bool status;
  late dynamic message;//string
  late UserData data;

  ShopLoginModel.fromJson(Map< dynamic, dynamic> json)//String, dynamic
  {
    status = json['status'];
    message = json['message'];
    data = (json['data'] != null ? UserData.fromJson(json['data']) : null)!;
  }
}

class UserData
{

  late dynamic name;
  late dynamic email;
  late dynamic phone;
  late dynamic image;
  late dynamic points;//int
  late dynamic credit;//int
  late dynamic token;
  late dynamic id;//int

  // named constructor
  UserData.fromJson(Map<dynamic, dynamic> json)  //Map<String, dynamic
  {

    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    image = json['image'];
    points = json['points'];
    credit = json['credit'];
    token = json['token'];
    id = json['id'];
  }
}