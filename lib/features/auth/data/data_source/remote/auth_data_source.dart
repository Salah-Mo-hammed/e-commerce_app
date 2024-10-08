// ignore_for_file: unused_local_variable, avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:e_commerce_app/core/error/failure.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthDataSource {
  Future<Either<Failure, String>> logInUser(
      String emailAddress, String password) async {
    try {
      final credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: emailAddress, password: password);
      return Right(credential.user!.uid);
    } on FirebaseAuthException catch (e) {
      print("-----------------${e.code}");
      if (e.code == 'user-not-found') {
        return const Left(AuthFailure("No user found for that email."));
      } else if (e.code == 'wrong-password') {
        return const Left(
            AuthFailure("Wrong password provided for that user."));
      }
      return const Left(AuthFailure("sorry there is a problem try again"));
    }
  }

  Future<Either<Failure, Unit>> logOutUser() async {
    await FirebaseAuth.instance.signOut();
    print("------------------------------------ sign out is done");
    return const Right(unit);
  }

  Future<Either<Failure, String>> registerUser(
      String emailAddress, String password) async {
    try {
      final credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: emailAddress, password: password);
      final firestore = FirebaseFirestore.instance;

      await firestore
          .collection('carts')
          .doc(credential.user?.uid)
          .set({'productsId': []});
      return Right(credential.user!.uid);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        return const Left(AuthFailure("The password provided is too weak."));
      } else if (e.code == 'email-already-in-use') {
        return const Left(
            AuthFailure("The account already exists for that email."));
      }
      return const Left(AuthFailure("sorry connection is unstable"));
    }
  }
}
