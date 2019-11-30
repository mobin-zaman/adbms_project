from flask_restful import Resource
from flask import request
from database.db import function_call


class LoginResource(Resource):

    def post(self):
        json_request = request.get_json()
        print(json_request)
        print(request)
        params_list = [json_request['username'], json_request['password']]

        result = function_call(params_list)

        print(result)

        if result == 0:
            return {'error': 'username and password invalid'},401

        else:
            return {'msg': 'login success'},200
