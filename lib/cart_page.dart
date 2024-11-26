import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/cart_provider.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    final cartProviderInstance = context.watch<CartProvider>();
    final cart = cartProviderInstance.carts;
    //same with above just a bit longer.
    //final cart = Provider.of<CartProvider>(context).carts;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cart Page'),
      ),
      body: ListView.builder(
        itemCount: cart.length,
        itemBuilder: (context,index) {
          final cartItem = cart[index];
          /* final cartItem = {
          'id' : '3',
          'title' : 'Jordan Shoes',
          'price' : 420.69,
          'imageUrl' : 'assets/images/shoes_4.png',
          'company' : 'Nike',
          'size' : 8,
            } */
          return ListTile(
            leading: CircleAvatar(
              radius: 40,
              backgroundColor: const Color.fromRGBO(245, 247, 249, 1),
              backgroundImage: AssetImage(cartItem['imageUrl'] as String),
              ),
            trailing: IconButton(
              onPressed: (){
                showDialog(
                  //to avoid exit yes or no dialog.
                  barrierDismissible: false,
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: Text(
                        'Delete Product',
                        style: Theme.of(context).textTheme.titleMedium,
                        ),
                      content: const Text('Are you sure you want to remove product?'),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          }, 
                          child: const Text(
                            'No',
                            style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
                            ),
                        ),
                        TextButton(
                          onPressed: () {
                            // eger read only degil ve degisiklik yapacaksak Change Notifier instance üzerinde
                            // listen : false yapmamız lazım.
                            context.read<CartProvider>().removeProduct(cartItem);
                            //same with above just a bit longer.
                            //Provider.of<CartProvider>(context, listen: false).removeProduct(cartItem);
                            Navigator.of(context).pop();
                          }, 
                          child: const Text(
                            'Yes',
                            style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
                            ),
                        ),
                      ],
                    );
                  },
                );
            }, 
            icon: const Icon(Icons.delete, color : Colors.red)),
            title: Text(cartItem['title'] as String, style: Theme.of(context).textTheme.bodySmall),
            subtitle: Text('Size: ${cartItem['size']}'),
          );
        }
      ),
    );
  }
}