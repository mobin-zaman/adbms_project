from flask_restful import Resource
from database.db import select_query
from flask import request
from database.db import select_query, insert_query
from database.project_methods import search_project_by_id, search_project_by_name


class ProjectListResource(Resource):
    def get(self):
        result = select_query("select * from PROJECT_INFORMATION_VIEW")
        return {'response': result}, 200


class ProjectInsertResource(Resource):
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

        sql = """insert into project(name ,description) values( {0}, {1} )""".format("'" + name + "'",
                                                                                     "'" + description + "'")

        insert_query(sql)

        sql = """select id from project where name = {0} and description = {1}""".format("'" + name + "'",
                                                                                         "'" + description + "'")

        result = select_query(sql)

        project_id = result[0]['ID']

        sql = """select max(id) as ID from FACULTY_PROJECT"""

        result = select_query(sql)

        id = result[0]['ID'] + 1

        sql = """insert into FACULTY_PROJECT values({0}, {1}, {2})""".format(id, project_id, faculty_id)

        insert_query(sql)

        return {'msg': 'project inserted'}, 200


class ProjectSearchByName(Resource):
    """url: /faculty/search/<string:name>"""

    def get(self, name):
        result = search_project_by_name(name)

        print(result)

        return {'response': result}


class ProjectSearchById(Resource):

    def get(self, id):
        result = search_project_by_id(id)

        print(result)

        return {'response': result}
