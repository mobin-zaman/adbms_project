from cx_Oracle import DatabaseError

from database.db import get_connection, error_message, dict_mapper


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


def search_faculty(name):
    conn = get_connection()

    with conn.cursor() as cursor:
        cursor.execute('select * from faculty where upper(name) like upper(:name)', {
            'name': '%' + name + '%'})  # needed for capitalizing names, or else search doesn't weork
        result = dict_mapper(cursor)
        return result