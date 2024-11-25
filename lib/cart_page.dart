import 'package:flutter/material.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cart Page'),
      ),
      body: ListView.builder(
        itemCount: 1,
        itemBuilder: (context,index) {
          final cartItem = {
          'id' : '3',
          'title' : 'Jordan Shoes',
          'price' : 420.69,
          'imageUrl' : 'assets/images/shoes_4.png',
          'company' : 'Nike',
          'size' : 8,
            };
          return ListTile(
            leading: CircleAvatar(
              radius: 40,
              backgroundColor: const Color.fromRGBO(245, 247, 249, 1),
              backgroundImage: AssetImage(cartItem['imageUrl'] as String),
              ),
            trailing: IconButton(onPressed: () {}, icon: const Icon(Icons.delete, color : Colors.red)),
            title: Text(cartItem['title'] as String, style: Theme.of(context).textTheme.bodySmall),
            subtitle: Text('Size: ${cartItem['size']}'),
          );
        }
      ),
    );
  }
}