import 'package:firebase_cloud_firestore/firebase_cloud_firestore.dart';

class MessageModel{

 late String contant;
 late String rid;
  late String sendId;
 late Timestamp time;

  MessageModel({

    required this.rid,
    required this.contant,
    required this.sendId,
    required this.time
}){}

MessageModel.FromJson(Map<String,dynamic> json){

  rid=json["Rid"];
  sendId=json["SendId"];
    contant=json["Contant"];
  time=json["Time"];
}

Map<String,dynamic> ToMap(){
    return{
      "Rid":rid,
      "SendId":sendId,
      "Time":time,
      "Contant":contant
    };
}
}