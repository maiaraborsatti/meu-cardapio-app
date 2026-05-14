# 📋 Casos de Uso – MeuCardapio

## 📖 Visão Geral

Este documento descreve os principais casos de uso do aplicativo **MeuCardapio**, desenvolvido para gerenciamento alimentar, cadastro de usuários, alimentos e cardápios personalizados.

---

# 👤 Ator do Sistema

| Ator | Descrição |
|---|---|
| Usuário | Responsável por utilizar todas as funcionalidades do aplicativo. |

---

# 1. Realizar Login

## Descrição
Permite que o usuário acesse o aplicativo utilizando suas credenciais.

## Pré-condições
- Usuário previamente cadastrado

## Fluxo Principal
1. Usuário acessa a tela de login
2. Informa suas credenciais
3. Sistema valida os dados
4. Sistema redireciona para a tela principal

## Fluxos Alternativos
- Credenciais inválidas → Exibir mensagem de erro

## Pós-condições
- Usuário autenticado no sistema

---

# 2. Cadastro de Usuário

## Descrição
Permite cadastrar um novo usuário no aplicativo.

## Fluxo Principal
1. Usuário acessa a tela de cadastro
2. Informa nome, foto e data de nascimento
3. Sistema valida os campos obrigatórios
4. Sistema salva os dados

## Regras de Negócio
- Nome é obrigatório
- Data de nascimento deve ser válida

---

# 3. Cadastro de Alimentos

## Descrição
Permite cadastrar alimentos no sistema.

## Fluxo Principal
1. Informar nome do alimento
2. Selecionar foto
3. Escolher categoria
4. Escolher tipo
5. Salvar alimento

## Regras de Negócio

### Categorias permitidas
- Café
- Almoço
- Janta

### Tipos permitidos
- Bebida
- Proteína
- Carboidrato
- Fruta
- Grão

---

# 4. Cadastro de Cardápio

## Descrição
Permite criar cardápios personalizados para usuários cadastrados.

## Fluxo Principal
1. Selecionar usuário
2. Selecionar 3 opções de café
3. Selecionar 5 opções de almoço
4. Selecionar 4 opções de janta
5. Salvar cardápio

## Regras de Negócio
- Café deve conter exatamente 3 opções
- Almoço deve conter exatamente 5 opções
- Janta deve conter exatamente 4 opções

---

# 5. Consulta de Dados

## Descrição
Permite consultar usuários, alimentos e cardápios cadastrados.

## Funcionalidades
- Buscar usuário por nome
- Buscar alimento por nome
- Buscar cardápio por usuário

---

# 6. Compartilhamento

## Descrição
Permite compartilhar alimentos e cardápios utilizando aplicativos externos do dispositivo.

## Fluxo Principal
1. Usuário seleciona item
2. Sistema abre menu de compartilhamento
3. Usuário escolhe aplicativo
4. Sistema envia conteúdo

---

# 7. Logout

## Descrição
Permite encerrar a sessão do usuário.

## Fluxo Principal
1. Usuário acessa a opção de logout
2. Sistema encerra a sessão
3. Usuário retorna para tela de login

---

# 8. Visualizar Créditos

## Descrição
Exibe os integrantes responsáveis pelo desenvolvimento do projeto.

## Fluxo Principal
1. Usuário acessa a tela de créditos
2. Sistema apresenta os integrantes do grupo
