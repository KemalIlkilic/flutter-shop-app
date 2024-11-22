import 'package:flutter/material.dart';
import 'package:shop_app/global_variables.dart';
import 'package:shop_app/product_card.dart';
import 'package:shop_app/product_details_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<String> filters = const [
    'All', 'Adidas', 'Nike', 'Bata'
  ];
  late String selectedFilter;
  int currentPageIndex = 0;

  @override
  void initState() {
    super.initState();
    selectedFilter = filters[0];
  }

  @override
  Widget build(BuildContext context) {
    const border = OutlineInputBorder(
                   borderSide: BorderSide( color: Color.fromRGBO(225, 225, 225, 1),),
                   borderRadius: BorderRadius.horizontal(left: Radius.circular(50)),
    );
        
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Text(
                  'Shoes\nCollection',
                   style: Theme.of(context).textTheme.titleLarge
                   ),
                ),
                 const Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Search',
                      prefixIcon: Icon(Icons.search),
                      border: border,
                      enabledBorder: border,
                      focusedBorder: border,
                    ),
                  )
                  ),
              ],
            ),
            SizedBox(
              height: 120,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: filters.length,
                  itemBuilder:(context,index) {
                    final filter = filters[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),   
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedFilter = filter;
                            print(filter);
                          });
                        },
                        child: Chip(
                          backgroundColor: selectedFilter == filter ? Theme.of(context).colorScheme.primary  :   Color.fromRGBO(245, 247, 249, 1),
                          side: const BorderSide(
                            color: Color.fromRGBO(245, 247, 249, 1),
                          ),
                          label: Text(filter),
                          labelStyle: const TextStyle(fontSize: 16),
                          shape: RoundedRectangleBorder( borderRadius: BorderRadius.circular(30)),
                          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                          ),
                      ),
                    );
                  },
               ),
            ),
            //Expanded kalan bütün alanı alıyor.
            Expanded(
              //ListView kalan bütün alandan kendine yeteri kadarını alıyor.
              child: ListView.builder(
                itemCount: products.length, 
                itemBuilder: (context,index) {
                  final product = products[index];
                  final Color color = index.isEven ? const Color.fromRGBO(216, 240, 253, 1) : const Color.fromRGBO(245, 247, 249, 1);
                  return GestureDetector(
                    onTap: () {
                      //kendisi devamında dönmek için back button veriyor...ilginç
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) {
                          return ProductDetailsPage(product: product);
                            },
                          ),
                        );
                    },
                    child: ProductCard(
                      title: product['title'] as String,
                      price: product['price'] as double,
                      image: product['imageUrl'] as String, 
                      backgroundColor: color
                    ),
                  );
                },
                ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        //value represents the index of the tapped navigation bar item
        //It's automatically passed by Flutter when a navigation bar item is pressed
        onTap: (pageIndex) {
          setState(() {
            currentPageIndex = pageIndex;
          });
        },
        currentIndex: currentPageIndex,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: '' ),
          BottomNavigationBarItem(icon: Icon(Icons.shopping_cart), label: ''),
        ],
        ),
    );
  }
}