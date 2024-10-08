// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:e_commerce_app/features/cart/presintation/bloc/cart_bloc.dart';
import 'package:e_commerce_app/features/cart/presintation/bloc/cart_event.dart';
import 'package:e_commerce_app/features/e_commerce_clean/presintation/bloc/product_bloc.dart';
import 'package:e_commerce_app/features/e_commerce_clean/presintation/bloc/product_event.dart';
import 'package:e_commerce_app/features/e_commerce_clean/presintation/bloc/product_state.dart';
import 'package:e_commerce_app/features/e_commerce_clean/presintation/pages/detailed_product.dart';
import 'package:e_commerce_app/features/e_commerce_clean/presintation/widgets/product_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// ignore: must_be_immutable
class ProductGridView extends StatelessWidget {
  String userId;
  ProductStateDone state;
  ProductGridView({super.key, required this.state, required this.userId});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              _buildCategoriesOption("men's clothing", () {
                context
                    .read<ProductBloc>()
                    .add(GetInCategoryEvent(category: "men's clothing"));
              }),
              _buildCategoriesOption("women's clothing", () {
                context
                    .read<ProductBloc>()
                    .add(GetInCategoryEvent(category: "women's clothing"));
              }),
              _buildCategoriesOption("electronics", () {
                context
                    .read<ProductBloc>()
                    .add(GetInCategoryEvent(category: "electronics"));
              }),
              _buildCategoriesOption("jewelery", () {
                context
                    .read<ProductBloc>()
                    .add(GetInCategoryEvent(category: "jewelery"));
              }),
            ],
          ),
        ),
        Expanded(
          child: SizedBox(
            child: GridView.builder(
              padding: const EdgeInsets.all(8.0),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
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
          ),
        ),
      ],
    );
  }

  Padding _buildCategoriesOption(String category, void Function()? pressed) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
            color: Colors.amber, borderRadius: BorderRadius.circular(20)),
        width: 150,
        height: 40,
        child: TextButton(
          onPressed: pressed,
          child: Text(
            category,
            style: TextStyle(color: Colors.black),
          ),
        ),
      ),
    );
  }
}
