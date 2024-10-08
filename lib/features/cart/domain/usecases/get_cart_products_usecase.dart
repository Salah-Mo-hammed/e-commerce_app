

import 'package:dartz/dartz.dart';
import 'package:e_commerce_app/core/error/failure.dart';
import 'package:e_commerce_app/features/cart/domain/repo/cart_repo.dart';
import 'package:e_commerce_app/features/e_commerce_clean/domain/entities/product_entity.dart';

class GetCartProductsUsecase {
  CartRepo repo;
  GetCartProductsUsecase({required this.repo});
  Future<Either<Failure, List<ProductEntity>>> call(String userId) {
    return repo.getCartProducts(userId);
  }
}
 