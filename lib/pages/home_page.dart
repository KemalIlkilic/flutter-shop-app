import 'package:flutter/material.dart';
import 'package:shop_app/pages/cart_page.dart';
import '../widgets/product_list.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentPageIndex = 0;

  List<Widget> pages = const [
    ProductList(),
    CartPage()
  ];
  

  @override
  Widget build(BuildContext context) {
        
    return Scaffold(
      //aşağı kaydırdığımızda mesela geri dönünce sayfaya
      //aşağı kaydırdığımız yerden devam etmesi için Indexed Stack kullandık.
      body: IndexedStack(
        index: currentPageIndex,
        children: pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        iconSize: 30,
        selectedFontSize: 0,
        unselectedFontSize: 0,
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