import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/cart_provider.dart';

class ProductDetailsPage extends StatefulWidget {
  final Map<String,Object> product;
  const ProductDetailsPage({super.key, required this.product});

  @override
  State<ProductDetailsPage> createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage> {
  int selectedSize = -1;

  //context kullanabiliyoruz thanks to State<> It gives us.
  // so no need for inside build
  void addCart () {
    if (selectedSize == -1) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        duration: Durations.medium1,
        content: Text('Please select a size!')
        ),
      );
      return;
    }
    context.read<CartProvider>().addProduct(
        {
      'id' : widget.product['id'],
      'title' : widget.product['title'],
      'price' : widget.product['price'],
      'imageUrl' : widget.product['imageUrl'],
      'company' : widget.product['company'],
      'size' : selectedSize,
    }
    );
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        duration: Durations.medium1,
        content: Text('Succesfully added to Cart')
        ),
    );
    //This captures the Navigator, which is responsible for managing page/screen navigation in your app
    final navigator = Navigator.of(context);
    Future.delayed(Durations.medium1, () {
      //mounted checks if the widget is still part of the widget tree
      //The mounted check prevents errors if the widget has been removed before this code runs
      if (mounted) {
        navigator.pop();
          }
        }
      );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Details'),
      ),
      body: Column(
        children: [ 
          Text(widget.product['title'] as String, style: Theme.of(context).textTheme.titleLarge,),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Image.asset(widget.product['imageUrl'] as String),
          ),
          const Spacer(flex: 2,),
          Container(
            height: 250,
            width: double.infinity,
            decoration: BoxDecoration(
              color: const Color.fromRGBO(245, 247, 249, 1),
              borderRadius: BorderRadius.circular(40),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center, 
              children: [
                Text('${widget.product['price']} \$', style : Theme.of(context).textTheme.titleLarge),
                const SizedBox(height: 10),
                SizedBox(
                  height: 50,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: (widget.product['sizes'] as List<int>).length,
                    itemBuilder: (context, index) {
                      final size = (widget.product['sizes'] as List<int>)[index];
                      final Color? bg = size == selectedSize ? Theme.of(context).colorScheme.primary : null;
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GestureDetector(
                          onTap: () {
                          setState(() {
                            selectedSize = size;
                          });
                      },
                          child: Chip(backgroundColor:bg, label: Text(size.toString()))
                          ),
                      );
                    },
                    ),
                ),
                Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).primaryColor,
                      minimumSize: const Size(double.infinity, 50),
                    ),
                    onPressed: addCart,
                   child: Text('Add To Cart' , style: Theme.of(context).textTheme.bodySmall),
                   ),
                )

              ],
            ),
          )
          
        ],
        ),
    );
  }
}