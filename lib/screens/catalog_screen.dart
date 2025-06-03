// lib/catalog_screen.dart

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CatalogScreen extends StatefulWidget {
  const CatalogScreen({super.key});

  @override
  State<CatalogScreen> createState() => _CatalogScreenState();
}

class _CatalogScreenState extends State<CatalogScreen> {
  List<dynamic> products = [];

  @override
  void initState() {
    super.initState();
    fetchProducts();
  }

  Future<void> fetchProducts() async {
    final url = Uri.parse('https://api.escuelajs.co/api/v1/products?offset=0&limit=10');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      setState(() {
        products = json.decode(response.body);
      });
    } else {
      throw Exception('Erro ao carregar produtos');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.menu, color: Colors.white),
        actions: [
          Icon(Icons.shopping_bag_outlined, color: Colors.black),
          SizedBox(width: 16),
        ],
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: ListView(
          children: [
            Text("Hello", style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),

            SizedBox(height: 4),

            Text("Welcome to Laza.", style: TextStyle(color: Colors.grey[600])),
            SizedBox(height: 16),
            
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 12),
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.search, color: Colors.grey),
                        SizedBox(width: 8),
                        Expanded(child: TextField(decoration: InputDecoration(border: InputBorder.none, hintText: "Search..."))),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: 8),

                Container(
                  decoration: BoxDecoration(
                    color: Colors.red[700],
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: EdgeInsets.all(12),
                  child: Icon(Icons.mic, color: Colors.white),
                ),
              ],
            ),
            SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("New Arrival", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                Text("View All", style: TextStyle(color: Colors.grey)),
              ],
            ),
            SizedBox(height: 12),
            products.isEmpty
                ? Center(child: CircularProgressIndicator())
                : GridView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: products.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 16,
                      crossAxisSpacing: 16,
                      childAspectRatio: 0.65,
                    ),
                    itemBuilder: (context, index) {
                      final product = products[index];
                      return Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          color: Colors.grey[100],
                        ),
                        padding: EdgeInsets.all(8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Stack(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(12),
                                  child: Image.network(
                                    product['images'][0],
                                    height: 150,
                                    width: double.infinity,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                Positioned(
                                  top: 8,
                                  right: 8,
                                  child: Icon(Icons.favorite_border, color: Colors.grey),
                                ),
                              ],
                            ),
                            SizedBox(height: 8),
                            Text(
                              product['title'],
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(fontWeight: FontWeight.w500),
                            ),
                            SizedBox(height: 4),
                            Text('\$${product['price']}', style: TextStyle(fontWeight: FontWeight.bold)),
                          ],
                        ),
                      );
                    },
                  ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        selectedItemColor: Colors.red[700],
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: ""),
          BottomNavigationBarItem(icon: Icon(Icons.favorite_border), label: ""),
          BottomNavigationBarItem(icon: Icon(Icons.shopping_cart_outlined), label: ""),
          BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: ""),
        ],
      ),
    );
  }
}
