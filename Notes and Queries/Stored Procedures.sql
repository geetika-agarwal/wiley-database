CREATE PROCEDURE `getAllStudents` ()
BEGIN
	SELECT * FROM student;
END

–Calling getAllStudents() through stored procedures,we get the whole table ‘student’.
	Call getAllStudents();
—------------------------------------------------------------------------------------------------------------

CREATE PROCEDURE `getStudent3` ()
BEGIN
	SELECT *   FROM student where studentId=103 ;
END

–Calling getStudentName3 through stored procedures.
	call getStudent3();

—------------------------------------------------------------------------------------------------------------
CREATE PROCEDURE `getStudentByFirstName`(
IN firstName varchar(200)
)
BEGIN
	SELECT p.firstName,s.email   FROM student s join person p
ON  s.personId = p.personId
WHERE p.firstName = firstName;
END

–Calling getStudentByFirstName through stored procedures.
	call getStudentByFirstName(‘Geetika’);

—------------------------------------------------------------------------------------------------------------
OUT PARAMETER:

CREATE PROCEDURE `getTotalAttempts`(
OUT totalAttemptedPeople int
)
BEGIN
	SELECT count(studentId) 
	INTO totalAttemptedPeople
FROM credit
WHERE attempt =1;
END



–Calling getTotalAttempts through stored procedures.

call getTotalAttempts(@totalCount);
SELECT @totalCount as Total_Attempted_People;

—------------------------------------------------------------------------------------------------------------
INOUT PARAMETER:


CREATE PROCEDURE `getFullNameByFirstName`(
INOUT name varchar(200)
)
BEGIN
	–input name is firstname
	–output name is last name

	SELECT concat(firstName,lastName)
	INTO name
FROM person
WHERE firstname=name;
END


–Calling getFullNameByFirstName through stored procedures.

SET @name=’Geetika’;
call getFullNameByFirstName(@name);
SELECT @name as FullName;

—------------------------------------------------------------------------------------------------------------


CREATE DEFINER=`root`@`localhost` PROCEDURE `getPersonDetailsByFirstName`(
INOUT name varchar(200),
OUT dob date
)
BEGINs
	-- input name is name
	-- output name is fullname,dob

	SELECT concat(firstName,lastName), dateOfBirth
	INTO name, dob
	FROM person
	WHERE firstname=name;
END



–Calling getPersonDetailsByFirstName through stored procedures.

SET @name=’Geetika’;
call getFullNameByFirstName(@name,@dob);
SELECT @name as FullName,@dob;

**Order of the parameter passed should be equal to the order in which we declare.
**INOUT variables should be declared before passing into the parameter.


—------------------------------------------------------------------------------------------------------------
IF_ELSE_CONDITION:

CREATE DEFINER=`root`@`localhost` PROCEDURE `getGradeFromCourseIfAttempted`(
	IN cId int,
    IN sId int,
    OUT message varchar(20)
)
BEGIN
	SET @bgrade = null;
	select grade into @bgrade from credit 
    where courseId = cId AND studentId = sId;
    
    if(@bgrade IS NULL) THEN
		set message = 'Not Attempted Course';
	else
		set message = 'Attempted';
	END IF;
END

–Calling getGradeFromCourseIfAttempted through stored procedures.

Call getGradeFromCourseIfAttempted(2,107,@message);
SELECT @message;

—------------------------------------------------------------------------------------------------------------

SWITCH _CASE:

CREATE DEFINER=`root`@`localhost` PROCEDURE `getPercentage`(
	in sid int,
    in cid int,
    OUT percentage int
)
BEGIN
	SET @var_grade = null;
	SELECT grade into @var_grade from credit
    where studentId = sid and courseId = cid;
    
    case
		when @var_grade = 'A' then set percentage = 90;
        when @var_grade = 'B' then set percentage = 80;
        when @var_grade = 'C' then set percentage = 70;
        when @var_grade = 'D' then set percentage = 60;
        ELSE set percentage = 0;        
	END CASE;
END


–Calling getPercentagethrough stored procedures.

call getPercentage(107,2,@per);
SELECT @per;

—------------------------------------------------------------------------------------------------------------

LOOPING:

CREATE DEFINER=`root`@`localhost` PROCEDURE `loopPersonDetails`()
BEGIN
	DECLARE id, count int;
	SET id = 1;
	SET count = (SELECT count(*) from person);
    personLoop: LOOP
		SELECT * FROm PERSON where personId = id;
        set id = id+1;
        if(id > count) then
			leave personLoop;
		end if;
	end LOOP personLoop;
END


–Calling loopPersonDetails stored procedures.

call loopPersonDetails();


