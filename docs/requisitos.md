# 📋 Requisitos do Projeto — MeuCardapio

## 📖 Visão Geral

O aplicativo **MeuCardapio** tem como objetivo auxiliar no gerenciamento alimentar, permitindo o cadastro de usuários, alimentos e cardápios personalizados, além da consulta e compartilhamento das informações cadastradas.

---

# Requisitos Funcionais

## RF01 — Login de Usuário
O sistema deve permitir que o usuário realize login na aplicação.

## RF02 — Cadastro de Usuário
O sistema deve permitir o cadastro de novos usuários contendo:
- Nome
- Foto
- Data de nascimento

## RF03 — Persistência de Login
O sistema deve manter o usuário autenticado e direcioná-lo automaticamente para a Tela Principal caso já esteja logado.

## RF04 — Logout
O sistema deve permitir que o usuário realize logout da aplicação.

---

## RF05 — Cadastro de Alimentos
O sistema deve permitir o cadastro de alimentos contendo:
- Nome
- Foto
- Categoria:
  - Café
  - Almoço
  - Janta
- Tipo:
  - Bebida
  - Proteína
  - Carboidrato
  - Fruta
  - Grão

---

## RF06 — Cadastro de Cardápio
O sistema deve permitir o cadastro de cardápios personalizados contendo:
- Usuário vinculado
- Três opções para café
- Cinco opções para almoço
- Quatro opções para janta

## RF07 — Busca de Usuários
O sistema deve permitir buscar usuários pelo nome, apresentando:
- Nome
- Foto
- Idade calculada automaticamente a partir da data de nascimento

## RF08 — Busca de Alimentos
O sistema deve permitir buscar alimentos pelo nome, apresentando:
- Nome
- Foto
- Categoria
- Tipo

## RF09 — Busca de Cardápios
O sistema deve permitir buscar cardápios pelo nome do usuário, apresentando:
- Opções de café
- Opções de almoço
- Opções de janta

---

## RF10 — Compartilhamento de Alimentos
O sistema deve permitir compartilhar as informações de um alimento utilizando aplicativos nativos de compartilhamento do dispositivo.

## RF11 — Compartilhamento de Cardápios
O sistema deve permitir compartilhar as informações de um cardápio utilizando aplicativos nativos de compartilhamento do dispositivo.

---

## RF12 — Tela de Créditos
O sistema deve apresentar uma tela de créditos contendo o nome completo dos integrantes do grupo.

---

# ⚙️ Requisitos Não Funcionais

## RNF01 — Plataforma
O aplicativo deve ser desenvolvido utilizando Flutter e Dart.

## RNF02 — Persistência de Dados
Os dados devem ser armazenados localmente utilizando SQLite.

## RNF03 — Interface
A interface deve seguir os padrões do Material Design.

## RNF04 — Compatibilidade
O aplicativo deve ser executado em dispositivos Android.

## RNF05 — Recursos Nativos
O aplicativo deve permitir integração com:
- Câmera
- Galeria
- Compartilhamento nativo do dispositivo

---

# 🗂 Entidades do Sistema

## Usuário
- Nome
- Foto
- Data de nascimento

## Alimento
- Nome
- Foto
- Categoria
- Tipo

## Cardápio
- Usuário
- Café da manhã
- Almoço
- Janta