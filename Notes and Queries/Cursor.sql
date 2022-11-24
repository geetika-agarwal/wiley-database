Cursors:

CREATE PROCEDURE getTotalMarks(
	InOut marksOut INT
)

BEGIN

DECLARE finished int DEFAULT 0;

DECLARE marks_cursor CURSOR FOR SELECT marks FROM students;

DECLARE CONTINUE handler FOR NOT FOUND SET finished=1;

OPEN marks_cursor;

marksloop: LOOP
	
	FETCH marks_cursor INTO mark;
	
	if finished = 1 THEN
		LEAVE marksloop;
	end IF
	
	marksOut = marksOut + mark
	
end LOOP marksloop;

CLOSE marks_cursor;

end