import cx_Oracle
from cx_Oracle import DatabaseError



def get_connection():
    dsn_tns = cx_Oracle.makedsn('localhost', '1521', service_name=r'XE')
    conn = cx_Oracle.connect(user='scott', password='password', dsn=dsn_tns)
    return conn


def select_query(sql):
    conn = get_connection()
    with conn.cursor() as cursor:
        result = cursor.execute(sql)
    return result;


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

def insert_faculty_procedure(name, email, phone_number, did):
    conn = get_connection()
    with conn.cursor() as cursor:
        try:
            cursor.callproc('faculty_package.insert_faculty', [name, email, phone_number, did])
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
