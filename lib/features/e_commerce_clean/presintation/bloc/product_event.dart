abstract class ProductEvent {
  const ProductEvent();
}

class GetAllProductsEvent extends ProductEvent {
  const GetAllProductsEvent();
}

class GetInCategoryEvent extends ProductEvent {
  final String category;
  const GetInCategoryEvent({required this.category});
}
