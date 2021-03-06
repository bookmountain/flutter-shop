import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:state_management/providers/products_provider.dart';
import 'package:state_management/screens/edit_product_screen.dart';
import 'package:state_management/widgets/app_drawer.dart';
import 'package:state_management/widgets/user_product_item.dart';

class UserProductScreen extends StatelessWidget {
  static const routeName = 'user-products';

  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<Products>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Products'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).pushNamed(EditProductScreen.routeName);
            },
          ),
        ],
      ),
      drawer: AppDrawer(),
      body: Padding(
        padding: EdgeInsets.all(8),
        child: ListView.builder(
            itemCount: productsData.items.length,
            itemBuilder: (_, i) => Column(
                  children: [
                    UserProductItem(
                        id: productsData.items[i].id,
                        title: productsData.items[i].title,
                        imageUrl: productsData.items[i].imageUrl),
                    Divider()
                  ],
                )),
      ),
    );
  }
}
