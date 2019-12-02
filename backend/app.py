from flask import Flask

from flask_cors import CORS
from flask_restful import Api

from resources.login import LoginResource
from resources.faculty import FacultyListResource
from resources.student import StudentListResource
from resources.project import ProjectListResource
from resources.thesis import ThesisListResource

app = Flask(__name__)

cors = CORS(app)
api = Api(app)

api.add_resource(LoginResource, '/login/')
api.add_resource(FacultyListResource, '/faculty/')
api.add_resource(StudentListResource, '/student/')
api.add_resource(ThesisListResource,'/thesis/')
api.add_resource(ProjectListResource,'/project/')

if __name__ == "__main__":
    app.run('0.0.0.0', port=5000, debug=True)
