import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:state_management/providers/auth.dart';
import 'package:state_management/providers/cart.dart';
import 'package:state_management/providers/orders.dart';
import 'package:state_management/screens/auth_screen.dart';
import 'package:state_management/screens/cart_screen.dart';
import 'package:state_management/screens/edit_product_screen.dart';
import 'package:state_management/screens/orders_screen.dart';
import 'package:state_management/screens/user_product_screen.dart';
import './screens/produts_overview_screen.dart';
import './screens/product_detail_screen.dart';
import './providers/products_provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider.value(
            value: Auth(),
          ),
          ChangeNotifierProxyProvider<Auth, Products>(
            update: (ctx, auth, previousProducts) => Products(auth.token!,
                previousProducts == null ? [] : previousProducts.items),
            create: (ctx) => Products('', []),
          ),
          ChangeNotifierProvider(
            create: (ctx) => Cart(),
          ),
          ChangeNotifierProvider(create: (ctx) => Orders())
        ],
        child: Consumer<Auth>(
          builder: (ctx, auth, child) {
            return MaterialApp(
              title: 'MyShop',
              theme: ThemeData(
                  primarySwatch: Colors.purple,
                  accentColor: Colors.deepOrange,
                  fontFamily: 'Lato'),
              home: auth.isAuth ? ProductsOverviewScreen() : AuthScreen(),
              routes: {
                ProductDetailScreen.routeName: (ctx) => ProductDetailScreen(),
                CartScreen.routeName: (ctx) => CartScreen(),
                OrdersScreen.routeName: (ctx) => OrdersScreen(),
                UserProductScreen.routeName: (ctx) => UserProductScreen(),
                EditProductScreen.routeName: (ctx) => EditProductScreen(),
              },
            );
          },
        ));
  }
}
