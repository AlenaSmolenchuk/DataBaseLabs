# таблица Rooms и особые действия с ней.

from ProjectPostgreSQL.ProjectPostgreSQL.dbtable import *


class RoomsTable(DbTable):
    def table_name(self):
        return self.dbconn.prefix + "\"Rooms\""

    def columns(self):
        return {"id_room": ["integer", "NOT NULL", "PRIMARY KEY"],
                "name": ["varchar(64)", "NOT NULL"],
                "use_volume": ["integer"],
                "temp_min": ["numeric", "NOT NULL"],
                "temp_max": ["numeric", "NOT NULL"],
                "wet_min": ["numeric", "NOT NULL"],
                "wet_max": ["numeric", "NOT NULL"]}

    def primary_key(self):
        return ['id_room']

    def find_by_position(self, num):
        sql = "SELECT * FROM " + self.table_name()
        sql += " ORDER BY "
        sql += ", ".join(self.primary_key())
        sql += " LIMIT 1 OFFSET %(offset)s"
        print(sql)
        cur = self.dbconn.conn.cursor()
        cur.execute(sql, {"offset": int(num) - 1})
        return cur.fetchone()

    def delete_by_name_room(self, name):
        sql = "DELETE FROM " + self.table_name()
        sql += f" WHERE name =%(off)s"
        print(sql)
        cur = self.dbconn.conn.cursor()
        cur.execute(sql, {"off": name})
        self.dbconn.conn.commit()
        # self.show_rooms()

    def add_room(self, name, use_volume, temp_min, temp_max, wet_min, wet_max):
        sql = "INSERT INTO " + self.table_name() + " "
        sql += "(" + ", ".join(self.columns().keys()) + ") "
        # sql += "VALUES (" + ", ".join(["%s"] * len(self.columns())) + ")"
        sql += "VALUES (nextval('room_id_seq'), %(name)s, %(use_volume)s, %(temp_min)s, %(temp_max)s, %(wet_min)s, " \
               "%(wet_max)s) "
        cur = self.dbconn.conn.cursor()
        print(sql)
        cur.execute(sql, {"name": name, "use_volume": use_volume, "temp_min": temp_min, "temp_max": temp_max,
                          "wet_min": wet_min, "wet_max": wet_max})
        self.dbconn.conn.commit()
        # return cur.lastrowid

    def sequence(self):
        sql = "CREATE SEQUENCE room_id_seq"
        return sql

    def create(self):
        sql = "CREATE TABLE " + self.table_name() + "("
        arr = [k + " " + " ".join(v) for k, v in sorted(self.columns().items(), key=lambda x: x[0])]
        sql += ", ".join(arr + self.table_constraints())
        sql += ")"
        cur = self.dbconn.conn.cursor()
        cur.execute(sql)
        # cur.execute(self.sequence())
        self.dbconn.conn.commit()
        return
