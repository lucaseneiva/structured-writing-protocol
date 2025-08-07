import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:structured_writing_protocol/presentation/home_page.dart';
import 'package:structured_writing_protocol/presentation/session_note_view.dart';

import 'package:structured_writing_protocol/theme/app_theme.dart';
void main() {
  runApp((const ProviderScope(child: MyApp())));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: customTheme,
      home: SessionNoteView(sessionNumber: 5, controller: TextEditingController(), cycleName: 'Meus Medos', content: "aaaaaaaaa aaaaaaaaaaaa aaaaaaaaaaaa aaaaaaaaaaaaaaaaaa aaaaaaaaaaaa aaaaaaaaa aaaaaaaaa aaaaaaaaa aaaaaaaaa"),
      debugShowCheckedModeBanner: false,
    );
  }
}
