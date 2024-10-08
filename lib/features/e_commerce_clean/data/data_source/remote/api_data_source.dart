import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:e_commerce_app/core/error/failure.dart';
import 'package:e_commerce_app/features/e_commerce_clean/data/models/product_model.dart';

abstract class ProductApiDataSource {
  Future<Either<Failure, List<ProductModel>>> getAllProducts();
  Future<Either<Failure, List<ProductModel>>> getinCategory(String category);


}

class WithDio implements ProductApiDataSource {
  String baseUrl = 'https://fakestoreapi.com/products';
  final Dio dio = Dio();

  @override
  Future<Either<Failure, List<ProductModel>>> getAllProducts() async {
    try {
      final Response response = await dio.get(baseUrl);
      if (response.statusCode == 200) {
        final List data = response.data;
        List<ProductModel> dataList =
            data.map((index) => ProductModel.fromJson(index)).toList();
        return Right(dataList);
      } else {
        return Left(ServerFailure(response.statusMessage!));
      }
    } catch (e) {
      return const Left(ServerFailure(" Server Failure (catch)"));
    }
  }

  @override
  Future<Either<Failure, List<ProductModel>>> getinCategory(
      String category) async {
    try {
      final Response response = await dio.get("$baseUrl/category/$category");
      if (response.statusCode == 200) {
        final List data = response.data;
        List<ProductModel> dataList =
            data.map((index) => ProductModel.fromJson(index)).toList();
        return Right(dataList);
      } else {
        return Left(ServerFailure(response.statusMessage!));
      }
    } catch (e) {
      return const Left(ServerFailure(" Server Failure "));
    }
  }
}
