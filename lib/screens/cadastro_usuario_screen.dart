import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../database/repositories/usuario_repository.dart';
import '../models/usuario.dart';
import '../routes/app_routes.dart';
import '../theme/app_colors.dart';

class CadastroUsuarioScreen extends StatefulWidget {
  const CadastroUsuarioScreen({super.key});

  @override
  State<CadastroUsuarioScreen> createState() =>
      _CadastroUsuarioScreenState();
}

class _CadastroUsuarioScreenState
    extends State<CadastroUsuarioScreen> {

  final UsuarioRepository _repository = UsuarioRepository();

  final TextEditingController nomeController = TextEditingController();

  // imagem
  File? imagemSelecionada;

  // data nascimento
  DateTime? dataNascimento;

  // selecionar imagem
  Future<void> selecionarImagem() async {

    final picker = ImagePicker();

    final imagem = await picker.pickImage(
      source: ImageSource.gallery,
    );

    if (imagem != null) {

      setState(() {
        imagemSelecionada = File(imagem.path);
      });
    }
  }

  // selecionar data
  Future<void> selecionarData() async {

    final data = await showDatePicker(
      context: context,
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (data != null) {

      setState(() {
        dataNascimento = data;
      });
    }
  }

  Future<void> cadastrarUsuario() async {

    if (nomeController.text.isEmpty ||
        dataNascimento == null) {
      return;
    }

    final usuario = Usuario(
      nome: nomeController.text,
      foto: imagemSelecionada?.path,
      dataNascimento: dataNascimento!,
    );

    await _repository.cadastrarUsuario(usuario);

    if (!mounted) return;

    Navigator.pushReplacementNamed(
      context,
      AppRoutes.usuarios,
    );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: AppColors.primaryGreen,

      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 32,
          ),

          child: SingleChildScrollView(
            child: Column(
              children: [

                const SizedBox(height: 40),

                Image.asset(
                  'assets/logo.png',
                  width: 220,
                ),

                const SizedBox(height: 40),

                GestureDetector(

                  onTap: selecionarImagem,

                  child: CircleAvatar(
                    radius: 55,
                    backgroundColor: Colors.white,

                    backgroundImage:
                        imagemSelecionada != null
                            ? FileImage(imagemSelecionada!)
                            : null,

                    child: imagemSelecionada == null
                        ? const Icon(
                            Icons.add_a_photo,
                            size: 40,
                            color: Colors.grey,
                          )
                        : null,
                  ),
                ),

                const SizedBox(height: 32),

                TextField(
                  controller: nomeController,

                  decoration: InputDecoration(
                    hintText: 'Nome',

                    filled: true,
                    fillColor: Colors.white,

                    border: OutlineInputBorder(
                      borderRadius:
                          BorderRadius.circular(16),
                    ),
                  ),
                ),

                const SizedBox(height: 24),

                // data nascimento
                GestureDetector(

                  onTap: selecionarData,

                  child: Container(
                    width: double.infinity,

                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 18,
                    ),

                    decoration: BoxDecoration(
                      color: Colors.white,

                      borderRadius:
                          BorderRadius.circular(16),
                    ),

                    child: Text(
                      dataNascimento == null
                          ? 'Selecionar data de nascimento'
                          : '${dataNascimento!.day}/${dataNascimento!.month}/${dataNascimento!.year}',
                    ),
                  ),
                ),

                const SizedBox(height: 32),

                SizedBox(
                  width: double.infinity,
                  height: 55,

                  child: ElevatedButton(

                    onPressed: cadastrarUsuario,

                    child: const Text(
                      'CADASTRAR',
                    ),
                  ),
                ),

                const SizedBox(height: 24),

                GestureDetector(

                  onTap: () {

                    Navigator.pop(context);
                  },

                  child: const Text.rich(
                  TextSpan(
                    text: 'Já possui cadastro? ',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),

                    children: [
                      TextSpan(
                        text: 'Login!',
                        style: TextStyle(
                          color: Colors.yellow,
                        ),
                      ),
                    ],
                  ),
                ),
                ),

                const SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ),
    );
  }
}