import 'package:flutter/material.dart';

class WritingView extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode focusNode;

  const WritingView({
    super.key,
    required this.controller,
    required this.focusNode,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
      child: TextField(
        controller: controller,
        focusNode: focusNode,
        maxLines: null,
        expands: true, // Faz o TextField ocupar todo o espaço disponível
        style: const TextStyle(fontSize: 16, height: 1.5),
        decoration: const InputDecoration(
          border: InputBorder.none,
          hintText: "Comece a escrever...",
        ),
      ),
    );
  }
}
