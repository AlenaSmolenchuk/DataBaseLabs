# Task 1
Create a staff table containing the following fields: 
id (id),
last_name (surname),
first_name (first name),
second_name (patronymic),
sex (gender),
birthday (date of birth),
post (position),
department (department),
head_id (boss ID).
The id field is intended for storing a number of the maximum allowable length. It is the key of the table. The last_name, first_name and second_name fields are 64 bytes long text fields. The first two of them cannot be empty. The gender field is designed to store a single character, cannot be empty, and allows only the values "m" and "f". The post and department fields are 128 bytes long text fields. Their values cannot be empty and must form unique pairs. The birthday field is intended for storing the date and cannot be empty. The head_id field belongs to the same data type as the id field. It is also a foreign key referring to the id field of the same staff table.

# Task 2
Create an increasing sequence of staff_id_seq.
Fill in the staff table with 5 rows so that the new generated sequence number is placed in the id field, and the values of the remaining fields are as follows:
null; id field value for row 1; id field value for row 2; id field value for row 2; id field value for row 2;

# Task 3
Write a query that selects from the table the surname, first name, patronymic, position of each person, as well as the surname, first name, patronymic and position of their direct subordinates:

# Task 4
Write a query replacing the values of the head_id fields for rows without subordinates with the value of the id field of the first row.

# Task 5
Write a procedure in PL/SQL language birthday_boys(month) that prints by month number (from 1 to 12) all the people from the staff table who have a birthday this month. In addition, the procedure should print their total number, maximum, minimum and average age.

# Task 6
Write a query using the with construct that finds the length of the longest chain of the supervisor-subordinate.
