"""
insert teacher
update teacher info
show teacher list
show particular teacher
"""

from flask_restful import Resource
from .util import get_json_dict
from database.db import select_many_query
import json


class FacultyListResource(Resource):

    def get(self):

        json_dict = get_json_dict("SELECT * FROM FACULTY_INFORMATION_VIEW")
        return {"response": json_dict}, 200
