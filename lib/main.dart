import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:state_management/providers/auth.dart';
import 'package:state_management/providers/cart.dart';
import 'package:state_management/providers/orders.dart';
import 'package:state_management/screens/auth_screen.dart';
import 'package:state_management/screens/cart_screen.dart';
import 'package:state_management/screens/edit_product_screen.dart';
import 'package:state_management/screens/orders_screen.dart';
import 'package:state_management/screens/splash_screen.dart';
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
            update: (ctx, auth, previousProducts) {
              if (auth.token != null && auth.userId != null) {
                return Products(auth.token!, auth.userId!,
                    previousProducts == null ? [] : previousProducts.items);
              } else {
                return Products('', '', []);
              }
            },
            create: (ctx) => Products('', '', []),
          ),
          ChangeNotifierProvider(
            create: (ctx) => Cart(),
          ),
          ChangeNotifierProxyProvider<Auth, Orders>(
            update: (ctx, auth, previousOrder) {
              if (auth.token != null && auth.userId != null) {
                return Orders(auth.token!, auth.userId!,
                    previousOrder == null ? [] : previousOrder.orders);
              } else {
                return Orders('', '', []);
              }
            },
            create: (ctx) => Orders('', '', []),
          )
        ],
        child: Consumer<Auth>(
          builder: (ctx, auth, child) {
            return MaterialApp(
              title: 'MyShop',
              theme: ThemeData(
                  primarySwatch: Colors.purple,
                  accentColor: Colors.deepOrange,
                  fontFamily: 'Lato'),
              home: auth.isAuth
                  ? ProductsOverviewScreen()
                  : FutureBuilder(
                      future: auth.tryAutoLogin(),
                      builder: (
                        ctx,
                        authResultSnapshot,
                      ) =>
                          authResultSnapshot.connectionState ==
                                  ConnectionState.waiting
                              ? SplashScreen()
                              : AuthScreen()),
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
