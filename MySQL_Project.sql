CREATE DATABASE Library;
USE Library;
CREATE TABLE Branch(Branch_no INT PRIMARY KEY,Manager_Id INT,Branch_address VARCHAR(100),Contact_no int);
INSERT INTO Branch(Branch_no,Manager_Id,Branch_address,Contact_no) VALUES
(1,101,'Malappuram',22334455),
(2,102,'Calicut',33445566),
(3,103,'Thrissur',44556677),
(4,104,'Idukki',55667788),
(5,105,'Kollam',66778899);
SELECT * FROM Branch;

CREATE TABLE Employee(Emp_Id INT PRIMARY KEY,Emp_name VARCHAR(30),Position VARCHAR(30),Salary DECIMAL(10,2));
INSERT INTO Employee(Emp_Id,Emp_name,Position,Salary) VALUES
(101,'Prakash','Librarian',10000),
(102,'Vivek','Manager',25000),
(103,'Shilpa','Accountant',15000),
(104,'Preethi','Cashier',12000),
(105,'Vishnu','Security',8000);
-- Manager_Id from Branch table can be considered as Emp_Id in Employee table.
SELECT * FROM Employee;

CREATE TABLE Customer(Customer_Id INT PRIMARY KEY,Customer_name VARCHAR(30),Customer_address VARCHAR(100),Reg_Date DATE);
INSERT INTO Customer(Customer_Id,Customer_name,Customer_address,Reg_Date) VALUES
(1,'Varghese','123 Cross Road','2022-01-23'),
(2,'Rosa','245 Outer Ring Road','2022-05-14'),
(3,'Joshy','456 Main Road','2023-02-24'),
(4,'Joshma','789 Pipeline Road','2023-05-16'),
(5,'Raji','223 Garden Estate Road','2023-03-12');
SELECT * FROM Customer;

CREATE TABLE IssueStatus(Issue_Id INT PRIMARY KEY,Issued_cust INT,Issued_book_name VARCHAR(100),Issue_date DATE,ISBN_book VARCHAR(30),
FOREIGN KEY (Issued_cust) REFERENCES Customer(Customer_Id),FOREIGN KEY(ISBN_book) REFERENCES Books(ISBN));
INSERT INTO IssueStatus(Issue_Id,Issued_cust,Issued_book_name,Issue_date,ISBN_book) VALUES
(1,1,'Nilavelicham','2020-01-23','ISBN1'),
(2,2,'Khasakkinte Itihasam','2021-03-21','ISBN2'),
(3,3,'MAZHA PEYYUNNU MADDALAM KOTTUNNU','2023-02-04','ISBN3'),
(4,4,'VALLATHOLINTE BALAKAVITHAKAL','2022-05-06','ISBN4'),
(5,5,'Alices Adventures in Wonderland: Large Print','2021-06-15','ISBN5');
SELECT * FROM IssueStatus;

CREATE TABLE ReturnStatus(Return_Id INT PRIMARY KEY,Return_cust INT,Return_book_name VARCHAR(100),Return_date DATE,ISBN_book2 VARCHAR(30),
FOREIGN KEY (ISBN_book2) REFERENCES Books(ISBN));
INSERT INTO ReturnStatus(Return_Id,Return_cust,Return_book_name,Return_date,ISBN_book2) VALUES
(1,1,'Nilavelicham','2020-01-29','ISBN1'),
(2,2,'Khasakkinte Itihasam','2021-03-25','ISBN2'),
(3,3,'MAZHA PEYYUNNU MADDALAM KOTTUNNU','2023-02-15','ISBN3'),
(4,4,'VALLATHOLINTE BALAKAVITHAKAL','2022-05-24','ISBN4'),
(5,5,'Alices Adventures in Wonderland: Large Print','2021-06-21','ISBN5');
SELECT * FROM ReturnStatus;

CREATE TABLE Books(ISBN VARCHAR(30) PRIMARY KEY,Book_title VARCHAR(100),Category VARCHAR(50),Rental_Price DECIMAL(10,2),
Status enum('Yes','No'),Author VARCHAR(30),Publisher VARCHAR(50));
INSERT INTO Books(ISBN,Book_title,Category,Rental_Price,Status,Author,Publisher) VALUES
('ISBN1','Nilavelicham','Novel',10.99,'Yes','Vaikom Muhammad Basheer','Orient Longman'),
('ISBN2','Khasakkinte Itihasam','Novel',12.99,'No','O. V. Vijayan','DC Books'),
('ISBN3','MAZHA PEYYUNNU MADDALAM KOTTUNNU','Poetry',15.99,'Yes','Kadammanitta Ramakrishnan','DC Books'),
('ISBN4','VALLATHOLINTE BALAKAVITHAKAL','Poetry',19.99,'Yes','Vallathol Narayana Menon','DC Books'),
('ISBN5','Alices Adventures in Wonderland: Large ,Print','Childrens Novel',14.99,'No','Lewis Carroll','Macmillan');
SELECT * FROM Books;
-- The ENUM data type in MySQL is a string object. It allows us to limit the value chosen from a list of permitted values in the column specification at the time of table creation. It is short for enumeration, which means that each column may have one of the specified possible values.

-- 1. Retrieve the book title, category, and rental price of all available books.
SELECT Book_title,Category,Rental_Price FROM Books WHERE Status='Yes';

-- 2. List the employee names and their respective salaries in descending order of salary.
SELECT Emp_name,Salary FROM Employee ORDER BY Salary DESC;

-- 3. Retrieve the book titles and the corresponding customers who have issued those books. 
SELECT b.Book_title, c.Customer_name
FROM IssueStatus i
JOIN Books b ON i.ISBN_book = b.ISBN
JOIN Customer c ON i.Issued_cust = c.Customer_Id;

-- 4. Display the total count of books in each category.
SELECT Category,COUNT(*) FROM Books GROUP BY Category;

-- 5. Retrieve the employee names and their positions for the employees whose salaries are above Rs.10,000.
SELECT Emp_name,Position FROM Employee WHERE Salary>10000;

-- 6. List the customer names who registered before 2022-02-01 and have not issued any books yet.
SELECT Customer_name FROM Customer WHERE Reg_Date > '2022-02-01' AND Customer_Id NOT IN (SELECT Issued_cust FROM IssueStatus);

-- 7. Display the branch numbers and the total count of employees in each branch.
SELECT b.Branch_no,COUNT(*) as Total_Count FROM Employee e JOIN Branch b on e.Emp_Id=Manager_Id GROUP BY b.Branch_no;

-- 8. Display the names of customers who have issued books in the month of Feb 2023. 
SELECT Customer_name FROM Customer WHERE Customer_Id IN (SELECT Issued_cust FROM IssueStatus WHERE Issue_date LIKE '2023-02-%');

-- 9. Retrieve book_title from book table containing novel.
SELECT book_title FROM Books WHERE Category = 'Novel';

-- 10. Retrieve the branch numbers along with the count of employees for branches having more than 5 employees.
SELECT b.Branch_no,COUNT(*) as Total_Count FROM Employee e JOIN Branch b on e.Emp_Id=Manager_Id GROUP BY b.Branch_no HAVING COUNT(Branch_no)>5;




