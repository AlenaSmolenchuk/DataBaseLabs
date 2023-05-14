from dbtable import *

class RoomsTable(DbTable):
    def table_name(self):
        return self.dbconn.prefix + "Rooms"

    def columns(self):
        return {"id_room": ["integer", "NOT NULL", "PRIMARY KEY"],
                "name": ["varchar(64)", "NOT NULL"],
                "use_volume": ["integer"],
                "temp_min": ["numeric", "NOT NULL"],
                "temp_max": ["numeric", "NOT NULL"],
                "wet_min": ["numeric", "NOT NULL"],
                "wet_max": ["numeric", "NOT NULL"]}

    def find_by_position(self, num):
        sql = "SELECT * FROM " + self.table_name()
        sql += " ORDER BY "
        sql += ", ".join(self.primary_key())
        sql += " LIMIT 1 OFFSET %(offset)s"
        cur = self.dbconn.conn.cursor()
        cur.execute(sql, {"offset": num - 1})
        return cur.fetchone()

    def delete_by_id(self, id):
        sql = "DELETE FROM " + self.table_name() + " WHERE id_room = %s"
        cur = self.dbconn.conn.cursor()
        cur.execute(sql, (id,))
        self.dbconn.conn.commit()


    
