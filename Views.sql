Views:

CREATE VIEW student_details AS
	(SELECT s.personId, s.studentId, c.coursename, g.grade
		FROM Student s inner join Credit g
		ON s.studentId = g.studentId
		inner join Course c
		On c.courseId = g.courseId);
		
	
	-- Insert in student TABLE
	
	insert into student VALUES (108, 8, 'test@gmail.com');
	
	insert into credit values(108, 3, 'A', 1);
	
	
	-- INSERT into VIEW
	
	insert into student_details VALUES(1, 101, 'JAVA', null);
	
	-- Create view from table with some conditions
	create view person_details_not_smith as 
	(select personId, firstName, lastName, dateOfBirth from person
	where lastName != 'Smith');
	
	
	DCL - GRANT , REVOKE
	
	CREATE OR REPLACE VIEW course_details
	AS
	SELECT *
	FROM course
	WHERE teacher = 'Mandar'
	WITH CASCADED CHECK OPTION;
