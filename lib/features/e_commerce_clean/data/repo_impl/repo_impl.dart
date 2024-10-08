import 'package:dartz/dartz.dart';
import 'package:e_commerce_app/core/error/failure.dart';
import 'package:e_commerce_app/features/e_commerce_clean/data/data_source/remote/api_data_source.dart';
import 'package:e_commerce_app/features/e_commerce_clean/domain/entities/product_entity.dart';
import 'package:e_commerce_app/features/e_commerce_clean/domain/repo/product_repo.dart';

class ProductRepoImpl implements ProductRepo {
  ProductApiDataSource productApiDataSource;
  ProductRepoImpl({required this.productApiDataSource});
  @override
  Future<Either<Failure, List<ProductEntity>>> getAllProducts() {
    return productApiDataSource.getAllProducts();
  }

  @override
  Future<Either<Failure, List<ProductEntity>>> getinCategory(String category) {
    return productApiDataSource.getinCategory(category);
  }
}
