import os
from flask import Flask, redirect, request, jsonify, render_template, session, Response, url_for
from sqlalchemy import text
from dotenv import load_dotenv

import hashlib

from core.crypto_web import *
from core.models import db, Usuario, Assinatura, LogVerificacao

load_dotenv()

app = Flask(__name__)
app.config['SQLALCHEMY_DATABASE_URI'] = os.getenv('DATABASE_URL')
app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False

app.config['SECRET_KEY'] = os.urandom(24)
db.init_app(app)
@app.route('/')

def pg_login():
    return render_template('login.html')

@app.route('/cadastro', methods=['POST'])
def cadastro():
    data = request.json
    user = Usuario.query.filter_by(username=data['username']).first()
    if user: return jsonify({"error": "Usuário já existe"}), 400
    
    priv_obj, pub_obj = gerar_par_de_chaves()
    senha_hash = hashlib.sha256(data['senha'].encode()).hexdigest()

    novo_user = Usuario(
        username=data['username'],
        senha=senha_hash,
        chave_privada=exportar_chave_privada(priv_obj),
        chave_publica=exportar_chave_publica(pub_obj)
    )
    db.session.add(novo_user)
    db.session.commit()
    return jsonify({"message": "Usuário criado!"}), 201

@app.route('/pg-cadastro')
def pg_cadastro():
    return render_template('cadastro.html')

@app.route('/dashboard')
def pg_dashboard():
    if 'user_id' not in session:
        return redirect(url_for('pg_login'))
    
    usuario = Usuario.query.get(session['user_id'])
    minhas_assinaturas = Assinatura.query.filter_by(usuario_id=usuario.id).order_by(Assinatura.id.desc()).all()
    
    return render_template('dashboard.html', assinaturas=minhas_assinaturas)

@app.route('/verificar')
def pg_verificar():
    return render_template('verificar.html')

@app.route('/assinar', methods=['POST'])
def assinar():
    if 'user_id' not in session:
        return jsonify({"error": "Precisa estar logado"}), 401
        
    data = request.json 
    user = Usuario.query.get(session['user_id'])
    
    assinatura_hex = assinar_texto(data['texto'], user.chave_privada)
    
    nova_ass = Assinatura(
        texto=data['texto'], 
        assinatura_hash=assinatura_hex, 
        usuario_id=user.id,
    )
    db.session.add(nova_ass)
    db.session.commit()
    
    return jsonify({
        "id": nova_ass.id, 
        "hash_usado": "SHA-256", 
        "assinatura": assinatura_hex
    })

@app.route('/verify/<int:id>', methods=['GET'])
def verificar_rota(id):
    ass = Assinatura.query.get(id)
    if not ass: return jsonify({"status": "Não encontrada"}), 404
    
    user = Usuario.query.get(ass.usuario_id)
    valido = verificar_assinatura(ass.texto, ass.assinatura_hash, user.chave_publica)
    
    resultado = "VÁLIDA" if valido else "INVÁLIDA"
    log = LogVerificacao(assinatura_id=id, resultado=resultado)
    db.session.add(log)
    db.session.commit()
    
    return jsonify({
        "status": resultado, 
        "autor": user.username, 
        "algoritmo": "RSA-PSS-SHA256", 
        "data": ass.data_criacao.strftime('%d/%m/%Y %H:%M'),
        "documento": ass.texto, 
        "hash": ass.assinatura_hash
    })

@app.route('/login', methods=['POST'])
def login():
    data = request.json
    user = Usuario.query.filter_by(username=data['username']).first()
    if user:
        senha_hash = hashlib.sha256(data['senha'].encode()).hexdigest()
        if user.senha != senha_hash:
            return jsonify({"error": "Senha incorreta"}), 401

        session['user_id'] = user.id
        session['username'] = user.username
        return jsonify({"message": "Login realizado!", "user": user.username}), 200
    return jsonify({"error": "Usuário não encontrado"}), 404

@app.route('/logout')
def logout():
    session.clear()
    return redirect(url_for('pg_login'))

@app.route('/usuarios')
def pg_usuarios():
    if 'user_id' not in session:
        return redirect(url_for('pg_login'))
    
    todos_usuarios = Usuario.query.all()
    usuario_atual = Usuario.query.get(session['user_id'])
    
    return render_template('usuarios.html', 
                           usuarios=todos_usuarios, 
                           atual=usuario_atual)

@app.route('/download-chave/<tipo>')
def download_key(tipo):
    if 'user_id' not in session:
        return "Não autorizado", 401

    user = Usuario.query.get(session['user_id'])
    if not user:
        return "Usuário não encontrado", 404

    if tipo == 'privada':
        content = user.chave_privada
    elif tipo == 'publica':
        content = user.chave_publica
    else:
        return "Tipo de chave inválido", 400

    return Response(
        content,
        mimetype="application/x-pem-file",
        headers={"Content-Disposition": f"attachment; filename=chave_{tipo}_{user.username}.pem"}
    )

@app.route('/chaves')
def pg_chaves():
    if 'user_id' not in session:
        return redirect(url_for('pg_login'))
    
    todos = Usuario.query.all()
    atual = Usuario.query.get(session['user_id'])
    
    return render_template('chaves.html', usuarios=todos, atual=atual)

@app.route('/download-chave-publica-outros/<int:user_id>')
def download_publica_outros(user_id):
    if 'user_id' not in session:
        return "Não autorizado", 401

    user = Usuario.query.get(user_id)
    if not user:
        return "Usuário não encontrado", 404

    return Response(
        user.chave_publica,
        mimetype="application/x-pem-file",
        headers={"Content-Disposition": f"attachment; filename=chave_publica_{user.username}.pem"}
    )


if __name__ == '__main__':
    with app.app_context():
        db.create_all()
    app.run(host='0.0.0.0', port=5000)