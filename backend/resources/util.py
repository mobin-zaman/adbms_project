from database.db import select_many_query


def get_json_dict(sql):
    result = select_many_query(sql)
    meta, rows = result[0], result[1]

    json_dict = {
        "column_names": [x[0] for x in meta],
        "fields": [list(x) for x in rows]
    }

    return json_dict



