import os
from flask import Flask, request, jsonify, render_template
from models import db, Usuario, Assinatura, LogVerificacao
from crypto_web import *

basedir = os.path.abspath(os.path.dirname(__file__))

app = Flask(__name__)

app.config['SQLALCHEMY_DATABASE_URI'] = 'sqlite:///' + os.path.join(basedir, 'instance', 'assinador.db')
app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False

db.init_app(app)
@app.route('/')
def index():
    return render_template('index.html')

@app.route('/cadastro', methods=['POST'])
def cadastro():
    data = request.json
    user = Usuario.query.filter_by(username=data['username']).first()
    if user: return jsonify({"error": "Usuário já existe"}), 400
    
    priv_obj, pub_obj = gerar_par_de_chaves()
    novo_user = Usuario(
        username=data['username'],
        chave_privada=exportar_chave_privada(priv_obj),
        chave_publica=exportar_chave_publica(pub_obj)
    )
    db.session.add(novo_user)
    db.session.commit()
    return jsonify({"message": "Usuário criado!"}), 201

@app.route('/assinar', methods=['POST'])

@app.route('/assinar', methods=['POST'])
def assinar():
    data = request.json 
    user = Usuario.query.filter_by(username=data['username']).first()
    
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
    
    return jsonify({"status": resultado, "signatario": user.username, "algoritmo": "RSA-PSS-SHA256", "data": ass.data_criacao})

if __name__ == '__main__':
    with app.app_context(): db.create_all()
    app.run(host='0.0.0.0', port=5000)