import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import '../validators/validators.dart';

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
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.blue,
      ),
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

// ====================================================================================================================================
class FormExamplePage extends StatefulWidget {
  const FormExamplePage({super.key});

  @override
  State<FormExamplePage> createState() => _FormExamplePageState();
}

// ====================================================================================================================================
class _FormExamplePageState extends State<FormExamplePage> {
  final _formKey = GlobalKey<FormState>();

  // Controlles
  final _nomeController = TextEditingController();
  final _emailController = TextEditingController();
  final _cpfController = TextEditingController();
  final _telefoneController = TextEditingController();
  final _senhaController = TextEditingController();
  final _confirmaSenhaController = TextEditingController();

  // Focus 
  final _nomeFocus = FocusNode();
  final _emailFocus = FocusNode();
  final _cpfFocus = FocusNode();
  final _telefoneFocus = FocusNode();
  final _senhaFocus = FocusNode();
  final _confirmaSenhaFocus = FocusNode();

  // Outras Variáveis 
  DateTime? _dataNascimento;

  bool _aceitaTermos = false;
  bool _carregando = false;

  // Dispose dos controllers e focus pra otimizar memória 
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

  // Máscara do CPF
  final _cpfMask = MaskTextInputFormatter(
    mask: '###.###.###-##',
    filter: {"#": RegExp(r'[0-9]')},
  );

  // Máscara do Telefone
  final _telefoneMask = MaskTextInputFormatter(
    mask: '(##) #####-####',
    filter: {"#": RegExp(r'[0-9]')},
  );

  // Seletor de Data
  Future<void> _selecionarData() async {
    final data = await showDatePicker(
      context: context,
      initialDate: DateTime(2000),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (data != null) {
      setState(() => _dataNascimento = data);
    }
  }

  // Botão de enviar ====================================================================================================================================
  void _enviarFormulario() async {
    if (!_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Corrija os campos inválidos'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    if (_dataNascimento == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Selecione a data de nascimento'),
          backgroundColor: Colors.orange,
        ),
      );
      return;
    }

    if (!_aceitaTermos) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Você deve aceitar os termos'),
          backgroundColor: Colors.orange,
        ),
      );
      return;
    }

    setState(() => _carregando = true);

    await Future.delayed(const Duration(seconds: 2));

    setState(() => _carregando = false);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Cadastro realizado com sucesso'),
        backgroundColor: Colors.green,
      ),
    );
  }

  // Construção da UI ====================================================================================================================================
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Formulário de Cadastro Completo'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              // Nome =====================================================================================================================
              const SizedBox(height: 12),
              TextFormField(
                controller: _nomeController,
                focusNode: _nomeFocus,
                decoration: const InputDecoration(
                  labelText: 'Nome Completo',
                ),
                textInputAction: TextInputAction.next,
                onFieldSubmitted: (_) => _emailFocus.requestFocus(),
                validator: Validators.validarNome,
              ),
              // Email ====================================================================================================================
              const SizedBox(height: 12),
              TextFormField(
                controller: _emailController,
                focusNode: _emailFocus,
                decoration: const InputDecoration(
                  labelText: 'Email',
                ),
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.next,
                onFieldSubmitted: (_) => _cpfFocus.requestFocus(),
                validator: Validators.validarEmail,
              ),
              // CPF =====================================================================================================================
              const SizedBox(height: 12),
              TextFormField(
                controller: _cpfController,
                focusNode: _cpfFocus,
                decoration: const InputDecoration(
                  labelText: 'CPF',
                ),
                keyboardType: TextInputType.number,
                inputFormatters: [_cpfMask],
                textInputAction: TextInputAction.next,
                onFieldSubmitted: (_) => _telefoneFocus.requestFocus(),
                validator: Validators.validarCPF,
              ),
              // Telefone ================================================================================================================
              const SizedBox(height: 12),
              TextFormField(
                controller: _telefoneController,
                focusNode: _telefoneFocus,
                decoration: const InputDecoration(
                  labelText: 'Telefone',
                ),
                keyboardType: TextInputType.phone,
                inputFormatters: [_telefoneMask],
                textInputAction: TextInputAction.next,
                onFieldSubmitted: (_) => _senhaFocus.requestFocus(),
                validator: Validators.validarTelefone,
              ),
              // Senha ===================================================================================================================
              const SizedBox(height: 12),
              TextFormField(
                controller: _senhaController,
                focusNode: _senhaFocus,
                decoration: const InputDecoration(
                  labelText: 'Senha',
                ),
                obscureText: true,
                textInputAction: TextInputAction.next,
                onFieldSubmitted: (_) =>
                    _confirmaSenhaFocus.requestFocus(),
                validator: Validators.validarSenha,
              ),
              // Confirmar senha =========================================================================================================
              const SizedBox(height: 12),
              TextFormField(
                controller: _confirmaSenhaController,
                focusNode: _confirmaSenhaFocus,
                decoration: const InputDecoration(
                  labelText: 'Confirme a Senha',
                ),
                obscureText: true,
                validator: (value) {
                  return Validators.validarConfirmacaoSenha(
                  value,
                  _senhaController.text,
                  );
                },
              ),
              // Data ====================================================================================================================
              const Divider(height: 32),
              ListTile(
                title: const Text('Data de nascimento'),
                subtitle: Text(
                  _dataNascimento == null
                      ? 'Não selecionada'
                      : '${_dataNascimento!.day}/${_dataNascimento!.month}/${_dataNascimento!.year}',
                ),
                trailing: const Icon(Icons.calendar_month),
                onTap: _selecionarData,
              ),
              // Termos ==================================================================================================================
              const Divider(height: 32),
              CheckboxListTile(
                title: const Text('Aceito os termos de uso'),
                value: _aceitaTermos,
                onChanged: (v) {
                  setState(() => _aceitaTermos = v!);
                },
              ),
              // Botão ===================================================================================================================
              const SizedBox(height: 24),
              _carregando
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
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