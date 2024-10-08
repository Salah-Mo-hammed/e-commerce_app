import 'package:dio/dio.dart';
import 'package:e_commerce_app/features/auth/data/data_source/remote/auth_data_source.dart';
import 'package:e_commerce_app/features/auth/data/repo_impl/repo_impl.dart';
import 'package:e_commerce_app/features/auth/domain/repo/auth_repo.dart';
import 'package:e_commerce_app/features/auth/domain/usecases/login_usecase.dart';
import 'package:e_commerce_app/features/auth/domain/usecases/logout_usecase.dart';
import 'package:e_commerce_app/features/auth/domain/usecases/register_usecase.dart';
import 'package:e_commerce_app/features/auth/presintation/bloc/auth_bloc.dart';
import 'package:e_commerce_app/features/cart/data/data_source/remote/cart_data_source.dart';
import 'package:e_commerce_app/features/cart/data/repo_impl/cart_repo_impl.dart';
import 'package:e_commerce_app/features/cart/domain/repo/cart_repo.dart';
import 'package:e_commerce_app/features/cart/domain/usecases/add_to_cart_usecase.dart';
import 'package:e_commerce_app/features/cart/domain/usecases/check_added.dart';
import 'package:e_commerce_app/features/cart/domain/usecases/delete_from_cart_usecase.dart';
import 'package:e_commerce_app/features/cart/domain/usecases/get_cart_products_usecase.dart';
import 'package:e_commerce_app/features/cart/presintation/bloc/cart_bloc.dart';
import 'package:e_commerce_app/features/e_commerce_clean/data/data_source/remote/api_data_source.dart';
import 'package:e_commerce_app/features/e_commerce_clean/data/repo_impl/repo_impl.dart';
import 'package:e_commerce_app/features/e_commerce_clean/domain/repo/product_repo.dart';
import 'package:e_commerce_app/features/e_commerce_clean/domain/usecases/get_all_products_usecase.dart';
import 'package:e_commerce_app/features/e_commerce_clean/domain/usecases/get_in_category_usecase.dart';
import 'package:e_commerce_app/features/e_commerce_clean/presintation/bloc/product_bloc.dart';
import 'package:get_it/get_it.dart';

GetIt sl = GetIt.instance;
Future<void> initialaizedDependencies() async {
  //! Note: you must do it with  this arrangement : http request or Dio => data-dataSource => repo (<repo from domain>(repoimple)) =>
  //! domain-usecases => blocs
  sl.registerSingleton<Dio>(Dio());
  //! data-dataSource
  sl.registerSingleton<ProductApiDataSource>(WithDio());
  sl.registerSingleton<AuthDataSource>(AuthDataSource());
  sl.registerSingleton<CartDataSource>(FireStore());

//! domain-repo
  sl.registerSingleton<ProductRepo>(
      ProductRepoImpl(productApiDataSource: sl<ProductApiDataSource>()));
  sl.registerSingleton<AuthRepo>(
      AuthRepoImpl(authDataSource: sl<AuthDataSource>()));
  sl.registerSingleton<CartRepo>(
      CartRepoImpl(cartDataSource: sl<CartDataSource>()));
  //! domain-usecases
  sl.registerSingleton<GetAllProductsUsecase>(
      GetAllProductsUsecase(productRepo: sl<ProductRepo>()));
  sl.registerSingleton<GetInCategoryUsecase>(
      GetInCategoryUsecase(productRepo: sl<ProductRepo>()));

  sl.registerSingleton<LogInUsecase>(LogInUsecase(repo: sl<AuthRepo>()));
  sl.registerSingleton<LogOutUsecase>(LogOutUsecase(repo: sl<AuthRepo>()));
  sl.registerSingleton<RegisterUsecase>(RegisterUsecase(repo: sl<AuthRepo>()));

  sl.registerSingleton<AddToCartUsecase>(
      AddToCartUsecase(repo: sl<CartRepo>()));
  sl.registerSingleton<DeleteFromCartUsecase>(
      DeleteFromCartUsecase(repo: sl<CartRepo>()));
  sl.registerSingleton<GetCartProductsUsecase>(
      GetCartProductsUsecase(repo: sl<CartRepo>()));
  sl.registerSingleton<CheckAddedUsecase>(
      CheckAddedUsecase(cartRepo: sl<CartRepo>()));

  //! blocs
  sl.registerFactory<ProductBloc>(() => ProductBloc(
      getAllProductsUsecase: sl<GetAllProductsUsecase>(),
      getInCategoryUsecase: sl<GetInCategoryUsecase>()));

  sl.registerFactory<AuthBloc>(() => AuthBloc(
      logInUsecase: sl<LogInUsecase>(),
      logOutUsecase: sl<LogOutUsecase>(),
      registerUsecase: sl<RegisterUsecase>()));
      
  sl.registerFactory<CartBloc>(() => CartBloc(
      addToCartUsecase: sl<AddToCartUsecase>(),
      deleteFromCartUsecase: sl<DeleteFromCartUsecase>(),
      getCartProductsUsecase: sl<GetCartProductsUsecase>(),
      checkAddedUsecase: sl<CheckAddedUsecase>()));
}
