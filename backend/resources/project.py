from flask_restful import Resource
from .util import get_json_dict


class ProjectListResource(Resource):
    def get(self):
        return {"response": get_json_dict("select * from PROJECT_INFORMATION_VIEW")}, 200
