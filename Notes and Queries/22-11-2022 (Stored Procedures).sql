-- Calling getAllStudents() through stored procedures

call getAllStudents();

-- Calling getStudentBy3() 

call getStudent3();

-- Calling getStudentByFirstName() (IN)

call getStudentByFirstName('Maan');

-- Calling gettotalAttempts() (OUT)

call getTotalAttempts(@totalCount); 
select @totalCount;

-- get Full Name from First Name 

SET @name = 'Geetika';
call getFullNameByFirstName(@name);
SELECT @name as Full_Name;

-- InOut variables should be declared before passing into the procedure.
SET @name = 'Chetan';
call getPersonDetailsByFirstName(@name, @dob);
SELECT @name as Full_Name, @dob;

call getGradeFromCourseIfAttempted(5, 107, @msg);
SELECT @msg;

call getPercentage(107, 2, @per);
Select @per;

call loopPersonDetails();