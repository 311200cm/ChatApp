import 'package:firebase_cloud_firestore/firebase_cloud_firestore.dart';

class MessageModel{

 late String contant;
 late String Rid;
  late String SendId;
 late Timestamp Time;

  MessageModel({

    required this.Rid,
    required this.contant,
    required this.SendId,
    required this.Time
}){}

MessageModel.FromJson(Map<String,dynamic> json){

    Rid=json["Rid"];
    SendId=json["SendId"];
    contant=json["Contant"];
    Time=json["Time"];
}

Map<String,dynamic> ToMap(){
    return{
      "Rid":Rid,
      "SendId":SendId,
      "Time":Time,
      "Contant":contant
    };
}
}