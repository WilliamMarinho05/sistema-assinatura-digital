# Sistema de Assinatura Digital

## Descrição
O projeto foi construido visando avaliação e aprendizagem do conhecimento produzido na matéria de "Segurança de Sistemas". No mesmo foram utilizadas tecnologias como Python e SQLite, as quais juntas conseguem fazer um sistema que:
 * Cadastra um usuário para a geração de chaves assimétricas (e as gera).
 * Permite assinatura autenticada, calcula um hash.
 * Armazena desses metadados e consulta publicamente a integridade desses dados por meio do hash gerado. 
 
 Esse processos todo ainda deve guardar os logs de verificação/consulta.

## Estrutura do Projeto

    Sistema-assinatura-digital
    ├── backend/
    │   ├── _pycache_/
    │   │   ├── crypto_web.cpython-313.pyc
    │   │   └── models.cpython-313.pyc
    │   ├── instance/
    │   │   └── assinador.db
    │   ├── templates/
    │   │   └── index.html
    │   ├── app.py
    │   ├── crypto_web.py
    │   └── models.py
    ├── .gitignore
    ├── dump_banco.sql
    ├── README.md
    └── requirements.txt


## Instruções de Instalação

### 📋 Pré-requisitos

Antes de começar, certifique-se de ter instalado em sua máquina:
* [cite_start]*Python 3.x*: O projeto foi desenvolvido utilizando a linguagem Python[cite: 2].
* [cite_start]*Pip*: Gerenciador de pacotes do Python para instalar as dependências listadas no requirements.txt[cite: 2].

---

## 🛠️ Instruções de Instalação

### 1. Preparar o Ambiente
Recomenda-se o uso de um ambiente virtual para manter as dependências isoladas:
bash
# Criar o ambiente virtual
python -m venv venv

# Ativar o ambiente (Windows)
venv\Scripts\activate

# Ativar o ambiente (Linux/macOS)
source venv/bin/activate

[cite_start]Nota: A pasta venv/ já está configurada para ser ignorada pelo Git[cite: 1].

### 2. Instalar Dependências
Com o ambiente ativo, instale as bibliotecas necessárias (Flask, SQLAlchemy, Cryptography, etc.):
bash
pip install -r requirements.txt

[cite_start]As principais bibliotecas instaladas incluem Flask (3.1.2), Flask-SQLAlchemy (3.1.1) e cryptography (45.0.7)[cite: 2].

---

## 🚀 Etapas para Executar

### 1. Inicialização do Banco de Dados
O arquivo app.py está configurado para criar automaticamente a estrutura do banco de dados SQLite (assinador.db) dentro da pasta instance/ ao ser iniciado.

### 2. Importação do Dump (Opcional/Recomendado)
Para carregar os dados de teste, você pode importar o arquivo dump_banco.sql.
* Como o banco é SQLite, você pode usar uma ferramenta como *SQLite Browser* ou a linha de comando para executar o conteúdo de dump_banco.sql após o arquivo .db ser gerado pela primeira vez.

### 3. Rodar a Aplicação
Execute o servidor Flask:
bash
python app.py

A aplicação estará disponível em http://localhost:5000.

---

## 🔍 Resumo de Endpoints Disponíveis

| Endpoint | Método | Descrição |
| :--- | :--- | :--- |
| / | GET | Página principal (Interface Web). |
| /cadastro | POST | Cadastra usuário e gera chaves RSA. |
| /assinar | POST | Gera assinatura RSA-PSS com SHA-256. |
| /verify/<id> | GET | Verifica a validade da assinatura e gera logs. |

---

## Funcionalidades
Este projeto possui várias funcionalidades, dentre elas estão principalmente:
* Cadastro de usuário.
* Geração de chaves assimétricas.
* Assinatura por parte do usuário.
* Geração de hash.
* Armazenamento de metadados.
* Verificação pública dos dados.
* Persistência em banco de dados.

## Casos de teste
Foram realizados alguns testes, onde foi possível ver a alteração ou não da assinatura. 

É possível verifica-los ao rodar o projeto e olhar em "assinador.db", na pasta instance (ambos serão gerados nesse processo). Nestes casos de teste foram criados três usuários:
* Fábio
* William
* Yara

Os mesmos fizeram quatro assinaturas (exceto Fábio) e várias verificações, as quais seus logs ficaram armazenados no arquivo criado.

## Desenvolvedores
*   William Dias Marinho e Yara Fernandes Ribeiro
## Licença
Este projeto é de código aberto disponivel para fins educacionais.
