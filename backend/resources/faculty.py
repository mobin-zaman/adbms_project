"""
insert teacher
update teacher info
show teacher list
show particular teacher
"""

from flask_restful import Resource
from flask import request  # needed for parsing POST requests
from .util import get_json_dict
from database.db import insert_faculty_procedure
from database.db import search_faculty
import json


class FacultyListResource(Resource):

    def get(self):
        json_dict = get_json_dict("SELECT * FROM FACULTY_INFORMATION_VIEW")
        return {"response": json_dict}, 200


class FacultyInsertResource(Resource):

    def post(self):
        json_data = request.get_json()

        try:
            id = json_data['id']
            name = json_data['name']
            email = json_data['email']
            phone_number = json_data['phone_number']
            dept_id = json_data['dept_id']
        except(Exception):
            return {'error': 'need all the data'}, 200

        status = insert_faculty_procedure(id, name, email, phone_number, dept_id)
        if status == "success":
            return {'msg': 'faculty insertion successful'}, 200
        else:
            return {'error': status}, 422


class FacultySearchByName(Resource):
    """url: /faculty/search/<string:name>"""

    def get(self, name):
        result = search_faculty(name)

        return result
