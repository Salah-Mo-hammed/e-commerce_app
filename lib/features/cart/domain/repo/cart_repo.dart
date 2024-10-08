import 'package:dartz/dartz.dart';
import 'package:e_commerce_app/core/error/failure.dart';
import 'package:e_commerce_app/features/e_commerce_clean/domain/entities/product_entity.dart';

abstract class CartRepo {
  Future<Either<Failure, void>> addToCart(String userId,ProductEntity product);
  Future<Either<Failure, void>> deleteFromCart(String userId,ProductEntity product);
  Future<Either<Failure, List<ProductEntity>>> getCartProducts(String userId);
    Future<Either<Failure, bool>> checkAdded(
      String userId, ProductEntity product);
}
