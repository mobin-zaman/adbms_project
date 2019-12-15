import cx_Oracle


def get_connection():
    dsn_tns = cx_Oracle.makedsn('localhost', '1521', service_name=r'XE')
    conn = cx_Oracle.connect(user='scott', password='password', dsn=dsn_tns)
    return conn


def dict_mapper(cursor):
    metas = cursor.description
    rows = cursor.fetchall()

    print("rows: ", rows)
    print("meta: ", metas)

    if len(rows) == 0:
        return {'msg': 'no result found'}

    print("length: ", len(rows))

    if len(rows) == 1:
        result_dict = {}
        for row in rows:
            for each_meta, row in zip(metas,row):
                result_dict[each_meta[0]]=row

        return [result_dict]
    else:
        result_list = []
        result_dict = {}

        for row in rows:
            for each_row, meta in zip(row, metas):
                print("====> ", each_row)
                result_dict[meta[0]] = each_row
                print(meta[0], each_row)
                if row.index(each_row) == (len(row) - 1):
                    result_list.append(result_dict)
                    result_dict = {}

        return result_list



def select_query(sql):
    conn = get_connection()
    with conn.cursor() as cursor:
        result = cursor.execute(sql)
        result = dict_mapper(cursor)
    return result

"""
def select_many_query(sql):
    conn = get_connection()

    with conn.cursor() as cursor:

        result = cursor.execute(sql)
        result = dict_mapper(cursor)

    return result

"""

def error_message(message):
    return message.split("\n")[0].split(":")[1]


def function_call(params_list):  # FIXME: need to change the name of the function, also fix it in the login resoruce
    conn = get_connection()
    with conn.cursor() as cursor:
        function_return = cursor.callfunc('admin_login', int, params_list)
    return function_return
