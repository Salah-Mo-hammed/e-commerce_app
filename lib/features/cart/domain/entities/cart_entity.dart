import 'package:e_commerce_app/features/e_commerce_clean/domain/entities/product_entity.dart';

class CartEntity {
  List<ProductEntity> products;
  CartEntity({required this.products});
}
