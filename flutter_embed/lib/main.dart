import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:js/js_util.dart' as js_util;
import 'package:js/js.dart' as js;

void main() {
  runApp(const MyApp());
}

class Product {
  final String name;
  final double price;

  Product(this.name, this.price);
}

class ShoppingCart extends ChangeNotifier {
  final List<Product> _items = [];

  List<Product> get items => _items;

  void addProduct(Product product) {
    _items.add(product);
    notifyListeners();
  }

  void removeProduct(Product product) {
    _items.remove(product);
    notifyListeners();
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ShoppingCart(),
      child: MaterialApp(
        title: 'Shopping Basket',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        initialRoute: '/',
        routes: {
          '/': (context) => const MyHomePage(),
          '/addProducts': (context) => const AddProductPage(),
          '/cart': (context) => const CartPage(),
        },
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

@js.JSExport()
class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();

    final export = js_util.createDartExport(this);
    js_util.setProperty(js_util.globalThis, '_appState', export);
    js_util.callMethod(js_util.globalThis, '_stateSet', []);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Shopping Basket'),
      ),
      body: ProductList(),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     // Navigator.pushNamed(context, '/addProducts');
      //   },
      //   child: const Icon(Icons.add),
      // ),
    );
  }

  @js.JSExport()
  void showAlert(String productJson) {
    final Map<String, dynamic> productMap = jsonDecode(productJson);

    Widget okButton = TextButton(
      child: const Text("OK"),
      onPressed: () {
        Navigator.pop(context);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(productMap['name']),
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(productMap['description']),
          const SizedBox(height: 10),
          Text(productMap['price'].toString()),
        ],
      ),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}

class ProductList extends StatelessWidget {
  final List<Product> products = [
    Product('Phone Model A', 499.99),
    Product('Phone Model B', 599.99),
    Product('Subscription Plan 1', 29.99),
    Product('Subscription Plan 2', 39.99),
  ];

  ProductList({super.key});

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<ShoppingCart>(context);

    return ListView.builder(
      itemCount: products.length,
      itemBuilder: (context, index) {
        final product = products[index];
        final isProductInCart = cart.items.contains(product);

        return ListTile(
          title: Text(product.name),
          subtitle: Text('\$${product.price.toStringAsFixed(2)}'),
          trailing: IconButton(
            icon: isProductInCart
                ? const Icon(Icons.remove_shopping_cart)
                : const Icon(Icons.add_shopping_cart),
            onPressed: () {
              if (isProductInCart) {
                cart.removeProduct(product);
              } else {
                cart.addProduct(product);
              }
            },
          ),
        );
      },
    );
  }
}

class AddProductPage extends StatelessWidget {
  const AddProductPage({super.key});

  @override
  Widget build(BuildContext context) {
    final products = Provider.of<ShoppingCart>(context, listen: false).items;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Products'),
      ),
      body: ListView.builder(
        itemCount: products.length,
        itemBuilder: (context, index) {
          final product = products[index];
          return ListTile(
            title: Text(product.name),
            subtitle: Text('\$${product.price.toStringAsFixed(2)}'),
            trailing: IconButton(
              icon: const Icon(Icons.add_shopping_cart),
              onPressed: () {
                final cart = Provider.of<ShoppingCart>(context, listen: false);
                cart.addProduct(product);
              },
            ),
          );
        },
      ),
    );
  }
}

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<ShoppingCart>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Shopping Cart'),
      ),
      body: ListView.builder(
        itemCount: cart.items.length,
        itemBuilder: (context, index) {
          final product = cart.items[index];
          return ListTile(
            title: Text(product.name),
            subtitle: Text('\$${product.price.toStringAsFixed(2)}'),
            trailing: IconButton(
              icon: const Icon(Icons.remove_shopping_cart),
              onPressed: () {
                cart.removeProduct(product);
              },
            ),
          );
        },
      ),
    );
  }
}
