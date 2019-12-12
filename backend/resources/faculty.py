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
import json


class FacultyListResource(Resource):

    def get(self):
        json_dict = get_json_dict("SELECT * FROM FACULTY_INFORMATION_VIEW")
        return {"response": json_dict}, 200


class FacultyInsertResource(Resource):

    def post(self):
        json_data = request.get_json()

        name = json_data['name']
        email = json_data['email']
        phone_number = json_data['phone_number']
        dept_id = json_data['dept_id']

        if name is None or email is None or phone_number is None or dept_id is None:
            return {'error': 'need all data'}, 404

        else:
            status = insert_faculty_procedure(name, email, phone_number, dept_id)
            if status=="success":
                return {'msg': 'faculty insertion successfull'}, 200
            else:
                return {'error':status}, 422
