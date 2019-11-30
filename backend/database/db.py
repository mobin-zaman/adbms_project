import cx_Oracle


def get_cursor():
    dsn_tns = cx_Oracle.makedsn('localhost', '1521', service_name=r'XE')
    conn = cx_Oracle.connect(user='scott', password='password', dsn=dsn_tns)
    return conn.cursor()


def select_query():
    pass


# result=c.execute("")

# print('c',result)
# row=list()
# for r in c:
# 	print(r)
# 	row.append(r)

def function_call(params_list):
    cursor = get_cursor()
    function_return = cursor.callfunc('admin_login', int, params_list)
    return function_return