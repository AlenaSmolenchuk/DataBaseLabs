from dbtable import *

class RackTable(DbTable):
    def table_name(self):
        return self.dbconn.prefix + "Rack"

    def columns(self):
        return {"id_rack": ["integer", "NOT NULL", "PRIMERY KEY"],
                "number": ["integer", "NOT NULL"],
                "quantity": ["integer", "NOT NULL"],
                "room_id": ["integer"],
                "max_load": ["numeric", "NOT NULL"]}

    def all_by_room_id(self, room_id):
        sql = "SELECT * FROM " + self.table_name()
        sql += " WHERE room_id = %s"
        sql += " ORDER BY " + ", ".join(self.primary_key())
        cur = self.dbconn.conn.cursor()
        cur.execute(sql, str(room_id))
        return cur.fetchall()

    def add_rack(self, room_id, number, quantity, max_load):
        sql = "INSERT INTO " + self.table_name() + " "
        sql += "(" + ", ".join(self.columns().keys()) + ") "
        sql += "VALUES (" + ", ".join(["%s"] * len(self.columns())) + ")"
        cur = self.dbconn.conn.cursor()
        cur.execute(sql, (None, number, quantity, room_id, max_load))
        self.dbconn.conn.commit()
        return cur.lastrowid


    def delete_rack(self, rack_id):
        sql = "DELETE FROM " + self.table_name() + " WHERE id_rack = %s"
        cur = self.dbconn.conn.cursor()
        cur.execute(sql, str(rack_id))
        self.dbconn.conn.commit()



