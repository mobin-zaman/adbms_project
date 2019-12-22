from flask_restful import Resource
from flask import request
from database.db import select_query, insert_query


class ThesisListResource(Resource):
    def get(self):
        result = select_query("select * from THESIS_INFORMATION_VIEW")
        return {'response': result}


class ThesisInsertResource(Resource):
    def post(self):
        json_data = request.get_json()

        try:
            name = json_data['name']  # id is not necessary for the trigger
            description = json_data['description']
            supervisor = json_data['supervisor']
        except Exception:
            return {'error': 'need all the data'}, 400

        sql = """select id from faculty where UPPER(name) = UPPER({0})""".format("'" + supervisor + "'")
        result = select_query(sql)

        try:
            faculty_id = result[0]['ID']
            print("FACULTY ID", faculty_id)
        except KeyError:
            return {'error': "teacher does not exist"}, 400

        sql = """insert into thesis(name ,description) values( {0}, {1} )""".format("'" + name + "'",
                                                                                    "'" + description + "'")

        insert_query(sql)

        sql = """select id from thesis name = {0} and description = {1}""".format("'" + name + "'",
                                                                                          "'" + description + "'")

        result = select_query(sql)

        project_id = result[0]['ID']

        sql = """select max(id) as ID from FACULTY_THESIS"""

        result = select_query(sql)

        id = result[0]['ID'] + 1

        sql = """insert into FACULTY_THESIS values({0}, {1}, {2})""".format(id, project_id, faculty_id)

        insert_query(sql)

        return {'msg': 'thesis inserted'}, 200
