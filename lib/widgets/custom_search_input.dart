import 'package:flutter/material.dart';

class CustomSearchInput extends StatelessWidget {
  final Function(String) onChanged;
  final String hintText;

  const CustomSearchInput({
    super.key,
    required this.onChanged,
    required this.hintText,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: onChanged,

      decoration: InputDecoration(
        hintText: hintText,

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