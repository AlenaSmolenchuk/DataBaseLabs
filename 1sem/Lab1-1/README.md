Create a "Countries" table that contains the following fields: ID, name.
The name is a non–empty text field of arbitrary length (no more than 64 characters).
The identifier is not an empty integer, by the value of which you can determine the values
of all other fields in the table.

Create a table "Exhibits", which contains the following fields: ID,
name, collection, year of creation, technique, insurance value,
country identifier. Title, collection, technique of execution – text not empty fields, arbitrary (not
more than 2000 characters) in length. The name field is unique. The identifier is not an empty string
with a length of no more than 32 characters, by the value of which you can determine the values of all
other fields in the table. The year of creation is positive integers consisting of no more
than 4 digits and greater than 1900. The insurance value is not an empty field that stores
a real number consisting of no more than eight digits before the decimal point and two digits after
the decimal point. The default value of the insurance value field is 20,000. Country ID – not
an empty integer that can accept only the values available among the rows
of the "Countries" table in the "identifier" field.
