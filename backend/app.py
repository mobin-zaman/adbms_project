from flask import Flask

from flask_restful import Api
from resources.login import LoginResource
from flask_cors import CORS

app = Flask(__name__)

cors = CORS(app, resource={r"/api/": {"origins": ""}})
api = Api(app)

api.add_resource(LoginResource, '/login/')

if __name__ == "__main__":
    app.run('0.0.0.0', port=5000, debug=True)
