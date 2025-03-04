import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:my_chat_app/core/Helpers/Models/User_Model.dart';

import '../../../core/Helpers/Constants/constants.dart';
part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  static AuthCubit get(context)=>BlocProvider.of(context);
  FirebaseAuth auth=FirebaseAuth.instance;
  FirebaseFirestore data=FirebaseFirestore.instance;

  UserModel? userModel;
  void RigisterWithEmailAndPassword({
     required String name,
    required String Email,
    required String Password
  }){
    emit(RegisterLoading());
    auth.createUserWithEmailAndPassword(email: Email, password:Password)
        .then((value){
          data.collection(UserCollectionName)
          .doc(auth.currentUser!.uid)
              .set(
            {
              "Email":Email,
              "Name":name,
              "Uid":value.user!.uid
            }
          ).then((value){
            emit(RegisterSuccessfully());
          }).catchError((onError){
            emit(RegisterWithError(message:onError.toString()));
          });
    })
        .catchError((onError){

      emit(RegisterWithError(message: onError.toString()));
    });
  }

  void SignInWithEmailAndPassword({
    required String Email,
    required String Password,
}){
    emit(SignInLoading());
    auth.signInWithEmailAndPassword(email: Email, password:Password)
    .then((value){
      data.collection(UserCollectionName)
      .doc(value.user!.uid)
      .get()
      .then((onValue){
        userModel=UserModel.FromJson(onValue.data()!);
        emit(SignInSuccessfully());
      })
      .catchError((onError){
        print(onError);
        print(StackTrace);
        emit(SignInWithError(message: onError.toString()));
      });

    })
    .catchError((onError){
      print(onError);
      print(StackTrace);
      emit(SignInWithError(message: onError.toString()));
    });
  }
}
