from cx_Oracle import DatabaseError

from database.db import get_connection, error_message, dict_mapper


def search_project_by_id(id):
    conn = get_connection()

    with conn.cursor() as cursor:
        cursor.execute('select * from project where id = :id', {'id': id})
        result = dict_mapper(cursor)

        return result


def search_project_by_name(name):
    conn = get_connection()

    with conn.cursor() as cursor:
        cursor.execute('select * from project where upper(NAME) like upper(:name)', {
            'name': '%' + name + '%'})

        result = dict_mapper(cursor)

        return result


