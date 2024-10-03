-- Coding Challenge on 03/10/2024
-- "Careershub"

-- Task 1. Provide a SQL script that initializes the database for the Job Board scenario “CareerHub”.

-- Create database
CREATE DATABASE CareerHub;

-- Use database
USE CareerHub;

--   Task 2. Create tables for Companies, Jobs, Applicants and Applications.
--   Task 3. Define appropriate primary keys, foreign keys, and constraints.
--   Task 4. Ensure the script handles potential errors, such as if the database or tables already exist.

CREATE TABLE Companies (
  CompanyID INT PRIMARY KEY,
  CompanyName VARCHAR(100) NOT NULL,
  Location VARCHAR(100) NOT NULL
);

CREATE TABLE Jobs (
  JobID INT PRIMARY KEY,
  CompanyID INT,
  JobTitle VARCHAR(100) NOT NULL,
  JobDescription TEXT NOT NULL,
  JobLocation VARCHAR(100) NOT NULL,
  Salary DECIMAL(10, 2) NOT NULL,
  JobType VARCHAR(50) NOT NULL,
  PostedDate DATETIME NOT NULL,
  FOREIGN KEY (CompanyID) REFERENCES Companies(CompanyID)
);

CREATE TABLE Applicants (
  ApplicantID INT PRIMARY KEY,
  FirstName VARCHAR(50) NOT NULL,
  LastName VARCHAR(50) NOT NULL,
  Email VARCHAR(100) UNIQUE NOT NULL,
  Phone VARCHAR(20) NOT NULL,
  Resume TEXT
);

CREATE TABLE Applications (
  ApplicationID INT PRIMARY KEY,
  JobID INT,
  ApplicantID INT,
  ApplicationDate DATETIME NOT NULL,
  CoverLetter TEXT,
  FOREIGN KEY (JobID) REFERENCES Jobs(JobID),
  FOREIGN KEY (ApplicantID) REFERENCES Applicants(ApplicantID)
);



--  Inserting  data into the above tables:

-- Insert companies
INSERT INTO Companies (CompanyID, CompanyName, Location)
VALUES 
(101, 'TCS', 'Chennai'),
(102,'Hexaware','Chennai'),
(103, 'Infosys', 'Bangalore'),
(104, 'Wipro', 'Hyderabad'),
(105, 'HCL', 'Noida'),
(106, 'TechMahindra', 'Pune');

-- Insert jobs
INSERT INTO Jobs (JobID, CompanyID, JobTitle, JobDescription, JobLocation, Salary, JobType, PostedDate)
VALUES 
(1001, 101, 'Software Developer', 'Develop software applications', 'Chennai', 500000.00, 'Full-time', '2024-01-01'),
(1002, 102, 'Data Scientist', 'Analyze data and build models', 'Chennai', 600000.00, 'Contract', '2024-02-01'),
(1003, 103, 'DevOps Engineer', 'Manage infrastructure and deployment', 'Bangalore', 550000.00, 'Part-time', '2024-03-01'),
(1004, 104, 'Quality Assurance Engineer', 'Test software applications', 'Hyderabad', 450000.00, 'Full-time', '2024-04-01'),
(1005, 105, 'Business Analyst', 'Analyze business requirements', 'Noida', 500000.00, 'Full-time', '2024-05-01'),
(1006, 106, 'HR Recruiter', 'Administering employee benefits', 'Pune', 500000.00, 'Part-time', '2024-05-01'),
(1007, 102, 'Data Scientist', 'Analyze data and build models', 'Chennai', 500000.00, 'Contract', '2024-09-01'),
(1008, 103, 'DevOps Engineer', 'Manage infrastructure and deployment', 'Bangalore', 500000.00, 'Full-time', '2024-08-01'),
(1009, 102, 'Quality Assurance Engineer', 'Test software applications', 'Chennai', 400000.00, 'Part-time', '2024-06-01'),
(1010, 106, 'Business Analyst', 'Analyze business requirements', 'Pune', 450000.00, 'Full-time', '2024-07-01');

-- Insert applicants
INSERT INTO Applicants (ApplicantID, FirstName, LastName, Email, Phone, Resume)
VALUES 
(201, 'Rajkumar', 'Naidu', 'rajkumar.naidu@gmail.com', '1234567890', 'resume1.txt'),
(202, 'Senthil', 'Kumar', 'senthil.kumar@gmail.com', '2345678901', 'resume2.txt'),
(203, 'Karthik', 'Ram', 'karthik.ram@gmail.com', '3456789012', 'resume3.txt'),
(204, 'Priya', 'Lakshmi', 'priya.lakshmi@gmail.com', '4567890123', 'resume4.txt'),
(205, 'Ganesh', 'Kumar', 'ganesh.kumar@gmail.com', '5678901234', 'resume5.txt'),
(206, 'Lokesh', 'Reddy', 'lokesh.reddy@gmail.com', '5432167890', 'resume6.txt'),
(207, 'Srujan', 'Singh', 'srujan.singh@gmail.com', '7780378901', 'resume7.txt'),
(208, 'Suresh', 'Gupta', 'suresh.gupta@gmail.com', '9666536224', 'resume8.txt');

-- Insert applications
INSERT INTO Applications (ApplicationID, JobID, ApplicantID, ApplicationDate, CoverLetter)
VALUES 
(1101, 1001, 201, '2024-01-15', 'coverletter1.txt'),
(1102, 1002, 202, '2024-02-20', 'coverletter2.txt'),
(1103, 1003, 203, '2024-03-25', 'coverletter3.txt'),
(1104, 1004, 204, '2024-04-30', 'coverletter4.txt'),
(1105, 1005, 205, '2024-05-29', 'coverletter5.txt'),
(1106, 1005, 205, '2024-06-01', 'coverletter6.txt'),
(1107, 1010, 208, '2024-07-15', 'coverletter7.txt'),
(1108, 1009, 202, '2024-06-09', 'coverletter8.txt'),
(1109, 1008, 202, '2024-08-20', 'coverletter9.txt'),
(1110, 1009, 203, '2024-06-21', 'coverletter10.txt');



--  Task 6: 
/* Develop an SQL query that retrieves job listings from the "Jobs" table within a specified salary range. Allow parameters for the minimum and maximum salary values. Display the job title,company name, location, and salary for each matching job.
 */
DECLARE @minSalary DECIMAL(10, 2) = 450000.00;
DECLARE @maxSalary DECIMAL(10, 2) = 550000.00;

SELECT J.JobTitle, C.CompanyName, J.JobLocation, J.Salary
FROM Jobs J
JOIN Companies C ON J.CompanyID = C.CompanyID
WHERE J.Salary BETWEEN @minSalary AND @maxSalary;


-- Task 7: 
/* Write an SQL query that retrieves the job application history for a specific applicant. Allow a parameter for the ApplicantID, and return a result set with the job titles, company names, and application dates for all the jobs the applicant has applied to.
 */
DECLARE @ApplicantID INT = 202;

SELECT J.JobTitle, C.CompanyName, A.ApplicationDate
FROM Applications A
JOIN Jobs J ON A.JobID = J.JobID
JOIN Companies C ON J.CompanyID = C.CompanyID
WHERE A.ApplicantID = @ApplicantID;



-- Task 8: 
/* Create an SQL query that calculates and displays the average salary offered by all companies for job listings in the "Jobs" table. Ensure that the query filters out jobs with a salary of zero.
 */
SELECT AVG(Salary) AS AverageSalary
FROM Jobs WHERE Salary > 0;

-- Task 9: 
/* Write an SQL query to identify the company that has posted the most job listings. Display the company name along with the count of job listings they have posted. Handle ties if multiple companies have the same maximum count.
*/

SELECT C.CompanyName, COUNT(J.JobID) AS JobCount
FROM Jobs J
JOIN Companies C ON J.CompanyID = C.CompanyID
GROUP BY C.CompanyName
ORDER BY JobCount DESC;

-- Task 10:
/* Find the applicants who have applied for positions in companies located in 'CityX' and have at least 3 years of experience */

-- ASSUMPTION : Adding a new column named Experience in the applicants table
ALTER TABLE Applicants ADD Experience INT;

UPDATE Applicants SET Experience = 4 WHERE ApplicantID=201;
UPDATE Applicants SET Experience = 2 WHERE ApplicantID=202;
UPDATE Applicants SET Experience = 2 WHERE ApplicantID=203;
UPDATE Applicants SET Experience = 1 WHERE ApplicantID=204;
UPDATE Applicants SET Experience = 1 WHERE ApplicantID=205;
UPDATE Applicants SET Experience = 0 WHERE ApplicantID=206;
UPDATE Applicants SET Experience = 5 WHERE ApplicantID=207;
UPDATE Applicants SET Experience = 2 WHERE ApplicantID=208;

select * from Applicants;

-- The actual query is here...
DECLARE @City VARCHAR(50) = 'Chennai';

SELECT A.ApplicantID, A.FirstName, A.LastName, A.Resume
FROM Applicants A
JOIN Applications AP ON A.ApplicantID = AP.ApplicantID
JOIN Jobs J ON AP.JobID = J.JobID
WHERE J.JobLocation = @City AND A.Experience > 3;

-- Task 11: 
/* Retrieve a list of distinct job titles with salaries between 6,00,000 and 5,00,000. */

SELECT DISTINCT J.JobTitle
FROM Jobs J
WHERE J.Salary BETWEEN 500000.00 AND 600000.00;

-- Task 12: 
/* Find the jobs that have not received any applications.
 */

SELECT J.JobID, J.JobTitle
FROM Jobs J
LEFT JOIN Applications A ON J.JobID = A.JobID
WHERE A.ApplicationID IS NULL;


-- Task 13:
/*  Retrieve a list of job applicants along with the companies they have applied to and the positions they have applied for.
 */

SELECT A.ApplicantID, A.FirstName, A.LastName, C.CompanyName, J.JobTitle
FROM Applicants A
JOIN Applications AP ON A.ApplicantID = AP.ApplicantID
JOIN Jobs J ON AP.JobID = J.JobID
JOIN Companies C ON J.CompanyID = C.CompanyID;

-- Task 14: 
/* Retrieve a list of companies along with the count of jobs they have posted, even if they have not received any applications.
 */


SELECT C.CompanyName, COUNT(J.JobID) AS JobCount
FROM Companies C
LEFT JOIN Jobs J ON C.CompanyID = J.CompanyID
GROUP BY C.CompanyName;

-- Task 15:
/* List all applicants alollanng with the companies and positions they have applied for, including those who have not applied. */

SELECT A.ApplicantID, A.FirstName, A.LastName, C.CompanyName, J.JobTitle
FROM Applicants A
JOIN Applications AP ON A.ApplicantID = AP.ApplicantID
JOIN Jobs J ON AP.JobID = J.JobID
JOIN Companies C ON J.CompanyID = C.CompanyID;


-- Task 16:
/* Find companies that have posted jobs with a salary higher than the average salary of all jobs.
 */

DECLARE @AverageSalary DECIMAL(10, 2);

SELECT @AverageSalary = AVG(Salary) FROM Jobs;

SELECT C.CompanyName, J.Salary
FROM Jobs J
JOIN Companies C ON J.CompanyID = C.CompanyID
WHERE J.Salary > @AverageSalary;


-- Task 17:
/* Display a list of applicants with their names and a concatenated string of their city and state.
 */
 
-- ASSUMPTION : Adding new columns City and State in the applicants table
ALTER TABLE Applicants ADD City VARCHAR(50),State VARCHAR(50);

UPDATE Applicants SET City = 'Bangalore',State='Karnataka' WHERE ApplicantID=201;
UPDATE Applicants SET City = 'Hyderabad',State='Telangana' WHERE ApplicantID=202;
UPDATE Applicants SET City = 'Chennai',State='Tamil Nadu' WHERE ApplicantID=203;
UPDATE Applicants SET City = 'Kanchipuram',State='Tamil Nadu' WHERE ApplicantID=204;
UPDATE Applicants SET City = 'Kannur',State='Kerala' WHERE ApplicantID=205;
UPDATE Applicants SET City = 'Vijayawada',State='Andhra Pradesh' WHERE ApplicantID=206;
UPDATE Applicants SET City = 'Hosur',State='Karnataka' WHERE ApplicantID=207;
UPDATE Applicants SET City = 'Nandyal',State='Andhra Pradesh' WHERE ApplicantID=208;

select * from Applicants;
 
SELECT A.ApplicantID, A.FirstName, A.LastName, 
       CONCAT(A.City, ', ', A.State) AS Location
FROM Applicants A;


-- Task 18:
/* Retrieve a list of jobs with titles containing either 'Developer' or 'Engineer'.
*/

SELECT J.JobID, J.JobTitle
FROM Jobs J
WHERE J.JobTitle LIKE '%Developer%' OR J.JobTitle LIKE '%Engineer%';



-- Task 19:
/* Retrieve a list of applicants and the jobs they have applied for, including those who have not applied and jobs without applicants.
 */

 SELECT A.ApplicantID, A.FirstName, A.LastName, J.JobTitle
FROM Applicants A
LEFT JOIN Applications AP ON A.ApplicantID = AP.ApplicantID
LEFT JOIN Jobs J ON AP.JobID = J.JobID;


-- Task 20:
/*  List all combinations of applicants and companies where the company is in a specific city and the applicant has more than 2 years of experience. For example: city=Chennai */

DECLARE @City1 VARCHAR(50) = 'Chennai';

SELECT A.ApplicantID, A.FirstName, A.LastName, C.CompanyName
FROM Applicants A
CROSS JOIN Companies C
WHERE C.Location = @City1 AND A.Experience > 2;
