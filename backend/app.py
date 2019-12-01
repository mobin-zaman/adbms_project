from flask import Flask

from flask_cors import CORS
from flask_restful import Api

from resources.login import LoginResource
from resources.faculty import FacultyListResource
from resources.student import StudentListResource

app = Flask(__name__)

cors = CORS(app)
api = Api(app)

api.add_resource(LoginResource, '/login/')
api.add_resource(FacultyListResource, '/faculty/')
api.add_resource(StudentListResource, '/student/')

if __name__ == "__main__":
    app.run('0.0.0.0', port=5000, debug=True)
