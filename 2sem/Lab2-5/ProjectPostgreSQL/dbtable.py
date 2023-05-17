# Базовые действия с таблицами

from db_conect import *


class DbTable:
    dbconn = None

    def __init__(self):
        return

    def table_name(self):
        return self.dbconn.prefix + "table"

    def columns(self):
        return {"test": ["integer", "PRIMARY KEY"]}

    def column_names(self):
        return sorted(self.columns().keys(), key=lambda x: x)

    def primary_key(self):
        return ['id']

    def column_names_without_id(self):
        res = sorted(self.columns().keys(), key=lambda x: x)
        if 'id' in res:
            res.remove('id')
        return res

    def table_constraints(self):
        return []

    def create(self):
        sql = "CREATE TABLE " + self.table_name() + "("
        arr = [k + " " + " ".join(v) for k, v in sorted(self.columns().items(), key=lambda x: x[0])]
        sql += ", ".join(arr + self.table_constraints())
        sql += ")"
        cur = self.dbconn.conn.cursor()
        cur.execute(sql)
        self.dbconn.conn.commit()
        return


    def drop(self):
        sql = "DROP TABLE IF EXISTS " + self.table_name() + " CASCADE"
        cur = self.dbconn.conn.cursor()
        cur.execute(sql)
        self.dbconn.conn.commit()
        return

    def insert_one(self, vals):
        for i in range(0, len(vals)):
            if type(vals[i]) == str:
                vals[i] = "'" + vals[i] + "'"
            else:
                vals[i] = str(vals[i])
        sql = "INSERT INTO " + self.table_name()
        sql += " VALUES("
        sql += ", ".join(vals) + ")"
        cur = self.dbconn.conn.cursor()
        print(sql)
        cur.execute(sql)
        self.dbconn.conn.commit()
        return

    def first(self):
        sql = "SELECT * FROM " + self.table_name()
        sql += " ORDER BY "
        sql += ", ".join(self.primary_key())
        cur = self.dbconn.conn.cursor()
        cur.execute(sql)
        return cur.fetchone()

    def last(self):
        sql = "SELECT * FROM " + self.table_name()
        sql += " ORDER BY "
        sql += ", ".join([x + " DESC" for x in self.primary_key()])
        cur = self.dbconn.conn.cursor()
        cur.execute(sql)
        return cur.fetchone()

    def all(self):
        sql = "SELECT * FROM " + self.table_name()
        sql += " ORDER BY "
        sql += ", ".join(self.primary_key())
        cur = self.dbconn.conn.cursor()
        cur.execute(sql)
        return cur.fetchall()

    def delete_by_id_room(self, id):
        sql = "DELETE FROM " + self.table_name() + " WHERE id_room = %s"
        cur = self.dbconn.conn.cursor()
        cur.execute(sql, (id,))
        self.dbconn.conn.commit()

    # def add_rack(self, room_id, number, quantity, max_load):
    #     sql = "INSERT INTO " + self.table_name() + " "
    #     sql += "(" + ", ".join(self.columns().keys()) + ") "
    #     sql += "VALUES (" + ", ".join(["%s"] * len(self.columns())) + ")"
    #     cur = self.dbconn.conn.cursor()
    #     cur.execute(sql, (None, number, quantity, room_id, max_load))
    #     self.dbconn.conn.commit()
    #     return cur.lastrowid


    def delete_rack_id(self, rack_id):
        sql = "DELETE FROM " + self.table_name() + " WHERE id_rack = %s"
        cur = self.dbconn.conn.cursor()
        cur.execute(sql, str(rack_id))
        self.dbconn.conn.commit()
