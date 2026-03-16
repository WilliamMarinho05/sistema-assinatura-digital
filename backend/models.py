from flask_sqlalchemy import SQLAlchemy
from datetime import datetime

db = SQLAlchemy()

class Usuario(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    username = db.Column(db.String(80), unique=True, nullable=False)
    chave_privada = db.Column(db.Text, nullable=False)
    chave_publica = db.Column(db.Text, nullable=False)

class Assinatura(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    texto = db.Column(db.Text, nullable=False)
    assinatura_hash = db.Column(db.Text, nullable=False)
    data_criacao = db.Column(db.DateTime, default=datetime.utcnow)
    usuario_id = db.Column(db.Integer, db.ForeignKey('usuario.id'))

class LogVerificacao(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    assinatura_id = db.Column(db.Integer, db.ForeignKey('assinatura.id'))
    resultado = db.Column(db.String(20)) # VALIDA ou INVALIDA
    data_verificacao = db.Column(db.DateTime, default=datetime.utcnow)