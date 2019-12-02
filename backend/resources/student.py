import json
from flask_restful import Resource
from .util import get_json_dict
from database.db import select_many_query
from pprint import pprint


class StudentListResource(Resource):
    def get(self):
        json_dict = get_json_dict("SELECT * FROM STUDENT_INFORMATION_VIEW")
        return {"response": json_dict}, 200
