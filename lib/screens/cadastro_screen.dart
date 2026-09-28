import 'package:flutter/material.dart';
import '../models/usuario.dart';
import '../services/auth_service.dart';
import '../utils/validators.dart';
import '../widgets/campo_senha.dart';

class CadastroScreen extends StatefulWidget {
  const CadastroScreen({super.key});

  @override
  State<CadastroScreen> createState() => _CadastroScreenState();
}

class _CadastroScreenState extends State<CadastroScreen> {
  final _form = GlobalKey<FormState>();
  final _nome = TextEditingController();
  final _email = TextEditingController();
  final _usuario = TextEditingController();
  final _senha = TextEditingController();
  final _confirma = TextEditingController();

  @override
  void dispose() {
    for (final c in [_nome, _email, _usuario, _senha, _confirma]) {
      c.dispose();
    }
    super.dispose();
  }

  void _cadastrar() {
    if (!_form.currentState!.validate()) return;
    final ok = AuthService.instance.cadastrar(Usuario(
      nome: _nome.text.trim(),
      email: _email.text.trim(),
      usuario: _usuario.text.trim(),
      senha: _senha.text,
    ));
    if (ok) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Cadastro realizado com sucesso! Faça login.')));
      Navigator.pop(context);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('E-mail ou usuário já cadastrado'),
        backgroundColor: Colors.red,
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Criar conta')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: _form,
          child: Column(
            children: [
              TextFormField(
                controller: _nome,
                decoration: const InputDecoration(
                    labelText: 'Nome', prefixIcon: Icon(Icons.badge_outlined)),
                validator: (v) => Validators.obrigatorio(v, 'Nome'),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _email,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                    labelText: 'E-mail', prefixIcon: Icon(Icons.email_outlined)),
                validator: Validators.email,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _usuario,
                decoration: const InputDecoration(
                    labelText: 'Nome de usuário',
                    prefixIcon: Icon(Icons.alternate_email)),
                validator: (v) => Validators.obrigatorio(v, 'Usuário'),
              ),
              const SizedBox(height: 16),
              CampoSenha(controller: _senha, validator: Validators.senha),
              const SizedBox(height: 16),
              CampoSenha(
                controller: _confirma,
                label: 'Confirmar senha',
                validator: Validators.confirmacao(_senha),
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                  onPressed: _cadastrar, child: const Text('Cadastrar')),
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Já tenho conta. Voltar ao login'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
