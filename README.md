# ✒️ Sistema de Assinatura Digital Web

## 📖 Descrição
Este projeto foi desenvolvido para a disciplina de **Segurança de Sistemas**. A aplicação utiliza criptografia assimétrica (**RSA-PSS**) e funções de hash (**SHA-256**) para garantir a autenticidade, integridade e o não-repúdio de documentos digitais.Além disso, o postgres é utilizado para a persistência dos dados funcionando em colaboração com o arquivo "dump_banco.sql" que está na raiz para importação.


O sistema permite:
* Cadastrar usuários com geração automática de par de chaves (Pública/Privada).
* Realizar assinaturas digitais de textos.
* Verificar publicamente se um documento foi alterado após a assinatura.
* Armazenar logs de auditoria de todas as verificações realizadas.

---

## 📂 Estrutura do Projeto

    Sistema-assinatura-digital
    ├── core/
    │   ├── _pycache_/
    │   │   ├── crypto_web.cpython-313.pyc
    │   │   └── models.cpython-313.pyc
    │   ├── crypto_web.py
    │   └── models.py
    ├── static/
    │   └── css/
    │       ├── cadastro.css
    │       ├── chaves.css
    │       ├── dashboard.css
    │       ├── login.css
    │       ├── style.css
    │       └── verificar.css
    ├── templates/
    │   ├── cadastro.html
    │   ├── chaves.html
    │   ├── dashboard.html
    │   ├── login.html
    │   └── verificar.html
    ├── .env
    ├── .gitignore
    ├── app.py
    ├── dump_banco.sql
    ├── README.md
    └── requirements.txt



---

## 🚀 Como Rodar o Projeto

### 1. Pré-requisitos
* **Python 3.x** instalado.
* Gerenciador de pacotes **pip**.

### 2. Instalação de Dependências
Abra o terminal na raiz do projeto e execute:

    bash
    pip install python-dotenv
    pip install -r requirements.txt


### 3. Execução do Servidor
Para iniciar a aplicação, execute o comando apontando para o script dentro de app.py:

    bash
    python app.py
    
    Acesse no navegador: `http://localhost:5000`

---

## 🔍 Resumo de Endpoints e Exemplos

| Endpoint | Método | Descrição |
| :--- | :--- | :--- |
| `/` | GET | Página principal de interação. |
| `/cadastro` | POST | Gera par de chaves e salva o usuário. |
| `/login` | POST | Atualiza a aplicação para que as informações privadas do usuário apareçam. |
| `/assinar` | POST | Gera a assinatura digital RSA-PSS de um texto. |
| `/verify/<id>` | GET | Valida a integridade da assinatura por ID. |

### 📝 Exemplos de Requisição/Resposta (JSON)

**Fazer login (`POST /login`)**
* **Request:** `{"username": "William", "senha": "[senha]"}`
* **Response:** `{"id": 1, "assinatura": "6c7be3f...", "senha_usada": "[senha]"}`


**Criar Assinatura (`POST /assinar`)**
* **Request:** `{"username": "William", "texto": "Conteúdo de Teste"}`
* **Response:** `{"id": 1, "assinatura": "6c7be3f...", "hash_usado": "SHA-256"}`

**Verificar Assinatura (`GET /verify/1`)**
* **Response (VÁLIDA):** `{"status": "VÁLIDA", "signatario": "William", "algoritmo": "RSA-PSS-SHA256"}`

---

## 🧪 Casos de Teste (Critérios de Aceitação)

O sistema possui um script de **Auto-Seeding**. Ao iniciar sem um banco pré-existente, ele utiliza o `dump_banco.sql` para carregar os usuários **William, Yara, Beto e Zeuygma**.

### 1. Teste de Validação Positiva
* **Objetivo:** Provar que o sistema detecta fraudes ou alterações nos dados.
* **Procedimento:** 
    1. Entrar em "validar público".
    2. Digitar ID da assinatura.
    3. Clicar em verificar.
    * Como exemplo de validação positiva, podemos usar o ID "125" da signatária "Hellen". Com isso será possível verificar o hash da assinatura.

* **Resultado:** O sistema retorna **VÁLIDA**, pois o texto no banco coincide com a assinatura gerada originalmente.

### 2. Teste de Validação Negativa (Integridade Alterada)
* **Objetivo:** Provar que o sistema detecta fraudes ou alterações nos dados.
* **Procedimento:** 
    1. Entrar em "validar público".
    2. Digitar ID da assinatura.
    3. Clicar em verificar.
    * Como exemplo de validação negativa, podemos usar o ID "278" do signatário "Breno". Com isso será possível verificar o hash da assinatura.

* **Resultado:** O sistema retorna **INVÁLIDA**, demonstrando que a assinatura digital não corresponde mais ao conteúdo modificado.

---


## 👥 Desenvolvedores
* **William Dias Marinho**
* **Yara Fernandes Ribeiro**


---
