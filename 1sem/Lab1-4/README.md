# Task 1

Create a deps table with three fields:
 id – an integer that is the primary key;
 name is not an empty string, the length of which does not exceed 64 characters;
 region is not an empty string, the length of which does not exceed 64 characters.

# Task 2

Create the deps_id_seq sequence so that it:
 started with the number 1;
 was cyclical;
 generated numbers in ascending order in increments of 4;
 did not support caching.

# Task 3

Write a query that adds one new row to the deps table,
filled in as follows:
 the following element of the deps_id_seq sequence is written
in the id field;
 'Direction' is written in the name field;
 'Mars' is written in the region field.

# Task 4

Write a query that adds as many new rows to the deps table as
there are in the departments table. Each added line is filled in according
to the following principle:
 the following element of the deps_id_seq sequence is written
in the id field;
 the value of the department_name field of the departments table is written in the name field
;
 the first two letters of the region name are written in the region field,
corresponding to this department (the region_name field of the regions table).
# Task 5

Write a query replacing in the deps table the value of the region field of all
lines of the department 'Sales' with 'Europe'.

# Task 6

Write a query that deletes all records in the deps table
that have an even id field value.

# Task 7 – transferred to laboratory work 5

Create a region_deps_counts view based on the deps table
containing the following fields:
 region – the name of the region from the deps table;
 dcount – the number of departments in this region in the deps table.

# Task 8

By the specified employee ID, display all of them on the screen
managers, including indirect managers at any level
(managers through managers).
