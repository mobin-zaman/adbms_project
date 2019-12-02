from flask_restful import Resource
from .util import get_json_dict


class ThesisListResource(Resource):
    def get(self):
        return {"response": get_json_dict("select * from THESIS_INFORMATION_VIEW")}, 200
