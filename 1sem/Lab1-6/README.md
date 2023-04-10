# Task 1

a) Write a query using the WITH construct that selects
recursively an employee with ID 6 and all his supervisors,
both direct and higher rank*.
b) Write a program in PL/SQL that prints on the screen the name
and surname of the employee with the identifier 6 and all his supervisors, both
direct and higher rank.

# Task 2

Write a program in PL/SQL that selects using
cursor all rows from the employees table in ascending
order of the unit id and salary (salary) and printing on
the screen contains the following data: last name, first name, modified
phone number. The modified phone number is obtained
as follows: the phrase "Ext. X" is added to the end of the employee's phone number,
where X is replaced by the employee's number in the department in order.
# Task 3

Write a program in PL/SQL that replaces all employees who
are fourth and older in a row (if sorted by
boss ID and salary) with subordinates of their
boss (except subordinates to the boss with ID 1)
the ID of the boss to the ID of the boss of their boss.

# Task 4

Create a spiral table with 5 fields f1, f2, f3, f4, f5 – integers.
Write a program in PL/SQL that fills this table with 1000
rows according to the following principle:

1 3 5 7 9

2 4 6 8 10

20 18 16 14 12

19 17 15 13 11

21 23 25 27 29

…
