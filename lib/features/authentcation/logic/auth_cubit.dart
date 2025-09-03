import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../core/constants/constants.dart';
import '../../app/models/user_model.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  static AuthCubit get(context)=>BlocProvider.of(context);
  FirebaseAuth auth=FirebaseAuth.instance;
  FirebaseFirestore data=FirebaseFirestore.instance;

  UserModel? userModel;
  void rigisterWithEmailAndPassword({
     required String name,
    required String email,
    required String password
  }){
    emit(RegisterLoading());
    auth.createUserWithEmailAndPassword(email: email, password:password)
        .then((value){
          data.collection(userCollectionName)
          .doc(auth.currentUser!.uid)
              .set(
            {
              "Email":email,
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

  void signInWithEmailAndPassword({
    required String email,
    required String password,
}){
    emit(SignInLoading());
    auth.signInWithEmailAndPassword(email: email, password:password)
    .then((value){
      data.collection(userCollectionName)
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
