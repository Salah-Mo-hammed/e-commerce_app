import 'package:dartz/dartz.dart';
import 'package:e_commerce_app/core/error/failure.dart';
import 'package:e_commerce_app/features/e_commerce_clean/domain/entities/product_entity.dart';
import 'package:e_commerce_app/features/e_commerce_clean/domain/repo/product_repo.dart';

class GetAllProductsUsecase {
  ProductRepo productRepo;
  GetAllProductsUsecase({required this.productRepo});
  Future<Either<Failure, List<ProductEntity>>> call() {
    return productRepo.getAllProducts();
  }
}
