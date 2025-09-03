class UserModel{

  late String name;
  late String email;
  late String userId;

  UserModel({
    required this.name,
    required this.email,
    required this.userId
}){}

  UserModel.FromJson(Map<String,dynamic> date){

    name=date["Name"];
    email=date["Email"];
    userId=date["Uid"];
  }

  Map<String,dynamic>ToMap(){

    return {
      "Name":name,
      "Email":email,
      "Uid":userId,
    };
  }
}