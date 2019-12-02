"""
insert teacher
update teacher info
show teacher list
show particular teacher
"""

from flask_restful import Resource
from database.db import select_many_query
import json


class FacultyListResource(Resource):

    def get(self):
        sql = "select * from faculty_information_view"  # FIXME: give order by in the faculty_information_view
        result_data = select_many_query(sql)

        result_dict = {"coloumn_names"};
