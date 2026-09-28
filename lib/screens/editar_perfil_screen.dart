import 'package:flutter/material.dart';
import '../services/auth_service.dart';
import '../utils/validators.dart';

class EditarPerfilScreen extends StatefulWidget {
  const EditarPerfilScreen({super.key});

  @override
  State<EditarPerfilScreen> createState() => _EditarPerfilScreenState();
}

class _EditarPerfilScreenState extends State<EditarPerfilScreen> {
  final _form = GlobalKey<FormState>();
  late final TextEditingController _nome;
  late final TextEditingController _usuario;
  late final TextEditingController _bio;

  @override
  void initState() {
    super.initState();
    final u = AuthService.instance.atual!;
    _nome = TextEditingController(text: u.nome);
    _usuario = TextEditingController(text: u.usuario);
    _bio = TextEditingController(text: u.bio);
  }

  @override
  void dispose() {
    _nome.dispose();
    _usuario.dispose();
    _bio.dispose();
    super.dispose();
  }

  void _salvar() {
    if (!_form.currentState!.validate()) return;
    final ok = AuthService.instance.atualizarPerfil(
        _nome.text.trim(), _usuario.text.trim(), _bio.text.trim());
    if (ok) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Dados atualizados!')));
      Navigator.pop(context);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Nome de usuário já está em uso'),
        backgroundColor: Colors.red,
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Editar perfil')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: _form,
          child: Column(
            children: [
              const CircleAvatar(
                radius: 48,
                backgroundImage: AssetImage('assets/images/avatar.png'),
              ),
              const SizedBox(height: 24),
              TextFormField(
                controller: _nome,
                decoration: const InputDecoration(
                    labelText: 'Nome', prefixIcon: Icon(Icons.badge_outlined)),
                validator: (v) => Validators.obrigatorio(v, 'Nome'),
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
              TextFormField(
                controller: _bio,
                maxLines: 3,
                maxLength: 120,
                decoration: const InputDecoration(labelText: 'Biografia'),
                validator: (v) => Validators.obrigatorio(v, 'Biografia'),
              ),
              const SizedBox(height: 16),
              ElevatedButton(onPressed: _salvar, child: const Text('Salvar')),
            ],
          ),
        ),
      ),
    );
  }
}
