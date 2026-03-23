import hashlib
from cryptography.hazmat.primitives.asymmetric import rsa, padding
from cryptography.hazmat.primitives import hashes, serialization

def gerar_par_de_chaves():
    privada = rsa.generate_private_key(public_exponent=65537, key_size=2048)
    publica = privada.public_key()
    return privada, publica

def exportar_chave_privada(chave_obj):
    return chave_obj.private_bytes(
        encoding=serialization.Encoding.PEM,
        format=serialization.PrivateFormat.PKCS8,
        encryption_algorithm=serialization.NoEncryption()
    ).decode('utf-8')

def exportar_chave_publica(chave_obj):
    return chave_obj.public_bytes(
        encoding=serialization.Encoding.PEM,
        format=serialization.PublicFormat.SubjectPublicKeyInfo
    ).decode('utf-8')

def assinar_texto(texto, chave_privada_pem):
    chave_privada = serialization.load_pem_private_key(chave_privada_pem.encode('utf-8'), password=None)
    assinatura = chave_privada.sign(
        texto.encode(),
        padding.PSS(mgf=padding.MGF1(hashes.SHA256()), salt_length=padding.PSS.MAX_LENGTH),
        hashes.SHA256()
    )
    return assinatura.hex() # Convertemos para HEX para salvar fácil no banco

def verificar_assinatura(texto, assinatura_hex, chave_publica_pem):
    chave_publica = serialization.load_pem_public_key(chave_publica_pem.encode('utf-8'))
    try:
        chave_publica.verify(
            bytes.fromhex(assinatura_hex),
            texto.encode(),
            padding.PSS(mgf=padding.MGF1(hashes.SHA256()), salt_length=padding.PSS.MAX_LENGTH),
            hashes.SHA256()
        )
        return True
    except:
        return False