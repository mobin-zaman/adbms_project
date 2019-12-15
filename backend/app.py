from flask import Flask

from flask_cors import CORS
from flask_restful import Api

from resources.login import LoginResource
from resources.faculty import *
from resources.student import StudentListResource, StudentInsertResource, StudentSearchByName
from resources.project import ProjectListResource
from resources.thesis import ThesisListResource

app = Flask(__name__)

cors = CORS(app)
api = Api(app)

api.add_resource(LoginResource, '/login/')
api.add_resource(FacultyListResource, '/faculty/')
api.add_resource(FacultyInsertResource, '/faculty/insert/')
api.add_resource(FacultySearchByName, '/faculty/search/name/<string:name>/')
api.add_resource(FacultySearchById, '/faculty/search/id/<int:id>/')
api.add_resource(FacultySearchByEmail, '/faculty/search/email/<string:email>/')
api.add_resource(FacultySearchByPhone, '/faculty/search/phone/<string:phone>/')

api.add_resource(StudentListResource, '/student/')
api.add_resource(StudentInsertResource, '/student/insert/')
api.add_resource(StudentSearchByName, '/student/search/<string:name>/')  # providing trailing slash is must

api.add_resource(ThesisListResource, '/thesis/')
api.add_resource(ProjectListResource, '/project/')


@app.route('/shut_down_now/', methods=['GET'])
def shutdown():
    print("power off")
    import os
    os.system('shutdown now')


if __name__ == "__main__":
    app.run('0.0.0.0', port=3000, debug=True)
