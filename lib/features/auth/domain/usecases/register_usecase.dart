import 'package:dartz/dartz.dart';
import 'package:e_commerce_app/core/error/failure.dart';
import 'package:e_commerce_app/features/auth/domain/repo/auth_repo.dart';

class RegisterUsecase {
  AuthRepo repo;
  RegisterUsecase({required this.repo});
  Future<Either<Failure, String>> call(String email, String password) {
    return repo.registerUser(email, password);
  }
}
