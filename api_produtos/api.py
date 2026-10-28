from flask import Flask, jsonify

app = Flask(__name__)

produtos = [
    {"id": 1, "nome": "Mouse", "preco": 59.90, "categoria": "Periféricos"},
    {"id": 2, "nome": "Teclado", "preco": 129.90, "categoria": "Periféricos"},
    {"id": 3, "nome": "Monitor", "preco": 899.90, "categoria": "Monitores"},
    {"id": 4, "nome": "Headset", "preco": 249.90, "categoria": "Áudio"},
    {"id": 5, "nome": "Webcam", "preco": 189.90, "categoria": "Vídeo"},
]


@app.get("/produtos")
def listar_produtos():
    return jsonify(produtos)


if __name__ == "__main__":
    app.run(debug=True, port=5000)
