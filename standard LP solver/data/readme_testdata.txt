Test data for LP

try the following code in Matlab:

load('test_student.mat')

The file contains: A, b, and c 
for the LP problem:
min <c,x>
s.t.  Ax = b,  x>= 0

The obj should be 23.393946994083368 (this value is obtained by using linprog on my computer.).
You could also check this value using the builtin function linprog.
The obj value you obtained might not be exactly the same with the above value (there might be a small deviation).

It should not be difficult task for reading this data using python.
