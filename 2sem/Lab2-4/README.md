# The general part of the tasks:

 * For the developed database, create a trigger that controls
the condition specified in task 0 of your variant.
* For the developed database, write a function that calculates
the information specified in task 1 of your option.
* For the developed database, write an aggregate function
that calculates the information specified in task 2 of your option.
* For the developed database, create a view and a trigger
that implement the condition specified in task 3 of your option.
* Solve the problem specified in paragraph 4 of your option.

# Tasks:

0. The trigger does not allow you to add more goods to the rack than
the number of places in it and does not allow you to change its maximum
load to a value less than the total weight of all the goods stored on
it.

1. By the specified name of the client and the date, calculates the number of goods
stored in the warehouse and owned by this client, the term
of the contract of which expires before this date.

2. For a set of rows containing the length, width and height
of the goods stored in the warehouse, calculate the maximum dimensions
of the space necessary to fit any of the stored
products, and present them as a single line in the format "height X
width X length".

3. Create a view that displays descriptions of customers (and
key fields of the customers table) and their products. Implement
the possibility of changing the description of customers through this representation in
a real table.

4. Using a table and a set of procedures (or functions), implement
the "Unidirectional Queue" data representation structure.
The structure should allow storing lines in the queue, no longer
than 64 characters. Enqueue actions must be available –
adding an element to the end of the queue, dequeue – removing an element from
the beginning of the queue, empty – clearing the queue, init – initializing
the queue, top – viewing the beginning of the queue, tail – viewing the end of the queue.
