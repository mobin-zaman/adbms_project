import cx_Oracle
from cx_Oracle import DatabaseError


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

        return result_dict
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


def dict_mapper_many(cursor):
    pass


def search_faculty(name):
    conn = get_connection()

    with conn.cursor() as cursor:
        cursor.execute('select * from faculty where upper(name) like upper(:name)', {
            'name': '%' + name + '%'})  # needed for capitalizing names, or else search doesn't weork
        result = dict_mapper(cursor)
        return result


def select_query(sql):
    conn = get_connection()
    with conn.cursor() as cursor:
        result = cursor.execute(sql)
        result = dict_mapper(cursor)
    return result


def select_many_query(sql):
    conn = get_connection()

    with conn.cursor() as cursor:
        cursor.execute(sql)
        meta = cursor.description
        rows = cursor.fetchmany()  # rows already has the meta

    return meta, rows

    # result=c.execute("")

    # print('c',result)
    # row=list()
    # for r in c:
    # 	print(r)
    # 	row.append(r)


def error_message(message):
    return message.split("\n")[0].split(":")[1]


def insert_faculty_procedure(id, name, email, phone_number, did):
    conn = get_connection()
    with conn.cursor() as cursor:
        try:
            cursor.callproc('faculty_package.insert_faculty', [id, name, email, phone_number, did])
            conn.commit()  # connection.commit() is must for committing the change in the database
            return "success"
        except DatabaseError as err:
            error_obj, = err.args
            print("error CODE: ", error_obj.code)
            print("error MESSAGE: ", error_obj.message.split("\n")[0])
            return error_message(error_obj.message)


def function_call(params_list):  # FIXME: need to change the name of the function, also fix it in the login resoruce
    conn = get_connection()
    with conn.cursor() as cursor:
        function_return = cursor.callfunc('admin_login', int, params_list)
    return function_return
