import 'package:flutter/material.dart';
import 'screens/cadastro_screen.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Controle de Leitura',
      debugShowCheckedModeBanner: false,
      initialRoute: '/cadastro',
      routes: {
        '/cadastro': (context) => FormExamplePage(),
      },
    );
  }
}