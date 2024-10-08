import 'package:e_commerce_app/features/e_commerce_clean/domain/entities/product_entity.dart';

abstract class CartEvent {
  const CartEvent();
}

class StartEvent extends CartEvent {}

class AddEvent extends CartEvent {
  String userId;
  ProductEntity productId;
  AddEvent({required this.productId, required this.userId});
}

class DeleteEvent extends CartEvent {
  String userId;
  ProductEntity product;
  DeleteEvent({required this.product, required this.userId});
}

class GetAllCartsProductsEvent extends CartEvent {
  String userId;

  GetAllCartsProductsEvent({required this.userId});
}

class CheckAddedEvent extends CartEvent {
  String userId;
  ProductEntity productEntity;
  CheckAddedEvent({required this.productEntity, required this.userId});
}
