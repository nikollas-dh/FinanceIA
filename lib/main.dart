import 'package:flutter/material.dart';
import 'screens/cadastro_screen.dart';
import 'screens/home_screen.dart';
import 'screens/login_screen.dart';
import 'screens/recuperar_senha_screen.dart';
import 'theme/app_theme.dart';

void main() => runApp(const FinanceIAApp());

class FinanceIAApp extends StatelessWidget {
  const FinanceIAApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FinanceIA',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.tema,
      initialRoute: '/',
      routes: {
        '/': (_) => const LoginScreen(),
        '/cadastro': (_) => const CadastroScreen(),
        '/recuperar': (_) => const RecuperarSenhaScreen(),
        '/home': (_) => const HomeScreen(),
      },
    );
  }
}
