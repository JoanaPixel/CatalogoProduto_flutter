// lib/catalog_screen.dart

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'product_detail_screen.dart'; // importa a tela de detalhes

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
    final url = Uri.parse(
      'https://api.escuelajs.co/api/v1/products?offset=0&limit=10',
    );
    final response = await http.get(url);

    if (response.statusCode == 200) {
      setState(() {
        products = json.decode(response.body);
      });
    } else {
      throw Exception('Erro ao carregar produtos');
    }
  }

  void navigateToDetail(dynamic product) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ProductDetailScreen(product: product),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        // leading define o ícone ou widget do lado esquerdo da AppBar
        leading: Icon(Icons.menu, color: Color(0xFF9D2323)),

        // actions define uma lista de widgets do lado direito da AppBar.
        actions: [
          Icon(Icons.shopping_cart_outlined, color: Color(0xFF9D2323)),
          SizedBox(width: 16),
        ],

        backgroundColor: Colors.transparent,
        elevation: 0,

      ),
      // body define o conteúdo central da tela
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        child: ListView(
          children: [

            Text("Olá", style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
            SizedBox(height: 4),

            Text("Bem vindo ao Velory Market.", style: TextStyle(color: Colors.grey[600])),
            SizedBox(height: 16),

            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.search, color: Colors.grey),
                        SizedBox(width: 8),
                        Expanded(
                          child: TextField(
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "Buscar...",
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Produtos", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                Text("Ver tudo", style: TextStyle(color: Colors.grey)),
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

                      return GestureDetector(
                        onTap: () => navigateToDetail(product),
                        child: Container(

                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            color: Colors.grey[100],
                          ),

                          padding: EdgeInsets.all(8),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,

                            // mostrar os produtos no tela
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
                              Text(
                                '\$${product['price']}',
                                style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF9D2323)),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
          ],
        ),
      ),
      // bottomNavigationBar define o widget de navegação inferior
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        selectedItemColor: Color(0xFF9D2323),
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
