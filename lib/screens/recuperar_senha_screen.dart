import 'package:flutter/material.dart';
import '../utils/validators.dart';

class RecuperarSenhaScreen extends StatefulWidget {
  const RecuperarSenhaScreen({super.key});

  @override
  State<RecuperarSenhaScreen> createState() => _RecuperarSenhaScreenState();
}

class _RecuperarSenhaScreenState extends State<RecuperarSenhaScreen> {
  final _form = GlobalKey<FormState>();
  final _email = TextEditingController();

  @override
  void dispose() {
    _email.dispose();
    super.dispose();
  }

  Future<void> _recuperar() async {
    if (!_form.currentState!.validate()) return;
    await showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Solicitação realizada'),
        content: Text(
            'Se ${_email.text.trim()} estiver cadastrado, enviaremos as instruções de recuperação.'),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(ctx), child: const Text('OK')),
        ],
      ),
    );
    if (mounted) Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Recuperar senha')),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: _form,
          child: Column(
            children: [
              const Icon(Icons.lock_reset, size: 72, color: Color(0xFF1B8A5A)),
              const SizedBox(height: 16),
              const Text('Informe seu e-mail para recuperar a senha.'),
              const SizedBox(height: 24),
              TextFormField(
                controller: _email,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                    labelText: 'E-mail', prefixIcon: Icon(Icons.email_outlined)),
                validator: Validators.email,
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                  onPressed: _recuperar, child: const Text('Recuperar senha')),
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Voltar ao login'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
