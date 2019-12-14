from flask_restful import Resource
from database.db import select_query


class ThesisListResource(Resource):
    def get(self):
        result = select_query("select * from THESIS_INFORMATION_VIEW")
        return {'response':result}
