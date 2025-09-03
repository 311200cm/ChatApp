import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_cloud_firestore/firebase_cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../../../core/constants/constants.dart';
import '../models/message_model.dart';
import '../models/user_model.dart';


part 'app_state.dart';

class AppCubit extends Cubit<AppState> {
  AppCubit() : super(AppInitial());
  static AppCubit get(context)=>BlocProvider.of(context);
  
  FirebaseAuth auth=FirebaseAuth.instance;
  FirebaseFirestore data=FirebaseFirestore.instance;
  CollectionReference userCollection= FirebaseFirestore.instance.collection(userCollectionName);
  List<UserModel>users=[];
  CollectionReference massegeCollection=FirebaseFirestore.instance.collection(messageCollectionName);
  List<MessageModel>messages=[];


  void getHome(){
    emit(GetHomeLoading());
    users=[];
    userCollection.snapshots()
    .listen((data){
      users=[];
      for(var element in data.docs){
        if(auth.currentUser!.uid!=element.id){
          users.add(UserModel.FromJson(element!.data()! as Map<String,dynamic>));
        }
      }
      emit(GetHomeSuccessfully());
    });
  }

  void sendMessage({
    required String contant,
    required String rid
}){
    data.collection(userCollectionName)
    .doc(auth.currentUser!.uid)
    .collection("Chat")
    .doc(rid)
    .collection(messageCollectionName)
    .add(
      {
        "Contant":contant,
        "Time":Timestamp.now(),
        "Rid":rid,
         "SendId":auth.currentUser!.uid
      }
    ).then((onValue){
      data.collection(userCollectionName)
      .doc(rid)
      .collection("Chat")
      .doc(auth.currentUser!.uid)
          .collection(messageCollectionName)
          .add(
      {
      "Contant":contant,
      "Time":Timestamp.now(),
      "Rid":rid,
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

  void getAllMessage({
    required String rid})
  {
    emit(GetAllMessageLoading());
    userCollection.doc(auth.currentUser!.uid)
    .collection("Chat")
    .doc(rid)
    .collection(messageCollectionName)
    .orderBy("Time")
    .snapshots()
    .listen((onData){
      messages=[];
      for(var element in onData.docs){
        messages.add(MessageModel.FromJson(element!.data()! as Map<String,dynamic>));
      }
      emit(GetAllMessagesSuccessfully());
    });
  }
}
