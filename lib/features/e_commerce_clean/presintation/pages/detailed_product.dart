import 'package:e_commerce_app/features/cart/presintation/bloc/cart_bloc.dart';
import 'package:e_commerce_app/features/cart/presintation/bloc/cart_event.dart';
import 'package:e_commerce_app/features/cart/presintation/bloc/cart_state.dart';
import 'package:e_commerce_app/features/e_commerce_clean/domain/entities/product_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// ignore: must_be_immutable
class DetailedProduct extends StatelessWidget {
  final String userIdStr;
  final String productIdStr;
  final ProductEntity product;

  DetailedProduct({
    required this.product,
    required this.productIdStr,
    required this.userIdStr,
    super.key,
  });
  late bool isAdded;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[100],
        appBar: AppBar(
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () => Navigator.of(context).pop(),
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.favorite_border, color: Colors.black),
              onPressed: () {},
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Hero(
                tag: productIdStr,
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 10,
                        spreadRadius: 1,
                        offset: Offset(0, 5),
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.network(
                      product.image,
                      height: 350,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 30),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        product.title,
                        style: const TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                    Text(
                      '\$${product.price.toStringAsFixed(2)}',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.green[700],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Divider(color: Colors.grey[400]),
                    const SizedBox(height: 10),
                    const Text(
                      'Product Details',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      product.description,
                      style: const TextStyle(
                        fontSize: 16,
                        height: 1.8,
                        color: Colors.black54,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              Card(
                color: Colors.white70,
                elevation: 15,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5)),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "  rateing :",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 25,
                          color: Colors.black,
                        ),
                      ),
                      Row(
                        children: [
                          const Icon(
                            Icons.star_border,
                            size: 30,
                          ),
                          const SizedBox(width: 5),
                          Text(
                            product.rating.rate.toString(),
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 25,
                              color: Colors.black,
                            ),
                          ),
                          const SizedBox(width: 10),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 30),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Row(
                  children: [
                    Expanded(child: BlocBuilder<CartBloc, CartState>(
                      builder: (context, state) {
                        if (state is CartStateLoading) {
                          return _circular();
                        } else if (state is CartStateException) {
                          return Center(child: Text(state.message));
                        }

                        if (state is CartStateCheckAdded) {
                          isAdded = state.isAdded;
                        }

                        return button(context);
                      },
                    )),
                    const SizedBox(width: 15),
                    IconButton(
                      icon: const Icon(Icons.share,
                          size: 30, color: Colors.black),
                      onPressed: () {
                        Clipboard.setData(ClipboardData(
                            text:
                                "https://fakestoreapi.com/products/${product.id}"));
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text("URL copied to clipboard")));
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }

  ElevatedButton button(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 15),
        backgroundColor: Colors.teal,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      onPressed: () {
        if (isAdded) {
          context.read<CartBloc>().add(DeleteEvent(
                product: product,
                userId: userIdStr,
              ));
          isAdded = !isAdded;
        } else {
          context.read<CartBloc>().add(AddEvent(
                productId: product,
                userId: userIdStr,
              ));
          isAdded = !isAdded;
        }
      },
      child: Text(
        isAdded ? "Remove from cart" : "Add to cart",
        style: const TextStyle(
          color: Colors.black,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Padding _circular() {
    return const Padding(
      padding: EdgeInsets.all(8.0),
      child: Center(child: CircularProgressIndicator()),
    );
  }
}
