import 'package:e_commerce_app/features/cart/presintation/bloc/cart_bloc.dart';
import 'package:e_commerce_app/features/cart/presintation/bloc/cart_event.dart';
import 'package:e_commerce_app/features/cart/presintation/bloc/cart_state.dart';
import 'package:e_commerce_app/features/e_commerce_clean/presintation/pages/detailed_product.dart';
import 'package:e_commerce_app/features/e_commerce_clean/presintation/widgets/product_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// ignore: must_be_immutable
class CartPage extends StatelessWidget {
  String userId;

  CartPage({super.key, required this.userId});
  @override
  Widget build(BuildContext context) {
    context.read<CartBloc>().add(GetAllCartsProductsEvent(userId: userId));
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.teal,
          title: const Text("Cart Page"),
        ),
        body: Column(
          children: [
            Expanded(
              child: BlocBuilder<CartBloc, CartState>(
                builder: (context, state) {
                  if (state is CartStateLoading) {
                    return const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Center(child: CircularProgressIndicator()),
                    );
                  } else if (state is CartStateException) {
                    return Center(child: Text(state.message));
                  } else if (state is CartStateDone) {
                    return SizedBox(
                      child: GridView.builder(
                        padding: const EdgeInsets.all(8.0),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 10.0,
                          mainAxisSpacing: 10.0,
                          childAspectRatio: .85,
                        ),
                        itemCount: state.products!.length,
                        itemBuilder: (context, index) {
                          final product = state.products![index];
                          return InkWell(
                            onTap: () {
                              context.read<CartBloc>().add(CheckAddedEvent(
                                    userId: userId,
                                    productEntity: product,
                                  ));
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => DetailedProduct(
                                  userIdStr: userId,
                                  productIdStr: product.id.toString(),
                                  product: product,
                                ),
                              ));
                            },
                            child: ProductCard(
                              imageUrl: product.image,
                              title: product.title,
                              price: product.price,
                            ),
                          );
                        },
                      ),
                    );
                  } else {
                    context
                        .read<CartBloc>()
                        .add(GetAllCartsProductsEvent(userId: userId));
                    return const Text("wait");
                  }
                },
              ),
            ),
          ],
        ));
  }
}
