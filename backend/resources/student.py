import json
from flask_restful import Resource
from database.db import select_many_query
from pprint import pprint


class StudentListResource(Resource):
    def get(self):
        sql = "select * from student_information_view"
        result = select_many_query(sql)
        meta, rows = result[0],result[1]

        json_dict = {
            "column_names":[ x[0] for x in meta],
            "fields":[ list(x) for x in rows]
        }

        return {"response": json_dict},200

