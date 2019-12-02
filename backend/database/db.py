import cx_Oracle


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


def function_call(params_list):
    conn = get_connection()
    with conn.cursor() as cursor:
        function_return = cursor.callfunc('admin_login', int, params_list)
    return function_return
