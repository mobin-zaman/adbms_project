from flask import Flask

from flask_restful import Api
from resources.login import LoginResource
from resources.faculty import FacultyListResource
from flask_cors import CORS

app = Flask(__name__)

cors = CORS(app)
api = Api(app)

api.add_resource(LoginResource, '/login/')
api.add_resource(FacultyListResource, '/faculty/')

if __name__ == "__main__":
    app.run('0.0.0.0', port=5000, debug=True)
