# formulario_de_cadastro_completo_jonathan_antonio_marcilio

Aluno: Jonathan Antonio Marcilio 
Turma: ADS 5ª Fase

## Descrição

Este projeto consiste em um formulário de cadastro desenvolvido em Flutter utilizando Material Design 3.
O objetivo do projeto é demonstrar a implementação de:

* Validação de formulários
* Máscaras de entrada
* Gerenciamento de foco entre campos
* Uso de `TextEditingController`
* Organização de código com validators separados
* Seleção de data
* Feedback visual com SnackBars
* Controle de carregamento da interface

# Tecnologias Utilizadas

* Flutter
* Dart
* Material Design 3
* package:mask_text_input_formatter

# Funcionalidades Implementadas

## Cadastro de Usuário

O formulário permite o preenchimento dos seguintes dados:

* Nome completo
* Email
* CPF
* Telefone
* Senha
* Confirmação de senha
* Data de nascimento
* Aceite dos termos de uso

# Validações Implementadas

As validações foram separadas em um arquivo específico chamado: validators/validators.dart

## Validação de Nome

Regras implementadas: Campo obrigatório; Mínimo de 3 caracteres

## Validação de Email

Regras implementadas: Campo obrigatório; Verificação usando expressão regular (Regex)

Exemplo válido: usuario@email.com

## Validação de CPF

Regras implementadas: Campo obrigatório; Verificação de quantidade de dígitos

Máscara aplicada: 000.000.000-00

## Validação de Telefone

Regras implementadas: Campo obrigatório; Verificação de tamanho do número

Máscara aplicada: (00) 00000-0000

## Validação de Senha

Regras implementadas: Campo obrigatório; Mínimo de 6 caracteres

## Confirmação de Senha

Regras implementadas: Campo obrigatório; Comparação com a senha digitada anteriormente

# Máscaras de Entrada

O projeto utiliza o pacote:

mask_text_input_formatter

As máscaras foram implementadas para: CPF; Telefone

# Controle de Foco

Foi utilizado `FocusNode` para permitir navegação automática entre os campos utilizando o teclado.

Exemplo: onFieldSubmitted: (_) => _emailFocus.requestFocus(),

# Seleção de Data

A data de nascimento é selecionada utilizando: showDatePicker()

Regras implementadas: Data obrigatória; Limite mínimo: 1900; Limite máximo: data atual

# Termos de Uso

Foi implementado um `CheckboxListTile` para confirmação dos termos de uso.
O envio do formulário só é permitido quando o usuário aceita os termos.

# Feedback Visual

O sistema utiliza `SnackBar` para informar:

* Campos inválidos
* Data não selecionada
* Termos não aceitos
* Cadastro realizado com sucesso

# Indicador de Carregamento

Ao enviar o formulário:

O botão é substituído por um `CircularProgressIndicator`
É simulada uma operação assíncrona usando `Future.delayed`

# Estrutura do Projeto

lib/
│
└── screens/
│   └── cadastro_screen.dart
├── main.dart
│
└── validators/
    └── validators.dart

