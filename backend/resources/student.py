import json
from flask_restful import Resource
from database.db import select_query
from database.student_methods import *
from flask import request


class StudentListResource(Resource):
    def get(self):
        result = select_query("select * from STUDENT_INFORMATION_VIEW")
        return {"response": result}, 200


class StudentInsertResource(Resource):
    def post(self):
        json_data = request.get_json()

        try:
            id = json_data['id']
            name = json_data['name']
            email = json_data['email']
            phone_number = json_data['phone_number']
            dept_id = json_data['dept_id']
            a_year = json_data['admitted_year']
        except(Exception):
            return {'error': 'need all the data'}, 400

        status = insert_student_procedure(id, name, email, phone_number, dept_id, a_year)
        if status == "success":
            return {'msg': 'student insertion successful'}, 200
        else:
            return {'error': status}, 422


class StudentSearchByName(Resource):
    """url: /faculty/search/<string:name>"""

    def get(self, name):
        result = search_student_by_name(name)

        return {'response': result}


class StudentSearchByEmail(Resource):

    def get(self, email):
        result = search_student_by_email(email)
        return {'response': result}


class StudentSearchByPhone(Resource):

    def get(self, phone):
        result = search_student_by_phone(phone)
        return {'response': result}


class StudentFacultySearchById(Resource):

    def get(self, id):
        result = search_student_by_id(id)
        return {'response': result}
