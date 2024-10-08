import 'package:e_commerce_app/features/auth/presintation/bloc/auth_bloc.dart';
import 'package:e_commerce_app/features/auth/presintation/pages/auth_choice_page.dart';
import 'package:e_commerce_app/features/cart/presintation/bloc/cart_bloc.dart';
import 'package:e_commerce_app/features/e_commerce_clean/presintation/bloc/product_bloc.dart';
import 'package:e_commerce_app/firebase_options.dart';
import 'package:e_commerce_app/injection_container.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await initialaizedDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ProductBloc>(
          create: (_) => sl<ProductBloc>(),
        ),
        BlocProvider<AuthBloc>(
          create: (_) => sl<AuthBloc>(),
        ),
        BlocProvider<CartBloc>(
          create: (_) => sl<CartBloc>(),
        )
      ],
      child: const MaterialApp(
        home: AuthChoicePage(),
      ),
    );
  }
}
