class UserModel{

  late String name;
  late String Email;
  late String UId;

  UserModel({
    required this.name,
    required this.Email,
    required this.UId
}){}

  UserModel.FromJson(Map<String,dynamic> date){

    name=date["Name"];
    Email=date["Email"];
    UId=date["Uid"];
  }

  Map<String,dynamic>ToMap(){

    return {
      "Name":name,
      "Email":Email,
      "Uid":UId,
    };
  }
}