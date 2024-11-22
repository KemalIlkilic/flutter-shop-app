import 'package:flutter/material.dart';

class ProductDetailsPage extends StatefulWidget {
  final Map<String,Object> product;
  const ProductDetailsPage({super.key, required this.product});

  @override
  State<ProductDetailsPage> createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage> {
  int selectedIndex = -1;

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
                      final Color? bg = index == selectedIndex ? Theme.of(context).colorScheme.primary : null;
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GestureDetector(
                          onTap: () {
                          setState(() {
                            selectedIndex = index;
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
                    onPressed: () {},
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