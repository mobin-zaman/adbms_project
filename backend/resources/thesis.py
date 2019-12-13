from flask_restful import Resource
from database.db import select_many_query


class ThesisListResource(Resource):
    def get(self):
        result = select_many_query("select * from THESIS_INFORMATION_VIEW")
        return {'response':result}
