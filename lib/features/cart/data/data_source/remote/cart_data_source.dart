import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:e_commerce_app/core/error/failure.dart';
import 'package:e_commerce_app/features/e_commerce_clean/data/models/product_model.dart';

abstract class CartDataSource {
  Future<Either<Failure, Unit>> addToCart(String userId, ProductModel product);
  Future<Either<Failure, bool>> checkAdded(String userId, ProductModel product);
  Future<Either<Failure, Unit>> deleteFromCart(
      String userId, ProductModel productId);
  Future<Either<Failure, List<ProductModel>>> getCartProducts(String userId);
}

class FireStore implements CartDataSource {
  @override
  Future<Either<Failure, Unit>> addToCart(
      String userId, ProductModel product) async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    Map<String, dynamic> productData = product.toJson();
    await firestore.collection('carts').doc(userId).update({
      'productsId': FieldValue.arrayUnion([productData])
    });
    return const Right(unit);
  }

  @override
  Future<Either<Failure, Unit>> deleteFromCart(
      String userId, ProductModel product) async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    await firestore.collection('carts').doc(userId).update({
      'productsId': FieldValue.arrayRemove([product.toJson()])
    });
    return const Right(unit);
  }

  @override
  Future<Either<Failure, List<ProductModel>>> getCartProducts(
      String userId) async {
    try {
      FirebaseFirestore firestore = FirebaseFirestore.instance;

      final DocumentSnapshot<Map<String, dynamic>> data =
          await firestore.collection('carts').doc(userId).get();

      if (!data.exists || data.data() == null) {
        return const Left(DatabaseFailure("Cart not found"));
      }

      List<dynamic> productsDataList =
          data.data()!['productsId'] as List<dynamic>;

      if (productsDataList.isEmpty) {
        return const Right([]);
      }

      List<ProductModel> products = productsDataList
          .map((productData) => ProductModel.fromJson(productData))
          .toList();

      return Right(products);
    } catch (e) {
      return Left(DatabaseFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> checkAdded(
      String userId, ProductModel product) async {
    try {
      FirebaseFirestore firestore = FirebaseFirestore.instance;

      final DocumentSnapshot<Map<String, dynamic>> data =
          await firestore.collection('carts').doc(userId).get();

      if (!data.exists || data.data() == null) {
        return const Right(false);
      }

      List<dynamic> productsList = data.data()!['productsId'] as List<dynamic>;

      bool isAdded = productsList.any((p) => p['id'] == product.id);

      return Right(isAdded);
    } catch (e) {
      return Left(DatabaseFailure(e.toString()));
    }
  }
}
