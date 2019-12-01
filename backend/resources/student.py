from flask_restful import Resource
from database.db import select_many_query


class StudentListResource(Resource):
    def get(self):
        sql = "select * from student_information_view"
        result = select_many_query(sql)
        print(result)
        return result
