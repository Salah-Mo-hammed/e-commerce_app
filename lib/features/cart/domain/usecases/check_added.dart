
import 'package:dartz/dartz.dart';
import 'package:e_commerce_app/core/error/failure.dart';
import 'package:e_commerce_app/features/cart/domain/repo/cart_repo.dart';
import 'package:e_commerce_app/features/e_commerce_clean/domain/entities/product_entity.dart';

class CheckAddedUsecase {
  CartRepo cartRepo;
  CheckAddedUsecase({required this.cartRepo,});
  Future<Either<Failure, bool>> call(String userId, ProductEntity product) {
    return cartRepo.checkAdded(userId, product);
  }
}
