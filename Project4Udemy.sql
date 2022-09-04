-- Review top 5 rows of data for all columns 
SELECT TOP 5 * FROM Udemy

-- Count number of rows = 3678
SELECT COUNT(*) FROM Udemy

-- Count unique course IDs = 3672
SELECT COUNT(DISTINCT course_id) FROM Udemy

-- Select rows with duplicate IDs = there are 6 course IDs that have duplicates which accounts for the extra 6 rows compared to unique IDs
SELECT course_id, COUNT(*) FROM Udemy
GROUP BY course_id
HAVING COUNT(*) > 1

-- Compare data for duplicate course IDs = data points for the duplicates were exactly the same
SELECT * FROM Udemy
WHERE course_id = '837322' OR course_id = '185526' OR course_id = '1157298' OR course_id = '1035638' OR course_id = '28295' OR course_id = '1084454'
ORDER BY course_id
D

-- Assigned row number to the duplicate IDs and deleted extras
WITH duplicates AS (
SELECT ROW_NUMBER () OVER(PARTITION BY course_id ORDER BY course_id) AS row_num, course_id  FROM Udemy
WHERE course_id = '837322' OR course_id = '185526' OR course_id = '1157298' OR course_id = '1035638' OR course_id = '28295' OR course_id = '1084454'
)
DELETE * FROM duplicates
WHERE row_num > 1

-- Double check if extra rows were deleted = both queries below return 3672!
SELECT COUNT(*) FROM Udemy
SELECT COUNT(DISTINCT course_id) FROM Udemy
Count number of courses that have a fee (3362), number of courses that are free (310)
SELECT COUNT(is_paid) FROM Udemy WHERE is_paid = 1
SELECT COUNT(is_paid) FROM Udemy WHERE is_paid = 0

-- Checking range of course prices = max is 200, min is 0, average is 66
SELECT MAX(price) AS max_price, MIN(price) AS min_price, AVG(price) AS avg_price  FROM Udemy

-- Selected all data on courses with top 10 number of subscribers. 6/10 are free, 9/10 are web development courses
SELECT TOP 10 * FROM Udemy ORDER BY num_subscribers DESC

-- Published_timestamp colum has yyyy-mm-ddThh:mm:ss. Organizing from year would be easier. So in the following I’ll create a new year column and insert yyyy from published_timestamp column
SELECT SUBSTRING(published_timestamp, 1, CHARINDEX('-', published_timestamp) -1) AS year FROM Udemy
 
ALTER TABLE Udemy ADD year INT
 
UPDATE Udemy
SET year = SUBSTRING(published_timestamp, 1, CHARINDEX('-', published_timestamp) -1)

-- Check how many courses per year. Most published courses are from 2016 > 2015 > and 2017
SELECT year, COUNT(*) FROM Udemy GROUP BY year ORDER BY COUNT(*) DESC

-- Identify the different types subjects available: Web Development, Graphic Design, Musical Instruments, Business Finance 
SELECT DISTINCT(subject) FROM Udemy

-- Count number of lectures per subject: Web Development (1199), Business Finance (1191), Musical Instruments (680), Graphic Design (602)
SELECT subject, COUNT(num_lectures) FROM Udemy GROUP BY subject ORDER BY COUNT(*) DESC
