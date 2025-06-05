import 'package:catalogo_produto/providers/auth_provider.dart';
import 'package:catalogo_produto/screens/RegisterScreen.dart';
import 'package:catalogo_produto/screens/confirm_login_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _isLoading = false;
  String? _errorMessage;

  void _login() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final success = await authProvider.login(
      _emailController.text.trim(),
      _passwordController.text.trim(),
    );

    setState(() => _isLoading = false);

    if (success) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => SuccessScreen()),
      );
    } else {
      setState(() {
        _errorMessage = "Login inválido. Tente novamente.";
      });
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      
      body: Container(
        height: double.infinity,
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 60),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: IconButton(
                  icon: const Icon(
                    Icons.arrow_back,
                    color: Color.fromARGB(255, 0, 0, 0),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),

              const SizedBox(height: 40),

              Center(
                child: Text(
                  'Bem vindo ao Velory Market',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              const SizedBox(height: 40),

              if (_errorMessage != null)
                Text(
                  _errorMessage!,
                  style: const TextStyle(color: Colors.redAccent),
                ),

              const SizedBox(height: 20),

              Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: _emailController,
                      decoration: InputDecoration(
                        labelText: 'Email *',
                        prefixIcon: const Icon(
                          Icons.email,
                          color: Colors.black,
                        ),
                      ),
                      validator: (String? value) {
                        if (value == null || value.isEmpty) {
                          return 'O email não pode estar vazio.';
                        }
                        if (!value.contains('@')) {
                          return 'Insira um email válido com @';
                        }
                        return null;
                      },
                    ),

                    const SizedBox(height: 20),

                    TextFormField(
                      controller: _passwordController,
                      // oculta o que está digitando
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: 'Senha ',
                        prefixIcon: const Icon(
                          Icons.lock,
                          color: Color.fromARGB(255, 0, 0, 0),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.length < 6) {
                          return 'A senha deve ter pelo menos 6 caracteres.';
                        }
                        return null;
                      },
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 30),

              // botão de entrar
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed:
                      _isLoading
                          ? null
                          : () {
                            if (_formKey.currentState!.validate()) {
                              _login();
                            }
                          },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF9D2323),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child:
                      _isLoading
                          ? const CircularProgressIndicator(color: Colors.white)
                          : const Text(
                            'Cadastrar',
                            style: TextStyle(fontSize: 16, color: Colors.white),
                          ),
                ),
              ),

              const SizedBox(height: 20),

              // botão para mudar de tela para outra se não tem cadastro
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Não possui a conta?"),
                  GestureDetector(
                    /* utilizo onTap para detectar qualquer toques/taps genéricos 
                    em qualquer widget (não apenas botões) */
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => RegisterScreen()),
                      );
                    },
                    child: Padding(
                      padding: EdgeInsets.only(left: 6),
                      child: Text(
                        "Entrar",
                        style: TextStyle(
                          color: Color(0xFF9D2323),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
