import os
from flask import Flask, request, jsonify

app = Flask(__name__)

@app.after_request
def add_cors(response):
    response.headers["Access-Control-Allow-Origin"] = "*"
    response.headers["Access-Control-Allow-Headers"] = "Content-Type"
    response.headers["Access-Control-Allow-Methods"] = "POST, OPTIONS"
    return response

@app.route('/hello', methods=['POST', 'OPTIONS'])
def hello():
    if request.method == 'OPTIONS':
        return ('', 204)
    data = request.get_json() or {}
    name = data.get('name', 'World')
    return jsonify({'message': f'Hello {name}'})

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=int(os.environ.get('PORT', 8080)))
