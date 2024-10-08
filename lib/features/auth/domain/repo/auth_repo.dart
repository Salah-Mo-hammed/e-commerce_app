import 'package:dartz/dartz.dart';
import 'package:e_commerce_app/core/error/failure.dart';

abstract class AuthRepo {
  Future<Either<Failure,String>> logInUser(String email, String password);
  Future<Either<Failure,String>> registerUser(String email, String password);
  Future<Either<Failure,Unit>> logOutUser();
}
