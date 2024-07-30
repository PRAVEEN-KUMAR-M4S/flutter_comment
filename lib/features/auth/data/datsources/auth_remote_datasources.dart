import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_comment/core/error/exceptions.dart';
import 'package:flutter_comment/features/auth/data/model/user_model.dart';

abstract interface class AuthRemoteDatasources {
  Future<User?> signUpWithEmailandPassword(
      {required String name, required String email, required String password});

  Future<User?> signInWithEmailandPassword(
      {required String email, required String password});

  Future<UserModel?> getCurrentSession();

  Stream<User?> authStateChanges();

    Future<void> signOut();
}

class AuthRemoteDatasourcesImp implements AuthRemoteDatasources {
  final FirebaseAuth firebaseAuth;
  final FirebaseFirestore firebaseFirestore;

  AuthRemoteDatasourcesImp(
      {required this.firebaseAuth, required this.firebaseFirestore});

 

  @override
  Future<User?> signInWithEmailandPassword(
      {required String email, required String password}) async {
  
    try {
      final response = await firebaseAuth.signInWithEmailAndPassword(
        password: password,
        email: email,
      );
      if (response.user == null) {
         throw FirebaseExp(message: 'Sign In Failed !');
      }
    
      return response.user;
    } catch (e) {
       throw FirebaseExp(message: e.toString());
     
    }
  }

  @override
  Future<User?> signUpWithEmailandPassword(
      {required String name,
      required String email,
      required String password}) async {
    try {
      final response = await firebaseAuth.createUserWithEmailAndPassword(
        password: password,
        email: email,
      );

      await firebaseFirestore
          .collection('users')
          .doc(firebaseAuth.currentUser!.email)
          .set({
        'id': firebaseAuth.currentUser!.email,
        'name': name,
        'email': email
      });

      if (response.user == null) {
        throw FirebaseExp(message: 'Sign Up Failed !');
      }
      return response.user;
    } catch (e) {
     throw FirebaseExp(message: e.toString());
       
    }
  }

  @override
  Future<UserModel?> getCurrentSession() async {
    try {
      if (firebaseAuth.currentUser != null) {
        final userData = await firebaseFirestore
            .collection('users')
            .doc(firebaseAuth.currentUser!.email)
            .get();
        return UserModel.fromMap(userData.data() as Map<String, dynamic>);
      }
      return null;
    } catch (e) {
      throw FirebaseExp(message: e.toString());
       
    }
  }
  
  @override
Stream<User?> authStateChanges() => firebaseAuth.authStateChanges();
  
  @override
  Future<void> signOut() async{
     await firebaseAuth.signOut();
  }
}
