"""
insert teacher
update teacher info
show teacher list
show particular teacher
"""

from flask_restful import Resource
from database.db import select_many_query


class FacultyListResource(Resource):

    def get(self):
        sql = "select * from faculty_information_view"
        result = select_many_query(sql)
        print(result)


