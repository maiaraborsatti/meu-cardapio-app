import 'package:flutter/material.dart';

import '../database/repositories/usuario_repository.dart';

import '../models/usuario.dart';

import '../widgets/custom_search_input.dart';
import '../widgets/usuario_avatar_card.dart';

import '../routes/app_routes.dart';

class UsuariosScreen extends StatefulWidget {
  const UsuariosScreen({super.key});

  @override
  State<UsuariosScreen> createState() => _UsuariosScreenState();
}

class _UsuariosScreenState extends State<UsuariosScreen> {

  final UsuarioRepository _repository = UsuarioRepository();

  List<Usuario> usuarios = [];

  @override
  void initState() {
    super.initState();
    carregarUsuarios();
  }

  Future<void> carregarUsuarios() async {
    final resultado = await _repository.listarTodosUsuarios();

    setState(() {
      usuarios = resultado;
    });
  }

  Future<void> buscarUsuarios(String texto) async {

    if (texto.length < 3) {
      carregarUsuarios();
      return;
    }

    final resultado =
        await _repository.buscarUsuariosPorNome(texto);

    setState(() {
      usuarios = resultado;
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: const Color(0xFF8BC34A),

      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),

          child: Column(
            children: [

              const SizedBox(height: 20),

              Image.asset(
                'assets/logo.png',
                height: 120,
              ),

              const SizedBox(height: 30),

              CustomSearchInput(
                hintText: 'Buscar usuário',
                onChanged: buscarUsuarios,
              ),

              const SizedBox(height: 30),

              Expanded(
                child: GridView.builder(

                  itemCount: usuarios.length,

                  gridDelegate:
                      const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 20,
                    mainAxisSpacing: 20,
                    childAspectRatio: 0.9,
                  ),

                  itemBuilder: (context, index) {

                    final usuario = usuarios[index];

                    return UsuarioAvatarCard(

                      usuario: usuario,

                      onTap: () {

                        Navigator.pushReplacementNamed(
                          context,
                          AppRoutes.menu, //futuramente home
                          arguments: usuario,
                        );
                      },
                    );
                  },
                ),
              ),

              GestureDetector(

                onTap: () {

                  Navigator.pushNamed(
                    context,
                    AppRoutes.cadastroUsuario, // futuramente cadastroUsuario,
                  );
                },

                child: const Text.rich(
                  TextSpan(
                    text: 'Novo por aqui? ',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),

                    children: [
                      TextSpan(
                        text: 'Cadastre-se!',
                        style: TextStyle(
                          color: Colors.yellow,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}