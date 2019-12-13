import json
from flask_restful import Resource
from database.db import select_many_query
from pprint import pprint


class StudentListResource(Resource):
    def get(self):
        result = select_many_query("select * from STUDENT_INFORMATION_VIEW")
        return {"response": result}, 200
