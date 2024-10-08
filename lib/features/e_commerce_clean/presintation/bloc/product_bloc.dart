import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:e_commerce_app/core/error/failure.dart';
import 'package:e_commerce_app/features/e_commerce_clean/domain/entities/product_entity.dart';
import 'package:e_commerce_app/features/e_commerce_clean/domain/usecases/get_all_products_usecase.dart';
import 'package:e_commerce_app/features/e_commerce_clean/domain/usecases/get_in_category_usecase.dart';
import 'package:e_commerce_app/features/e_commerce_clean/presintation/bloc/product_event.dart';
import 'package:e_commerce_app/features/e_commerce_clean/presintation/bloc/product_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  GetAllProductsUsecase getAllProductsUsecase;
  GetInCategoryUsecase getInCategoryUsecase;
  ProductBloc({
    required this.getAllProductsUsecase,
    required this.getInCategoryUsecase,
  }) : super(const ProductStateLoading()) {
    on<GetAllProductsEvent>(_onGetAllProducts);
    on<GetInCategoryEvent>(_onGetInCategory);
  }

  FutureOr<void> _onGetAllProducts(
      GetAllProductsEvent event, Emitter<ProductState> emit) async {
    final Either<Failure, List<ProductEntity>> result =
        await getAllProductsUsecase.call();
    result.fold((failure) {
      emit(ProductStateException(exception: failure.message));
    }, (productsList) {
      emit(ProductStateDone(products: productsList));
    });
  }

  FutureOr<void> _onGetInCategory(
      GetInCategoryEvent event, Emitter<ProductState> emit) async {
    final Either<Failure, List<ProductEntity>> result =
        await getInCategoryUsecase.call(event.category);
    result.fold((failure) {
      emit(ProductStateException(exception: failure.message));
    }, (productsList) {
      emit(ProductStateDone(products: productsList));
    });
  }
}
