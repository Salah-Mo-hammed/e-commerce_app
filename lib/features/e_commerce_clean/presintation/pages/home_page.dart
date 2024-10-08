// ignore_for_file: prefer_const_constructors, must_be_immutable

import 'package:e_commerce_app/features/auth/presintation/bloc/auth_bloc.dart';
import 'package:e_commerce_app/features/auth/presintation/bloc/auth_event.dart';
import 'package:e_commerce_app/features/auth/presintation/pages/auth_choice_page.dart';
import 'package:e_commerce_app/features/cart/presintation/pages/cart_page.dart';
import 'package:e_commerce_app/features/e_commerce_clean/presintation/bloc/product_bloc.dart';
import 'package:e_commerce_app/features/e_commerce_clean/presintation/bloc/product_event.dart';
import 'package:e_commerce_app/features/e_commerce_clean/presintation/bloc/product_state.dart';
import 'package:e_commerce_app/features/e_commerce_clean/presintation/widgets/product_grid_view_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatelessWidget {
  String userId;
  HomePage({super.key, required this.userId});
  TextEditingController categoryEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => CartPage(userId: userId),
          ));
        },
        child: const Icon(Icons.shopping_bag_outlined),
      ),
      appBar: AppBar(
        title: Text("E-commerce"),
        leading: IconButton(
          icon: Icon(Icons.logout),
          onPressed: () {
            context.read<AuthBloc>().add(AuthLogOutEvent());

            Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (context) => AuthChoicePage(),
            ));
          },
        ),
        backgroundColor: Colors.teal,
        elevation: 0,
      ),
      body: BlocBuilder<ProductBloc, ProductState>(
        builder: (context, state) {
          if (state is ProductStateLoading) {
            context.read<ProductBloc>().add(GetAllProductsEvent());
            return _buildCircularIndicator();
          } else if (state is ProductStateDone) {
            return _buildProductGrid(context, state);
          } else if (state is ProductStateException) {
            return Center(
              child: Text(
                "Something went wrong: ${state.message}",
                style: TextStyle(fontSize: 18, color: Colors.red),
              ),
            );
          } else {
            return Center(
              child: Text(
                "There are no products available yet.",
                style: TextStyle(fontSize: 18, color: Colors.grey),
              ),
            );
          }
        },
      ),
    );
  }

  Widget _buildProductGrid(BuildContext context, ProductStateDone state) {
    if (state.products!.isNotEmpty) {
      return ProductGridView(
        userId: userId,
        state: state,
      );
    } else {
      return const Padding(
        padding: EdgeInsets.all(8.0),
        child: Center(child: Text("no products available now")),
      );
    }
  }

  Padding _buildCircularIndicator() {
    return const Padding(
      padding: EdgeInsets.all(8.0),
      child: Center(child: CircularProgressIndicator()),
    );
  }
}
