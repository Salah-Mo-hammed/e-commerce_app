import 'package:e_commerce_app/features/e_commerce_clean/domain/entities/product_entity.dart';

abstract class CartState {
  final List<ProductEntity>? products;
  const CartState({this.products});
}

class CartStateLoading extends CartState {
  const CartStateLoading();
}

class CartStateInitial extends CartState {
  const CartStateInitial();
}

class CartStateDone extends CartState {
  List<ProductEntity> productsList;
  CartStateDone({required this.productsList}) : super(products: productsList);
}

class CartStateUpdate extends CartState {
  const CartStateUpdate();
}

class CartStateException extends CartState {
  String message;
  CartStateException({required this.message});
}

class CartStateCheckAdded extends CartState {
  bool isAdded;
  CartStateCheckAdded({required this.isAdded});
}
