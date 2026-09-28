class Usuario {
  String nome;
  String email;
  String usuario;
  String senha;
  String bio;

  Usuario({
    required this.nome,
    required this.email,
    required this.usuario,
    required this.senha,
    this.bio = 'Organizando minhas finanças.',
  });
}
