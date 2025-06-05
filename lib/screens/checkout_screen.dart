import 'package:catalogo_produto/screens/catalog_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CheckoutScreen extends StatelessWidget {
  const CheckoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,

              leading: IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.black),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),

            const Spacer(),

            Image.asset("images/sucesso.png", height: 200),

            const SizedBox(height: 20),

            Text(
              "Pedido Confirmado!",
              style: GoogleFonts.inter(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1D1E20),
              ),
              textAlign: TextAlign.center,
            ),

            const Spacer(),

            Text(
              "Seu pedido foi confirmado, enviaremos um e-mail de confirmação em breve.",
              style: GoogleFonts.inter(
                fontSize: 15,
                fontWeight: FontWeight.normal,
                color: Color(0xFF8F959E),
              ),
            ),

            const Spacer(),

            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const CheckoutScreen()) as Route<Object?>,
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFFF5F5F5),
                padding: const EdgeInsets.symmetric(
                  horizontal: 30,
                  vertical: 15,
                ),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
              ),
              child: const Text(
                "Ir para Pedidos",
                style: TextStyle(color: Color(0xFF8F959E)),
              ),
            ),

            const Spacer(),
          ],
        ),
      ),

      bottomNavigationBar: Container(
        color: const Color(0xFF9D2323),
        padding: const EdgeInsets.all(16),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.transparent,
            shadowColor: Colors.transparent,
            padding: const EdgeInsets.symmetric(vertical: 16),
          ),
          onPressed: () {
            Navigator.pushNamed(
              context,

              MaterialPageRoute(builder: (context) => const CatalogScreen()) as String,
            );
          },
          child: const Text(
            "Continuar Comprando", 
            style: TextStyle(color: Colors.white, fontSize: 18)
            ),
        ),
      ),
    );
  }
}
