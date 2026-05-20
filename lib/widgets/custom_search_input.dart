import 'package:flutter/material.dart';

class CustomSearchInput extends StatelessWidget {
  final Function(String) onChanged;

  const CustomSearchInput({
    super.key,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: onChanged,

      decoration: InputDecoration(
        hintText: 'Buscar usuário',

        prefixIcon: const Icon(Icons.search),

        filled: true,
        fillColor: Colors.white,

        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}