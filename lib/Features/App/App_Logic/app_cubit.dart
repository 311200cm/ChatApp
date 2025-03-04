import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_cloud_firestore/firebase_cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:my_chat_app/core/Helpers/Models/MessageModel.dart';
import 'package:my_chat_app/core/Helpers/Models/User_Model.dart';

import '../../../core/Helpers/Constants/constants.dart';

part 'app_state.dart';

class AppCubit extends Cubit<AppState> {
  AppCubit() : super(AppInitial());
  static AppCubit get(context)=>BlocProvider.of(context);
  
  FirebaseAuth auth=FirebaseAuth.instance;
  FirebaseFirestore Data=FirebaseFirestore.instance;
  CollectionReference UserCollection= FirebaseFirestore.instance.collection(UserCollectionName);
  List<UserModel>Users=[];
  CollectionReference MassegeCollection=FirebaseFirestore.instance.collection(MessageCollectionName);
  List<MessageModel>Messages=[];


  void GetHome(){
    emit(GetHomeLoading());
    Users=[];
    UserCollection.snapshots()
    .listen((data){
      Users=[];
      for(var element in data.docs){
        if(auth.currentUser!.uid!=element.id){
          Users.add(UserModel.FromJson(element!.data()! as Map<String,dynamic>));
        }
      }
      emit(GetHomeSuccessfully());
    });
  }

  void SendMessage({
    required String contant,
    required String Rid
}){
    Data.collection(UserCollectionName)
    .doc(auth.currentUser!.uid)
    .collection("Chat")
    .doc(Rid)
    .collection(MessageCollectionName)
    .add(
      {
        "Contant":contant,
        "Time":Timestamp.now(),
        "Rid":Rid,
         "SendId":auth.currentUser!.uid
      }
    ).then((onValue){
      Data.collection(UserCollectionName)
      .doc(Rid)
      .collection("Chat")
      .doc(auth.currentUser!.uid)
          .collection(MessageCollectionName)
          .add(
      {
      "Contant":contant,
      "Time":Timestamp.now(),
      "Rid":Rid,
      "SendId":auth.currentUser!.uid
      }).then((value){
        emit(SendMessageSuccessfully());
      }).catchError((error){
        print(error);
        print(StackTrace);
        emit(SendMessageWithError(message: error.toString()));
      });
    })
    .catchError((onError){
      print(onError);
      print(StackTrace);
      emit(SendMessageWithError(message: onError.toString()));
    });
  }

  void GetAllMessage({
    required String rid})
  {
    emit(GetAllMessageLoading());
    UserCollection.doc(auth.currentUser!.uid)
    .collection("Chat")
    .doc(rid)
    .collection(MessageCollectionName)
    .orderBy("Time")
    .snapshots()
    .listen((onData){
      Messages=[];
      for(var element in onData.docs){
        Messages.add(MessageModel.FromJson(element!.data()! as Map<String,dynamic>));
      }
      emit(GetAllMessagesSuccessfully());
    });
  }
}
