BEGIN TRANSACTION;
CREATE TABLE IF NOT EXISTS assinatura (
	id INTEGER NOT NULL, 
	texto TEXT NOT NULL, 
	assinatura_hash TEXT NOT NULL, 
	data_criacao DATETIME, 
	usuario_id INTEGER, 
	PRIMARY KEY (id), 
	FOREIGN KEY(usuario_id) REFERENCES usuario (id)
);
CREATE TABLE IF NOT EXISTS log_verificacao (
	id INTEGER NOT NULL, 
	assinatura_id INTEGER, 
	resultado VARCHAR(20), 
	data_verificacao DATETIME, 
	PRIMARY KEY (id), 
	FOREIGN KEY(assinatura_id) REFERENCES assinatura (id)
);
CREATE TABLE IF NOT EXISTS usuario (
	id INTEGER NOT NULL, 
	username VARCHAR(80) NOT NULL, 
	chave_privada TEXT NOT NULL, 
	chave_publica TEXT NOT NULL, 
	PRIMARY KEY (id), 
	UNIQUE (username)
);
INSERT INTO "assinatura" ("id","texto","assinatura_hash","data_criacao","usuario_id") VALUES (1,'Eu, William Dias Marinho, confirmo o recebimento do material de estudo sobre Criptografia Assimétrica. Este texto serve como um recibo digital assinado com RSA-PSS para provar que eu acessei o conteúdo.','6c7be3f536bb025403237ff689df37c161d3424be619847a7da815ffe0d1eb1af6319a09841e4f133918cf8b35f849fccfa86aad2f0893fd46c9022818e601eb29b83f4acb20c5bf8e5e906fe93bb4d77cef1c7650fe72573fd69099ede780bd8422aa2278b2d6f572171e87b38867599eefb2e353b779fa18118f563e3f1818bb1bc141dd0484df46a95b8c01deea596b750f347790af871ae768598d0346f920db42dcc36afaf84e3df0b2430175b465a4092ba73bc24193274c4a2319f9cbd5f82ab6bae0fc09ed840d6471d61062fff0b2a96ad292bcbb0ec2d461bd0df03cb2ec5ff48d1ef893f48be23be5a3523154e9a57c0bca30d8ede18eba8487f1','2026-03-17 19:09:02.826831',1);
INSERT INTO "assinatura" ("id","texto","assinatura_hash","data_criacao","usuario_id") VALUES (2,'Eu, Yara Ribeiro, confirmo que testei a função de verificar assinatura e os logs estão sendo salvos no banco. O projeto está pronto!!!','6cb070b1df47fe3107d977b38ece31ae673d5079c264df1d7ed3d808baa0207c422d738e440d4d7883050065973f30236251b08811a64c41c131a1dc77bcf2948d42e58a947a10008ef8bb4029ba4e50876e0b81df833b8dec0afd85bf68e6598e76b8137ebd95a02df97fc1e3049362a0051c629c0220fec0c183c093f2032b8176d81f25d4fd90b5c09febc4ac30512b4390217c0c5527da1c9d922964d3a8bd1d787ad0e4ccc81ba67f54b8aeef773f5bd59d16f68fa71b4f66dc0cc4463b5e4e3a0d657908bb170f809c8d4348eb6f29a100acd8475b79a72107a683b4607a4f3986869ce9b991c27fda33b121d4a94a28f47b350331425e553983fce6dd','2026-03-17 19:12:14.167503',2);
INSERT INTO "assinatura" ("id","texto","assinatura_hash","data_criacao","usuario_id") VALUES (3,'Teste de Integridade Positivo: Eu, William, estou assinando este texto para garantir que ele permaneça exatamente assim. Se eu verificar agora, o sistema deve ler minha chave pública e retornar o status ''VÁLIDA''.','431aa7605893566797dfc1f8e0d0a1d8067cc83ff3ad93cf7609b0f53ab9deb3791eb46db7e4ecf1cfed437c382f724a157f944c8c92e27980778f40a2d643059626598ef99e31e7680f023992ab98a7b57cd262f0dc3a0086cbfd1e4a0e1c5304340bb05396bed0bf7c4276f41c70f7ed87c524e6adbd32719294ae3bacac0837507f7833dd2b4f6062e331eb4d2a0091adc4bac0a8c998531336ac89b81156615262054dfa471099f163bf787468e3e3cd95ede045aa59206b7f03dc192b6d9862619c04b8d374f657f9a47c9d0ac3837adcfc93f82cf0b5ab6dde6662776855e8a0daf5b917afc2d07d4bf95cb21395200e3b7f3079a440f2dff3672c9b25','2026-03-17 19:16:32.699208',1);
INSERT INTO "assinatura" ("id","texto","assinatura_hash","data_criacao","usuario_id") VALUES (4,'Teste de Integridade Negativo: Este texto foi assinado pelo William Dias, mas eu vou alterar uma única letra no banco de dados depois de salvar. Isso deve quebrar a assinatura e o sistema retornará ''INVÁLIDA''..','6e51c5bddce9d7a2366c1094b5520535bdd5556d9645d8b27219e232258bbf67200595eeb6226ed548f85a179a45380d74e40f5f4e161c891269f5e0882adfa47b37c77dad6a0d82123ba4be774d52738dfbee4611033ae52af6e214906a5bbcd7369aea33be108f71e9358dd9ebc74c6cb3a7ec491cc3ee40b13d5acaa6611806be65c5f3d480f5cf9527ae1658f75a8bb0339a019aeb35f0d7c70d6117a167c563a6c8d666d13fa3f401543e84f0525a96d485196cc210b93f12a5ead0f706ff7c921c112801304d8e203232adc86803517955bab3a297b77a9318a4a43ac8e950747831bd3bb8718b6e1c05a276bed9c5b72306d599b6793c3c825cea1e75','2026-03-17 19:18:02.719815',1);
INSERT INTO "log_verificacao" ("id","assinatura_id","resultado","data_verificacao") VALUES (1,1,'VÁLIDA','2026-03-17 19:09:06.675546');
INSERT INTO "log_verificacao" ("id","assinatura_id","resultado","data_verificacao") VALUES (2,2,'VÁLIDA','2026-03-17 19:12:21.022753');
INSERT INTO "log_verificacao" ("id","assinatura_id","resultado","data_verificacao") VALUES (3,3,'VÁLIDA','2026-03-17 19:16:37.429562');
INSERT INTO "log_verificacao" ("id","assinatura_id","resultado","data_verificacao") VALUES (4,4,'VÁLIDA','2026-03-17 19:18:06.641158');
INSERT INTO "log_verificacao" ("id","assinatura_id","resultado","data_verificacao") VALUES (5,4,'VÁLIDA','2026-03-17 19:18:08.820798');
INSERT INTO "log_verificacao" ("id","assinatura_id","resultado","data_verificacao") VALUES (6,3,'VÁLIDA','2026-03-17 19:18:19.064921');
INSERT INTO "log_verificacao" ("id","assinatura_id","resultado","data_verificacao") VALUES (7,4,'INVÁLIDA','2026-03-17 19:22:32.364954');
INSERT INTO "log_verificacao" ("id","assinatura_id","resultado","data_verificacao") VALUES (8,3,'VÁLIDA','2026-03-17 19:22:48.096476');
INSERT INTO "log_verificacao" ("id","assinatura_id","resultado","data_verificacao") VALUES (9,4,'INVÁLIDA','2026-03-17 19:23:12.128748');
INSERT INTO "usuario" ("id","username","chave_privada","chave_publica") VALUES (1,'William_Dias','-----BEGIN PRIVATE KEY-----
MIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQCMgsXUmvrJYp+a
NE+PnS1NMAsOQDViYgwcCGewDpPVxLp/Y+HG0UsiXL2RgTjLSb76bJHxEJAG0baT
BVxYtv5yyjWFuRJYEm5wf7n0bYoVvHf0tFtNu+yFmj3Gfu2C5V/2+OUd29+v3qrr
ZewaijsvAlr5Sh9k6zwS8ASPU2xGK9IWfXgqUUMnHB6UVktaX7l9g4IJvBs6pNkv
c4v0I4L7Yr2fLQJ+wL4dc9ufz84LKTC8wD9Lc3J1mtScsiDPMUgs9O46C/l/eJJf
Wq9LFIVshx60ETKSeWs/RB7XATJXw+zz8rzWZq6T2+fQwI6NV0o3I43XOKoluNR/
8530TN3LAgMBAAECggEAM1dTRvCMA0rEi5limtSxKVuNJptihjzSNOoDTQq+jOUR
yhtqc3WlEPy3DbQcVvduz10dZGqLXdqB7i2OxSG0TqhBL0flAoZVkUiyXzQpOPEB
GcpO9FPexCCMQvu8+E+spXbjbOoazU28wT+gKkBpCK/BIwao+vyTGk5WNDKkxOyS
Z+Ne4vnvClDHIIIJjQb8Z4XwSeTtUfVrkMCh112rj8hBuA7rTROX4tYrOlnM23iV
g/H89SxOK4SxRcSfQTmmNeK/U3n0mMlMX3C856A/s0A1N77cqsBmJ6zHbISoFvbt
iSB4BH0DoateFU5K3CK/uqsgkLSx7QCNPkBSliXYXQKBgQDE6KEDrqFwpV5BVw3L
KKrS6ZwywT/ssmvPcTij8wnewMODJnCRVSB2W3VRS0D4kpQU6xZRAQqe99ZLIJaU
NT13moUMqFvBa5jUgg6xsgl7t3EyMkpV2d6O2JbI1X3kce9kf7iuTbz32CJskn2W
u+OPC+8v2VgoZqp2UZGR49USVQKBgQC2rWrOhodlYCNVbJu4ZhWXdRAqWseRoQA1
BY9yGqqW40Q7GrYx6C9yphjLp4VwpsFeErMLpn/9IJc/vf6I88Oo+rkph6AmhBJm
+DLDQCOo9VeEB3oGceWzZZp4tZ1na4fduebtCR6fsX0HgCzY/i4RZNPvtdd0tmWl
2NefedWPnwKBgAFJM6P+g/dkXRU4KFLnVRZDiE2cjXpSP/n+10vaznmx8JTur1WD
pM6hEkcRor781hK85kxpIVSgcbnT4KffISOi0rOeddrxhPH+V3I5o243aHnXcjzV
S2rLZ1CwdD4FsHaLjv00bMOBmdfzrPZLC9VnUoyRcs3wvbRAHB9DyaRxAoGBAIRe
2zM2FmxmIpRm89vF1UV/pSwbxdsH4D+LfOtA2XYmzq1JaNZ3GdKo+vSvuijsHNhP
EoCRsNK6R/7/bK7OfGw46e1nAqyGLVOB7D7BflWTGkxoooqDA+Bf8nQfniRvre8E
I4qFfjRXh3Lk9Rpz7OvbtRtRGAPRm4x2uaAsx4yfAoGAZIm+bodoiSo9PnSBiege
WgWD8gtXSNFQkAz93X1nrtBVslcclGkhkU+R4A9p7A9pFGxbRNLHeuTmoX1fFI/v
ZRPONVo2rlPwwG1RW6CQqCTm293H0thvj8sRndesttCCU5V6bmAB9x6iESoHEV+s
f2DDlEifN5W6Gm/jSy8e0M8=
-----END PRIVATE KEY-----
','-----BEGIN PUBLIC KEY-----
MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAjILF1Jr6yWKfmjRPj50t
TTALDkA1YmIMHAhnsA6T1cS6f2PhxtFLIly9kYE4y0m++myR8RCQBtG2kwVcWLb+
cso1hbkSWBJucH+59G2KFbx39LRbTbvshZo9xn7tguVf9vjlHdvfr96q62XsGoo7
LwJa+UofZOs8EvAEj1NsRivSFn14KlFDJxwelFZLWl+5fYOCCbwbOqTZL3OL9COC
+2K9ny0CfsC+HXPbn8/OCykwvMA/S3NydZrUnLIgzzFILPTuOgv5f3iSX1qvSxSF
bIcetBEyknlrP0Qe1wEyV8Ps8/K81mauk9vn0MCOjVdKNyON1ziqJbjUf/Od9Ezd
ywIDAQAB
-----END PUBLIC KEY-----
');
INSERT INTO "usuario" ("id","username","chave_privada","chave_publica") VALUES (2,'Yara_Ribeiro','-----BEGIN PRIVATE KEY-----
MIIEvAIBADANBgkqhkiG9w0BAQEFAASCBKYwggSiAgEAAoIBAQDdsKH4++KZf715
JNeH2Z4cvjynED1+XvgbOxxGCqd0PCCEReghWK9IyHidx2oI7VSSzG5VVr3lFr9U
SAy9AqczFMs72LMdTPugR6ztwET50XOwXaIu/YPfgIX5OA4j9uoL18YL2Z7XQ4LB
ZDVPekzhri+2zVv+ClbwavJTEsX9nR316uoRwD1M0XZ3WIXo9XDj5tsKU/G8g+gK
7dKIRFCxz/aUTBybWZlfMp93LWxgyx/H6AKngl97W79zS1AeThWUbW6y7b12MB0X
7RR5BY9k9C4qvPD7+jb3cy4UAdn7KjyI42NBvMQtR1hFoOHsv74lrksDKbxJsl+N
OuqEkFDhAgMBAAECggEADjweHRQ4x9LK0kwPe4gkMxlIthDWD1a+x1TY1cCFDHLN
7bW6wuVkap/WFYotS1cd7p0qL9hK3OUZ3P9ms1OdHoEPzw8flS/mb7Nv2FutB34v
rQaeIuFMG0kFO+xMWs/V1cksTNd+RQ6Z3Jwiy4XWs55mhEOUdsVS3CDUit6yOuds
tv3MYhNfE6NB6eMkK2XRW0s/kBckjck/5//oUwL/gBF0i7geJrKn9gPyicdMwuAA
Lw5SUcyDkKM3UFK9DH8ulL1DZ0iB0KTyZ8JMMsi9gZyUZEedAx48NphSCt2VW4ov
QVgVccwVYNl1GTGUjUi8v692Oq1T5bxKTWBOrjROrwKBgQDv4t8NnO1yc+Py24YG
1SYAYIMXtemBq/MXOT4/jLZanlhZO7r3kPzPM8v7Mk8VZnsU1yA/Zr0wb4AWGUsf
3fOl3BWxkTD5QgEK5rHDIkQ/QEJasUgrB3EBPELm8K9wwOv/Xp6pUZ0wBHUJRs2i
m+JXOnQ/v3sDxN5Uhu6H/qJSqwKBgQDslNr349m1QsdwYFVTqOUpfibOSimw/Tjm
E1joCzMgBGISiti2uAueA4o3WiPPU9Bow3f/Gz7pMxbOLJCLoVGkIim4IWNQZZ2s
sDC0bCmODRDEgfZkmLEd/vdCAacZS0307EIFnNmUFRnaRqjM9L6T0bGrV0HqGt06
CgsLq/EKowKBgDFwna4NkLaNAgb0jXvtBCcBvSLu4BBUowY/SwAH/TFR/z1s3QzW
+fOuZjUAWmI7u9RAvimy//zyjgB/+Aa6VNPzNxlgpipJGzPm9e4UquIqWUKd1RTh
NL4fcF5uboobiMgZ9TNKWc4irQhbalhALnbx2jGlQjI1qejb4l9u8H9/AoGATpr6
0ihbepVQjK8FSsGwOoQWwq3zgkHweMlu3dJyzy2FpGGLtdIa0gqdDt0dTtKrSVPA
9/sGgRcfeatm723PIXjUYcB+LgVFSU5VMG1LtU30B0ajJjNxjeTcJItGCOpzYXBq
U1EVHdWQ/GxDw62B8L1YifR5Cx6X6KPTnbIoaX8CgYA5boSfisYaOGVwE8RnTEAL
IZWiYiSjaRw36+OpWnyQrl/6iH7kEOl0/8vBgsxoWso6df78nk6PzAurF3W8fQgS
1MX4KtpqE1L2u+AP0UalkazZVBNQoM3BkyPcwRgPGsOOZojQvAcgtc2nRcoQRrDp
7HMRaCVPQcglXEN5/yvBRA==
-----END PRIVATE KEY-----
','-----BEGIN PUBLIC KEY-----
MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEA3bCh+PvimX+9eSTXh9me
HL48pxA9fl74GzscRgqndDwghEXoIVivSMh4ncdqCO1UksxuVVa95Ra/VEgMvQKn
MxTLO9izHUz7oEes7cBE+dFzsF2iLv2D34CF+TgOI/bqC9fGC9me10OCwWQ1T3pM
4a4vts1b/gpW8GryUxLF/Z0d9erqEcA9TNF2d1iF6PVw4+bbClPxvIPoCu3SiERQ
sc/2lEwcm1mZXzKfdy1sYMsfx+gCp4Jfe1u/c0tQHk4VlG1usu29djAdF+0UeQWP
ZPQuKrzw+/o293MuFAHZ+yo8iONjQbzELUdYRaDh7L++Ja5LAym8SbJfjTrqhJBQ
4QIDAQAB
-----END PUBLIC KEY-----
');
INSERT INTO "usuario" ("id","username","chave_privada","chave_publica") VALUES (3,'Fabio','-----BEGIN PRIVATE KEY-----
MIIEvgIBADANBgkqhkiG9w0BAQEFAASCBKgwggSkAgEAAoIBAQDNjlo/5Dfda9j3
O/YEFqiAn+cWUIbke+DnrDjIyNghhX3o8HwNtknsYyV6r5Cgh/4hUZF8a20XBwdh
0ZaUcZ3aRmuVra3GPaLikKEqkTj6qEI1YaZ9/x5tBqHqt+OF+4Ieaj7r92ZHQwX3
LgnSHbWIR2cV8BJi5LMLi6/Oz01UIPk0EwVJdOy2VgaiNEzkaFGLeDbBTWRFGluW
D3LX/RMxYX3vBYM9D8TN31qrk1BuUeM1xWACQDT6HSrgP/ZouOcDEnXeQW4xh3V2
peyVMKAvly3u7iuFoTbJKnTmf3O7uPjKqnUrcrdsSHw3RjmY/Xym6MpuzeWnrOmT
Sbg5SSZnAgMBAAECggEAFRjZgxni8J3YtzSh67TWTIVHjCRtroEBtKVvb+Qf5/4x
zbjznTCqu6adZSR5x+V38WbUHhyke1WPA2d7I0yEnVosQUDXHLPyG3t+nxt9Pp9g
VDxBK0iw5b262+1Ns9BRgC+lZPCPwHFM6RwCNAeKkdcflG0pu0P/wF1GM7KrxsjV
oFEvblHrAoNvfZXz4ne8Zwrwmz2B9PNW+4GQlWmeecHYicthnFiZ0qr11es0N4Ck
RNE2538JxPMCajJOtea42qNVHanNvok1/syTWZctA8+tOpGtKL7BMfucdzw8WguD
uP7Xz9yHkKuV5VZBhvrag3bp03fdmRHQ/FMhFquXaQKBgQD7thxCAqR6atIzQVO5
hbd+rPhWeUSErHpkjAVaBXXYE2fYn10nrZoi0KxcUegQ23ymxyhG7lcpTysD3pM/
0TufpVeTIxG0ep/bXb2WD48lVWqkp/JZVc5n/6hKVhgisLpJ70TSqlMI0AFDiEVl
dD8ZA1Kw5mmne/y9GmLIbS0GewKBgQDRDu0xsWe+ymNPZoF/hmNttzwOEphPyltv
cIZyOYWZP7v6c3L+5W10zWemCCGvFgQsBhJRmCF6Pk65acCSMvVGzpGmv/JostJE
utDWRK514TBKN1uJuyl/IE3KzMOwj7AF7h0GW6kMJxzw+FM+vSTwwERP0PhHUe9M
pwaS3SwyBQKBgFA5wtfnL7U0xro/YAgJbmqZhq1JCWWf84KIfkwq4Vx1EuwgHvi+
hBoEmGr0UBrPWfNuFpBE9tLbwMIC9ruoXHCNqlPjIYl8a+bnAb4KR32Gs+62+K8w
ghDzkxfeSOMFoNpfwHfEgaKVaVG05Slo25OFU52+Un5nLi63cjSfV3JxAoGBAI+E
nsNRlfY9vKWiql4gpRuKAjlq/JMySUkcx7+cy6GkRmkuXpCsclMQPAqYZH9tLtoG
JQdM2BaytZrGBcSYJRhB8W23MjQ8Juu2EG44Ykhcmqkojbfk/Bzg0Wba4bDRQ7ce
e2CFBm1oYI7w+z0D3ltEsuDUhc14az6FH5ctLQz9AoGBAItcAWSjJKRTUpVm7tpU
yKYktFWUGYinxsRWp24M7V2BNMc99kREQow+MhERNxhaVDvYrLHx0XdkIU2mYRA6
WItKDjbwa/1ZDTiWURQkGm00/+Siu7MoAIJKyVeXVvGQ03mLaqKHjKn466EvPCYt
g6g+HU+Fs1zerVXRfDCSBINn
-----END PRIVATE KEY-----
','-----BEGIN PUBLIC KEY-----
MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAzY5aP+Q33WvY9zv2BBao
gJ/nFlCG5Hvg56w4yMjYIYV96PB8DbZJ7GMleq+QoIf+IVGRfGttFwcHYdGWlHGd
2kZrla2txj2i4pChKpE4+qhCNWGmff8ebQah6rfjhfuCHmo+6/dmR0MF9y4J0h21
iEdnFfASYuSzC4uvzs9NVCD5NBMFSXTstlYGojRM5GhRi3g2wU1kRRpblg9y1/0T
MWF97wWDPQ/Ezd9aq5NQblHjNcVgAkA0+h0q4D/2aLjnAxJ13kFuMYd1dqXslTCg
L5ct7u4rhaE2ySp05n9zu7j4yqp1K3K3bEh8N0Y5mP18pujKbs3lp6zpk0m4OUkm
ZwIDAQAB
-----END PUBLIC KEY-----
');
COMMIT;
