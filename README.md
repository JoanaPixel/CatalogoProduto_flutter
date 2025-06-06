# 🛒 Velory Market

**Velory Market** é um aplicativo Flutter que simula um catálogo de produtos com integração à [Fake Store API da Platzi](https://api.escuelajs.co/docs/). O projeto utiliza **Supabase** para autenticação e gerenciamento de perfil, além de `flutter_secure_storage` para manter sessões seguras localmente.



---

## 🚀 Funcionalidades

- 🔐 Login seguro com Supabase Auth
- 📲 Sessão persistente com armazenamento criptografado
- 🧾 Listagem dinâmica de produtos da Fake Store da Platzi
- 🔍 Tela de detalhes de produtos com imagem, descrição e preço
- 🛒 Carrinho de compras com estado gerenciado via `Provider`
- 📋 Menu lateral com informações do perfil
- 🚪 Logout funcional com limpeza da sessão local

---

## 🧠 Decisões Técnicas

- **Flutter** para entregar rápido e multiplataforma
- **Supabase** para backend moderno sem servidor
- **Provider** para gerenciamento simples e eficaz de estado
- **flutter_secure_storage** para garantir persistência segura da sessão
- **Platzi Fake Store API** como fonte de produtos para simulação realista

---

## 🧰 Tecnologias Utilizadas

| Tecnologia               | Descrição                                      |
|--------------------------|-----------------------------------------------|
| Flutter                  | Framework para apps móveis                     |
| Supabase                 | Autenticação e banco de dados em nuvem         |
| Platzi Fake Store API    | Fonte de dados de produtos simulados           |
| Provider                 | Gerenciamento de estado do carrinho e auth     |
| flutter_secure_storage   | Armazenamento local seguro                     |
| HTTP package             | Consumo da API externa                         |

---

## 📂 Estrutura de Diretórios

```
lib/
├── main.dart                      # Inicialização Supabase + Providers
├── screens/
│   ├── catalog_screen.dart        # Tela principal com produtos
│   ├── product_detail_screen.dart# Detalhes de produtos
│   └── cart_screen.dart           # Tela do carrinho
├── providers/
│   ├── auth_provider.dart         # Estado do usuário
│   └── cart_provider.dart         # Estado do carrinho
├── services/
│   └── auth_service.dart          # Lógica de autenticação e sessão
```

---

## ▶️ Como Rodar o Projeto

### 1. Pré-requisitos

- [Flutter SDK](https://flutter.dev/docs/get-started/install)
- Conta no [Supabase](https://supabase.com/)
- Um projeto com tabela `profiles` no Supabase

### 2. Clone o Repositório

```bash
git clone https://github.com/seuusuario/velory_market.git
cd velory_market
```

### 3. Instale as Dependências

```bash
flutter pub get
```

### 4. Configure o Supabase

No `main.dart`, substitua com suas credenciais:

```dart
await Supabase.initialize(
  url: 'https://<sua-url>.supabase.co',
  anonKey: '<sua-anon-key>',
);
```

### 5. Rode o App

```bash
flutter run
```

---

## 🔗 API Utilizada

> [Fake Store API - Platzi](https://api.escuelajs.co/docs/)

**Endpoint utilizado:**

```http
GET https://api.escuelajs.co/api/v1/products?offset=0&limit=10
```

Exemplo de resposta:
```json
{
  "id": 1,
  "title": "Awesome Granite Shirt",
  "price": 100,
  "description": "A description...",
  "images": ["https://...jpg"]
}
```

---


## Colaboradores

| Nome      | Contato                          |
|-----------|----------------------------------|
|  Juscelino/TokyoSXR|https://github.com/TOKYOSXR   |
|  Henrique          |https://github.com/HenriqueECM|
|  Joana             |https://github.com/JoanaPixel |

---

## 📄 Licença

Distribuído sob a licença MIT.
