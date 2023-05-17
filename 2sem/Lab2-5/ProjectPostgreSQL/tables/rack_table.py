# таблица Rack и особые действия с ней.

from ProjectPostgreSQL.ProjectPostgreSQL.dbtable import *


class RackTable(DbTable):
    def table_name(self):
        return self.dbconn.prefix + "\"Rack\""

    def columns(self):
        return {"id_rack": ["integer", "NOT NULL", "PRIMARY KEY"],
                "max_load": ["numeric", "NOT NULL"],
                "number": ["integer", "NOT NULL"],
                "quantity": ["integer", "NOT NULL"],
                "room_id": ["integer"]
                }

    def primary_key(self):
        return ['id_rack']

    def all_by_room_id(self, id_room):
        sql = "SELECT * FROM " + self.table_name()
        sql += " WHERE room_id =%(id)s"
        sql += " ORDER BY " + ", ".join(self.primary_key())
        # print(sql)
        cur = self.dbconn.conn.cursor()
        cur.execute(sql, {"id": str(id_room)})
        # self.show_racks_by_rooms()
        return cur.fetchall()

    def sequence_r(self):
        sql = "CREATE SEQUENCE rack_id_seq"
        return sql

    def create(self):
        sql = "CREATE TABLE " + self.table_name() + "("
        arr = [k + " " + " ".join(v) for k, v in sorted(self.columns().items(), key=lambda x: x[0])]
        sql += ", ".join(arr + self.table_constraints())
        sql += ")"
        cur = self.dbconn.conn.cursor()
        cur.execute(sql)
        # cur.execute(self.sequence_r())
        self.dbconn.conn.commit()
        return

    def add_rack(self, max_load, number, quantity, room_id):
        sql = "INSERT INTO " + self.table_name() + " "
        sql += "(" + ", ".join(self.columns().keys()) + ") "
        # sql += "VALUES (" + ", ".join(["%s"] * len(self.columns())) + ")"
        sql += "VALUES (nextval('rack_id_seq'), %(max_load)s, %(number)s, %(quantity)s, %(room_id)s)"
        cur = self.dbconn.conn.cursor()
        print(sql)
        cur.execute(sql, {"max_load":max_load,"number":number,"quantity":quantity,"room_id":room_id})
        self.dbconn.conn.commit()
        # return cur.lastrowid

    def delete_rack(self, rack_id):
        sql = "DELETE FROM " + self.table_name() + " WHERE id_rack = %s"
        cur = self.dbconn.conn.cursor()
        cur.execute(sql, str(rack_id))
        self.dbconn.conn.commit()

    def exists(self, id_rack):
        sql = "SELECT * FROM " + self.table_name()
        sql += " WHERE id_rack =%(id)s"
        cur = self.dbconn.conn.cursor()
        cur.execute(sql, {"id": str(id_rack)})
        return cur.fetchone()
