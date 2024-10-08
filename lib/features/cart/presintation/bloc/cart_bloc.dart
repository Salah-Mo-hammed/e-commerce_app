import 'dart:async';

import 'package:e_commerce_app/features/cart/domain/usecases/add_to_cart_usecase.dart';
import 'package:e_commerce_app/features/cart/domain/usecases/check_added.dart';
import 'package:e_commerce_app/features/cart/domain/usecases/delete_from_cart_usecase.dart';
import 'package:e_commerce_app/features/cart/domain/usecases/get_cart_products_usecase.dart';
import 'package:e_commerce_app/features/cart/presintation/bloc/cart_event.dart';
import 'package:e_commerce_app/features/cart/presintation/bloc/cart_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  AddToCartUsecase addToCartUsecase;
  DeleteFromCartUsecase deleteFromCartUsecase;
  GetCartProductsUsecase getCartProductsUsecase;
  CheckAddedUsecase checkAddedUsecase;
  CartBloc(
      {required this.checkAddedUsecase,
      required this.addToCartUsecase,
      required this.getCartProductsUsecase,
      required this.deleteFromCartUsecase})
      : super(const CartStateInitial()) {
    on<AddEvent>(onAdd);
    on<DeleteEvent>(onDelete);
    on<StartEvent>(onStart);
    on<GetAllCartsProductsEvent>(onGetProductsCarts);
    on<CheckAddedEvent>(onCheckAdded);
  }

  FutureOr<void> onAdd(AddEvent event, Emitter<CartState> emit) async {
    emit(const CartStateLoading());
    final result = await addToCartUsecase.call(event.userId, event.productId);
    result.fold((failure) {
      emit(CartStateException(message: failure.message));
    }, (unit) {
      emit(const CartStateUpdate());
    });
  }

  FutureOr<void> onDelete(DeleteEvent event, Emitter<CartState> emit) async {
    emit(const CartStateLoading());
    final result =
        await deleteFromCartUsecase.call(event.userId, event.product);
    result.fold((failure) {
      emit(CartStateException(message: failure.message));
    }, (unit) {
      emit(const CartStateUpdate());
    });
  }

  FutureOr<void> onStart(StartEvent event, Emitter<CartState> emit) {
    emit(const CartStateInitial());
  }

  FutureOr<void> onGetProductsCarts(
      GetAllCartsProductsEvent event, Emitter<CartState> emit) async {
    emit(const CartStateLoading());
    final result = await getCartProductsUsecase.call(event.userId);
    result.fold((failure) {
      emit(CartStateException(message: failure.message));
    }, (products) {
      emit(CartStateDone(productsList: products));
    });
  }

  FutureOr<void> onCheckAdded(
      CheckAddedEvent event, Emitter<CartState> emit) async {
    emit(const CartStateLoading());
    final result =
        await checkAddedUsecase.call(event.userId, event.productEntity);
    result.fold((failure) {
      emit(CartStateException(message: failure.message));
    }, (isAdded) {
      emit(CartStateCheckAdded(isAdded: isAdded));
    });
  }
}
