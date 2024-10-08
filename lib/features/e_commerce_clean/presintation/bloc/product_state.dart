import 'package:e_commerce_app/features/e_commerce_clean/domain/entities/product_entity.dart';

abstract class ProductState {
  final List<ProductEntity>? productsList;
  final String? message;
  const ProductState({this.productsList, this.message});
}

class ProductStateLoading extends ProductState {
  const ProductStateLoading();
}

class ProductStateDone extends ProductState {
  final List<ProductEntity>? products;
  const ProductStateDone({required this.products})
      : super(productsList: products);
}

class ProductStateException extends ProductState {
  final String? exception;
  const ProductStateException({required this.exception})
      : super(message: exception);
}
