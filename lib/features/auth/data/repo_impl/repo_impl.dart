import 'package:dartz/dartz.dart';
import 'package:e_commerce_app/core/error/failure.dart';
import 'package:e_commerce_app/features/auth/data/data_source/remote/auth_data_source.dart';
import 'package:e_commerce_app/features/auth/domain/repo/auth_repo.dart';

class AuthRepoImpl implements AuthRepo {
  AuthDataSource authDataSource;
  AuthRepoImpl({required this.authDataSource});
  @override
  Future<Either<Failure, String>> logInUser(String email, String password) {
    return authDataSource.logInUser(email, password);
  }

  @override
  Future<Either<Failure, Unit>> logOutUser() {
    return authDataSource.logOutUser();
  }

  @override
  Future<Either<Failure, String>> registerUser(String email, String password) {
    return authDataSource.registerUser(email, password);
  }
}
