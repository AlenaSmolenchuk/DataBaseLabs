import sys

sys.path.append('tables')

from pr_config import *
from tables.room_table import *
from tables.rack_table import *


class Main:
    config = ProjectConfig()
    connection = DbConnection(config)

    def __init__(self):
        DbTable.dbconn = self.connection
        return

    def db_init(self):
        pt = RoomsTable()
        pht = RackTable()
        pt.create()
        pht.create()
        return

    def db_insert_somethings(self):
        pt = RoomsTable()
        pht = RackTable()
        pt.insert_one([7, "RoomTest", 80, 3.0, 20.0, 30.0, 73.0])
        pt.insert_one([8, "RoomTestBig", 40, 3.0, 6.0, 20.0, 63.0])
        pt.insert_one([9, "RoomTestEliteBig", 43, 3.0, 45.0, 15.0, 53.0])
        pht.insert_one([13, 11, 5, 7, 540.0])
        pht.insert_one([14, 1, 5, 7, 490.0])
        pht.insert_one([15, 1, 6, 7, 140.0])

    def db_drop(self):
        pht = RackTable()
        pt = RoomsTable()
        pht.drop()
        pt.drop()
        return

    def show_main_menu(self):
        menu = """Добро пожаловать! 
Основное меню (выберите цифру в соответствии с необходимым действием): 
    1 - просмотр комнат;
    2 - сброс и инициализация таблиц;
    9 - выход."""
        print(menu)
        return

    def read_next_step(self):
        return input("=> ").strip()

    def after_main_menu(self, next_step):
        if next_step == "2":
            self.db_drop()
            self.db_init()
            self.db_insert_somethings()
            print("Таблицы созданы заново!")
            return "0"
        elif next_step != "1" and next_step != "9":
            print("Выбрано неверное число! Повторите ввод!")
            return "0"
        else:
            return next_step

    def show_rooms(self):
        self.id_room = -1  ##почему!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
        menu = """Просмотр списка комнат!
Название\tИспользуемая площадь\tМинимальная температура\tМаксимальная температура\tМинимальная влажность\tМаксимальная влажность"""
        print(menu)
        lst = RoomsTable().all()
        for i in lst:
            print(str(i[1]) + "\t" + str(i[2]) + "\t" + str(i[3]) + "\t" + str(i[4]) + "\t" + str(i[5]) + "\t" + str(
                i[6]))
        menu = """Дальнейшие операции: 
    0 - возврат в главное меню;
    3 - добавление новой комнаты;
    4 - удаление комнаты;
    5 - просмотр стеллажей комнаты;
    9 - выход."""
        print(menu)
        return

    def after_show_rooms(self, next_step):
        while True:
            if next_step == "4":
                pt = RoomsTable()
                inp = input('Введите имя комнаты которую хотите удалить: ').strip()
                pt.delete_by_name_room(inp)
                return "1"
            elif next_step == "6":  ##удаление и добавление стеллажей
                next_step = self.show_add_rack()
            elif next_step == "7":
                l = RackTable()
                inp = int(input('Введите номер стеллажа который хотите удалить: ').strip())
                l.delete_rack(inp)
                return "1"
            elif next_step == "5":
                next_step = self.show_racks_by_rooms()
            elif next_step != "0" and next_step != "9" and next_step != "3":
                print("Выбрано неверное число! Повторите ввод!")
                return "1"
            else:
                return next_step

    def show_add_rack(self):
        data = ["0"] * 4
        # while True:

        # while len(data[0].strip()) == 0:
        #     data[0] = input("id не может быть пустым! Введите id заново (1 - отмена):").strip()
        # if data[0] == "1":
        #     return "0"
        # rack_table = RackTable()
        # print(rack_table.exists(data[0]))
        # if rack_table.exists(data[0]) is not None:
        #     print("Стеллаж с таким id уже существует!")
        # else:
        #     break

        data[0] = (input("Введите максимальную нагрузку (1 - отмена): ").strip())
        if data[0] == "1":
            return
        while len(data[0].strip()) == 0:
            data[0] = input(
                "Максимальная нагрузка не может быть пустой! Введите макс. нагрузку заново (1 - отмена):").strip()
            if data[0] == "1":
                return

        data[1] = (input("Введите номер (1 - отмена): ").strip())
        if data[1] == "1":
            return "1"
        while len(data[1].strip()) == 0:
            data[1] = input("Номер не может быть пустым! Введите номер заново (1 - отмена):").strip()
            if data[1] == "1":
                return "1"

        data[2] = (input("Введите количество мест (1 - отмена): ").strip())
        if data[2] == "1":
            return "1"
        while len(data[2].strip()) == 0:
            data[2] = input("Количество мест не может быть пустым! Введите кол-во мест заново (1 - отмена):").strip()
            if data[2] == "1":
                return "1"

        data[3] = (input("Введите id комнаты куда поместить стеллаж (1 - отмена): ").strip())
        if data[3] == "1":
            return "1"
        while len(data[3].strip()) == 0:
            data[3] = input("id не может быть пустым! Введите id заново (1 - отмена):").strip()
            if data[3] == "1":
                return "1"

        # RackTable().insert_one(data)
        print(data)
        RackTable().add_rack(data[0], data[1], data[2], data[3])
        return "0"

    def show_add_room(self):
        # Не реализована проверка на максимальную длину строк. Нужно доделать самостоятельно!
        data = ["0"] * 6
        while True:
            data[0] = input("Введите название (1 - отмена): ").strip()
            if data[0] == "1":
                return
            while len(data[0].strip()) == 0:
                data[0] = input("Название не может быть пустым! Введите название заново (1 - отмена):").strip()
                if data[0] == "1":
                    return
            if len(data[0]) > 63:
                print("Превышен лимит имени")
                continue
            break
        while True:
            data[1] = input("Введите используемую площадь (1 - отмена): ").strip()
            # print(len(data[1]))
            if data[1] == "1":
                return

            if data[1].isdigit() == 0:
                print("Введено не число!")
                continue

            if 0 < int(data[1]) and len(data[1]) > 9:
                print("Превышен лимит числа")
                continue
            break
        while True:
            data[2] = input("Введите минимальную температуру (1 - отмена): ").strip()
            if data[2] == "1":
                return
            while len(data[2].strip()) == 0:
                data[2] = input(
                    "Минимальная температура не может быть пустой! Введите минимальную температуру заново (1 - отмена):").strip()

            if data[2].isdigit() == 0:
                print("Введено не число!")
                continue

            if len(data[2]) > 9:
                print("Превышен лимит числа")
                continue
            break
        while True:
            data[3] = input("Введите максимальную температуру (1 - отмена): ").strip()
            if data[3] == "1":
                return
            while len(data[3].strip()) == 0:
                data[3] = input(
                    "Максимальная температура не может быть пустой! Введите максимальную температуру заново (1 - отмена):").strip()
                if data[3] == "1":
                    return

            if data[3].isdigit() == 0:
                print("Введено не число!")
                continue

            if len(data[3]) > 9:
                print("Превышен лимит числа")
                continue
            break

        while True:
            data[4] = input("Введите минимальную влажность (1 - отмена): ").strip()
            if data[4] == "1":
                return
            while len(data[4].strip()) == 0:
                data[4] = input(
                    "Минимальная влажность не может быть пустой! Введите минимальную влажность заново (1 - отмена):").strip()
                if data[4] == "1":
                    return
            if data[4].isdigit() == 0:
                print("Введено не число!")
                continue

            if 0 < int(data[4]) and len(data[4]) > 2:
                print("Превышен лимит числа")
                continue
            break
        while True:
            data[5] = input("Введите максимальную влажность (1 - отмена): ").strip()
            if data[5] == "1":
                return
            while len(data[5].strip()) == 0:
                data[5] = input(
                    "Максимальная влажность не может быть пустой! Введите максимальную влажность заново (1 - отмена):").strip()
                if data[5] == "1":
                    return
            if data[5].isdigit() == 0:
                print("Введено не число!")
                continue

            if 0 < int(data[5]) and len(data[5]) > 2:
                print("Превышен лимит числа")
                continue
            break

        RoomsTable().add_room(data[0], data[1], data[2], data[3], data[4], data[5])
        return

    def show_racks_by_rooms(self):
        if self.id_room == -1:
            while True:
                num = input("Укажите номер строки, в которой записана интересующая Вас комната (0 - отмена):")
                while len(num.strip()) == 0:
                    num = input(
                        "Пустая строка. Повторите ввод! Укажите номер строки, в которой записана интересующая Вас комната (0 - отмена):")
                if num == "0":
                    return "1"
                room = RoomsTable().find_by_position(int(num))
                print(room)
                if not room:
                    print("Введено число, неудовлетворяющее количеству комнат!")
                else:
                    self.id_room = room[0]
                    self.room_obj = room
                    break
        print(str(self.room_obj[2]))
        print("Выбрана комната: " + self.room_obj[1] + " " + str(self.room_obj[2]) +
              " " + str(self.room_obj[3]) + " " + str(self.room_obj[4]) + " " + str(self.room_obj[5]) + " " + str(
            self.room_obj[6]))
        menu = """Просмотр списка cтеллажей этой комнаты!
id\tМаксимальная нагрузка\tНомер\tКоличество мест\t"""
        print(menu)
        lst = RackTable().all_by_room_id(self.id_room)
        for i in lst:
            print(str(i[0]) + " " + str(i[1]) + " " + str(i[2]) + " " + str(i[3]))
        menu = """Дальнейшие операции:
    0 - возврат в главное меню;
    1 - возврат в просмотр комнат;
    6 - добавление нового стеллажа;
    7 - удаление стеллажа;
    9 - выход."""
        print(menu)
        return self.read_next_step()

    def main_cycle(self):
        current_menu = "0"
        next_step = None
        while (current_menu != "9"):
            if current_menu == "0":
                self.show_main_menu()
                next_step = self.read_next_step()
                current_menu = self.after_main_menu(next_step)
            elif current_menu == "1":
                self.show_rooms()
                next_step = self.read_next_step()
                current_menu = self.after_show_rooms(next_step)
            elif current_menu == "2":
                self.show_main_menu()
            elif current_menu == "3":
                self.show_add_room()
                current_menu = "1"
        print("До свидания!")
        return

    def test(self):
        DbTable.dbconn.test()


m = Main()
# Откоментируйте эту строку и закоментируйте следующую для теста
# соединения с БД
m.test()
m.main_cycle()
