import 'package:dartz/dartz.dart';
import 'package:e_commerce_app/core/error/failure.dart';
import 'package:e_commerce_app/features/cart/data/data_source/remote/cart_data_source.dart';
import 'package:e_commerce_app/features/cart/domain/repo/cart_repo.dart';
import 'package:e_commerce_app/features/e_commerce_clean/data/models/product_model.dart';
import 'package:e_commerce_app/features/e_commerce_clean/domain/entities/product_entity.dart';

class CartRepoImpl implements CartRepo {
  CartDataSource cartDataSource;
  CartRepoImpl({required this.cartDataSource});
  @override
  Future<Either<Failure, void>> addToCart(
      String userId, ProductEntity product) {
    ProductModel productModel = ProductModel(
        id: product.id,
        title: product.title,
        price: product.price,
        description: product.description,
        category: product.category,
        image: product.image,
        rating: product.rating);
    return cartDataSource.addToCart(userId, productModel);
  }

  @override
  Future<Either<Failure, void>> deleteFromCart(
      String userId, ProductEntity product) {
   
  ProductModel productModel=  ProductModel(
        id: product.id,
        title: product.title,
        price: product.price,
        description: product.description,
        category: product.category,
        image: product.image,
        rating: product.rating);
    return cartDataSource.deleteFromCart(userId, productModel);
  }

  @override
  Future<Either<Failure, List<ProductModel>>> getCartProducts(String userId) {
    return cartDataSource.getCartProducts(userId);
  }

  @override
  Future<Either<Failure, bool>> checkAdded(
      String userId, ProductEntity product) {
    ProductModel productModel = ProductModel(
        id: product.id,
        title: product.title,
        price: product.price,
        description: product.description,
        category: product.category,
        image: product.image,
        rating: product.rating);
    return cartDataSource.checkAdded(userId, productModel);
  }
}
