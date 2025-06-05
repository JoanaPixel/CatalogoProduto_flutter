import 'package:catalogo_produto/providers/auth_provider.dart';
import 'package:catalogo_produto/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _usuarioController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _isLoading = false;
  String? _errorMessage;

  void _register() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final success = await authProvider.register(
      _emailController.text.trim(),
      _passwordController.text.trim(),
      _usuarioController.text.trim(), // Passando username aqui
    );

    setState(() => _isLoading = false);

    if (success) {
      Navigator.pop(context); // volta para login após registrar
    } else {
      setState(() {
        _errorMessage = "Falha ao registrar. Tente novamente.";
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
                    color: Colors.black),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
              const SizedBox(height: 40),
              Center(
                child: Text(
                  "Cadastro",
                  style: GoogleFonts.poppins(
                    fontSize: 26,
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

              // Formulário de cadastro
              Form(
                key: _formKey,
                child: Column(
                  children: [

                    // Campo de usuário
                    TextFormField(
                      controller: _usuarioController,
                      decoration: const InputDecoration(
                        labelText: 'Usuário',
                        prefixIcon: Icon(
                          Icons.people, 
                          color: Colors.black),
                      ),
                      validator: (String? value) {
                        if (value == null || value.isEmpty) {
                          return 'O usuário precisa de nome.';
                        }
                        return null;
                      },
                    ),

                    const SizedBox(height: 20),

                    // Campo de email
                    TextFormField(
                      controller: _emailController,
                      decoration: const InputDecoration(
                        labelText: 'Email',
                        prefixIcon: Icon(
                          Icons.email, 
                          color: Colors.black),
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

                    // Campo de senha
                    TextFormField(
                      controller: _passwordController,
                      // oculta o que está digitand
                      obscureText: true,
                      decoration: const InputDecoration(
                        labelText: 'Senha',
                        prefixIcon: Icon(Icons.lock, color: Colors.black),
                      ),
                      validator: (String? value) {
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

              // Botão de cadastrar
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed:
                      _isLoading
                          ? null
                          : () {
                            if (_formKey.currentState!.validate()) {
                              _register();
                            }
                          },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF9D2323),
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

              const SizedBox(height: 30),
              // Botão para navegar para a tela de login
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Já possui uma conta?"),
                  GestureDetector(

                    /* utilizo onTap para detectar qualquer toques/taps genéricos 
                    em qualquer widget (não apenas botões) */
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => LoginScreen()),
                      );
                    },
                    child: const Padding(
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
