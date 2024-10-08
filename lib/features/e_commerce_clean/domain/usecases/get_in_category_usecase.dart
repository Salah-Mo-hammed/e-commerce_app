import 'package:dartz/dartz.dart';
import 'package:e_commerce_app/core/error/failure.dart';
import 'package:e_commerce_app/features/e_commerce_clean/domain/entities/product_entity.dart';
import 'package:e_commerce_app/features/e_commerce_clean/domain/repo/product_repo.dart';

class GetInCategoryUsecase {
  ProductRepo productRepo;
  GetInCategoryUsecase({required this.productRepo});
  Future<Either<Failure, List<ProductEntity>>> call(String category) {
    return productRepo.getinCategory(category);
  }
}
