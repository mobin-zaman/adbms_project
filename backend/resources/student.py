import json
from flask_restful import Resource
from database.db import select_many_query
from database.student_methods import *
from flask import request


class StudentListResource(Resource):
    def get(self):
        result = select_many_query("select * from STUDENT_INFORMATION_VIEW")
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
    def get(self, name):
        result = search_student(name)
        return result
