import 'package:e_commerce_app/features/cart/domain/entities/cart_entity.dart';
import 'package:e_commerce_app/features/e_commerce_clean/domain/entities/product_entity.dart';

class CartModel extends CartEntity {
  CartModel({
    required super.products,
  });
  factory CartModel.fromJson(Map<String, dynamic> json) {
    return CartModel(products: List<ProductEntity>.from(json["productsId"]));
  }
  Map<String, dynamic> toJson() {
    return {"productId": products};
  }
}
