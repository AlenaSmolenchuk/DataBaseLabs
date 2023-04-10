# Task 1

• Create two tables: operations and operations_log. The first table
should contain the fields identifier (id), account number
(account_number), operation name (operation_name), operation amount
(operation_sum). The id field is the primary key. The operation_sum field is
a real number. The second table should contain the following fields:
operation ID (operation_id), account number (account_number)
, date of operation (operation_date), type of operation (operation_type). Field
operation_date should allow you to save the date and time. Field
operation_type can contain only two values ‘-‘, ‘+’. Fill
the operations and operations_log tables with several records (at least 5
per table).

# Task 2

• Write a procedure or function statement_of_acount, which
, based on three parameters: the start date of the period, the end date of the period
and the account number, would print data on the screen (type of operation, amount,
date of operation) of the three largest operations with a positive
amount, the three largest operations with a negative amount and
data on the total number of operations and the average the value of the amount.

# Task 3

• Write an account_operation procedure or function that
makes changes to the operations table based on three parameters: account number, ID, and amount
. An
entry should be added to the operations table, where the fields ID, account number and
transaction amount should be filled in with the passed parameters. 
The operation name field is filled in with the phrase "depositing money to the account". If
the amount is negative or zero, nothing should be deposited.
