import 'package:dartz/dartz.dart';
import 'package:e_commerce_app/core/error/failure.dart';
import 'package:e_commerce_app/features/cart/domain/repo/cart_repo.dart';
import 'package:e_commerce_app/features/e_commerce_clean/domain/entities/product_entity.dart';

class DeleteFromCartUsecase {
  CartRepo repo;
  DeleteFromCartUsecase({required this.repo});
  Future<Either<Failure, void>> call(String userId,ProductEntity product) {
    return repo.deleteFromCart(userId,product);
  }
}
