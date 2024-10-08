import 'package:dartz/dartz.dart';
import 'package:e_commerce_app/core/error/failure.dart';
import 'package:e_commerce_app/features/auth/domain/repo/auth_repo.dart';

class LogOutUsecase {
  AuthRepo repo;
  LogOutUsecase({required this.repo});
  Future<Either<Failure, Unit>> call() {
    return repo.logOutUser();
  }
}
