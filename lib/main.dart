import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:structured_writing_protocol/presentation/home_page.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:structured_writing_protocol/theme/app_theme.dart';
import 'package:structured_writing_protocol/domain/entities/cycle.dart';
import 'package:structured_writing_protocol/domain/entities/session.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  
  Hive.registerAdapter(CycleAdapter());
  Hive.registerAdapter(SessionAdapter());
  
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
      home: HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
