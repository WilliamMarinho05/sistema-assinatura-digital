from flask_sqlalchemy import SQLAlchemy

db = SQLAlchemy()

class Usuario(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    username = db.Column(db.String(80), unique=True, nullable=False)
    chave_privada = db.Column(db.Text, nullable=False)
    chave_publica = db.Column(db.Text, nullable=False)
    senha = db.Column(db.String(128), nullable=False)
    # Atalho para acessar as assinaturas do usuário
    assinaturas = db.relationship('Assinatura', backref='autor', lazy=True)

class Assinatura(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    texto = db.Column(db.Text, nullable=False)
    assinatura_hash = db.Column(db.Text, nullable=False)
    # Usando o servidor do banco para marcar o tempo
    data_criacao = db.Column(db.DateTime, default=db.func.current_timestamp())
    usuario_id = db.Column(db.Integer, db.ForeignKey('usuario.id'))
    # Atalho para acessar os logs dessa assinatura
    logs = db.relationship('LogVerificacao', backref='assinatura_ref', lazy=True)

class LogVerificacao(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    assinatura_id = db.Column(db.Integer, db.ForeignKey('assinatura.id'))
    resultado = db.Column(db.String(20)) # VÁLIDA ou INVÁLIDA
    data_verificacao = db.Column(db.DateTime, default=db.func.current_timestamp())