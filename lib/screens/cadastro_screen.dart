import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Formulário de Cadastro Completo Jonathan Antonio Marcilio',
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.blue),
      home: const FormExamplePage(),
    );
  }
}

// ==================================================================================================================================== 
class CadastroData {
  final String nome;
  final String email; 
  final String cpf;
  final String telefone;
  final String senha;
  final String confirmaSenha;
  final DateTime? dataNascimento;
  final bool aceitouTermos;

  CadastroData({
    required this.nome,
    required this.email,
    required this.cpf,
    required this.telefone,
    required this.senha,
    required this.confirmaSenha,
    required this.dataNascimento,
    required this.aceitouTermos,
  });
}

// ==========================================================================================================================================
class FormExamplePage extends StatefulWidget {
  const FormExamplePage({super.key});

  @override
  State<FormExamplePage> createState() => _FormExamplePageState();
}

// ======================================================================================================================================
class _FormExamplePageState extends State<FormExamplePage> {
  final _formKey = GlobalKey<FormState>();

  final _nomeController = TextEditingController();
  final _emailController = TextEditingController();
  final _cpfController = TextEditingController();
  final _telefoneController = TextEditingController();
  final _senhaController = TextEditingController();
  final _confirmaSenhaController = TextEditingController();

  final _nomeFocus = FocusNode();
  final _emailFocus = FocusNode();
  final _cpfFocus = FocusNode();
  final _telefoneFocus = FocusNode();
  final _senhaFocus = FocusNode();
  final _confirmaSenhaFocus = FocusNode();

  DateTime? _dataNascimento;

  bool _aceitaTermos = false;
  bool _carregando = false;

  @override
  void dispose() {
    _nomeController.dispose();
    _emailController.dispose();
    _cpfController.dispose();
    _telefoneController.dispose();
    _senhaController.dispose();
    _confirmaSenhaController.dispose();
    _nomeFocus.dispose();
    _emailFocus.dispose();
    _cpfFocus.dispose();
    _telefoneFocus.dispose();
    _senhaFocus.dispose();
    _confirmaSenhaFocus.dispose();
    super.dispose();
  }

  Future<void> _selecionarData() async {
    final data = await showDatePicker(
      context: context,
      initialDate: DateTime(2000),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (data != null) setState(() => _dataNascimento = data);
  }

  void _enviarFormulario() async {
    if (!_formKey.currentState!.validate() || !_aceitaTermos) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Verifique os campos obrigatórios'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }
    
    setState(() => _carregando = true);
    await Future.delayed(const Duration(seconds: 2));
    setState(() => _carregando = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Formulário de Cadastro Completo')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              // Nome do Usuário =======================================================================================================
              const SizedBox(height: 12),
              TextFormField(
                controller: _nomeController,
                focusNode: _nomeFocus,
                decoration: const InputDecoration(labelText: 'Nome Completo'),
                textInputAction: TextInputAction.next,
                onFieldSubmitted: (_) => _emailFocus.requestFocus(),
                validator: (v) => v!.isEmpty ? 'Campo obrigatório' : null,
              ),
              // Email do Usuário =======================================================================================================
              const SizedBox(height: 12),
              TextFormField(
                controller: _emailController,
                focusNode: _emailFocus,
                decoration: const InputDecoration(labelText: 'Email'),
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.emailAddress,
                onFieldSubmitted: (_) => _cpfFocus.requestFocus(),
                validator: (v) => v!.contains('@') ? null : 'Email inválido',
              ),
              // CPF do Usuário =========================================================================================================
              const SizedBox(height: 12),
              TextFormField(
                controller: _cpfController,
                focusNode: _cpfFocus,
                decoration: const InputDecoration(labelText: 'CPF'),
                textInputAction: TextInputAction.next,
                onFieldSubmitted: (_) => _telefoneFocus.requestFocus(),
                validator: (v) => v!.isEmpty ? 'Campo obrigatório' : null,
              ),
              // Telefone do Usuário ====================================================================================================
              const SizedBox(height: 12),
              TextFormField(
                controller: _telefoneController,
                focusNode: _telefoneFocus,
                decoration: const InputDecoration(labelText: 'Telefone'),
                textInputAction: TextInputAction.next,
                onFieldSubmitted: (_) => _senhaFocus.requestFocus(),
                validator: (v) => v!.isEmpty ? 'Campo obrigatório' : null,
              ),
              // Senha do Usuário =======================================================================================================
              const SizedBox(height: 12),
              TextFormField(
                controller: _senhaController,
                focusNode: _senhaFocus,
                decoration: const InputDecoration(labelText: 'Senha'),
                obscureText: true,
                textInputAction: TextInputAction.next,
                onFieldSubmitted: (_) => _confirmaSenhaFocus.requestFocus(),
                validator: (v) => v!.isEmpty ? 'Campo obrigatório' : null,
              ),
              // Confirmação da Senha ===================================================================================================
              const SizedBox(height: 12),
              TextFormField(
                controller: _confirmaSenhaController,
                focusNode: _confirmaSenhaFocus,
                decoration: const InputDecoration(labelText: 'Confirme a Senha'),
                obscureText: true,
                textInputAction: TextInputAction.next,
                validator: (v) => v!.isEmpty ? 'Campo obrigatório' : null,
              ),
              // Data de Nascimento do Usuário ==========================================================================================
              const Divider(height: 32),
              ListTile(
                title: const Text('Data de nascimento'),
                subtitle: Text(_dataNascimento == null
                    ? 'Não selecionada'
                    : '${_dataNascimento!.day}/${_dataNascimento!.month}/${_dataNascimento!.year}'),
                trailing: const Icon(Icons.calendar_month),
                onTap: _selecionarData,
              ),
              // Checkbox Termos de Uso =================================================================================================
              const Divider(height: 32),
              CheckboxListTile(
                title: const Text('Aceito os termos de uso'),
                value: _aceitaTermos,
                onChanged: (v) => setState(() => _aceitaTermos = v!),
              ),
              // Botão de Confirmação ===================================================================================================
              const SizedBox(height: 24),
              _carregando
                  ? const Center(child: CircularProgressIndicator())
                  : FilledButton(
                      onPressed: _enviarFormulario,
                      child: const Text('Enviar'),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}

