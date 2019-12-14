from flask_restful import Resource
from database.db import select_query


class ProjectListResource(Resource):
    def get(self):
        result = select_query("select * from PROJECT_INFORMATION_VIEW")
        return {'response':result}, 200
