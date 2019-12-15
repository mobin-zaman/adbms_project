from cx_Oracle import DatabaseError
from .db import get_connection, error_message, dict_mapper


def insert_student_procedure(id, name, email, phone_number, did, a_year):
    conn = get_connection()
    with conn.cursor() as cursor:
        try:
            cursor.callproc('student_package.insert_student', [id, name, email, phone_number, did, a_year])
            conn.commit()  # connection.commit() is must for committing the change in the database
            return "success"
        except DatabaseError as err:
            error_obj, = err.args
            print("error CODE: ", error_obj.code)
            print("error MESSAGE: ", error_obj.message.split("\n")[0])
            return error_message(error_obj.message)


def search_student(name):
    conn = get_connection()

    with conn.cursor() as cursor:
        cursor.execute('select * from student where upper(name) like upper(:name)', {
            'name': '%' + name + '%'})  # needed for capitalizing names, or else search doesn't work
        result = dict_mapper(cursor)
        return result


