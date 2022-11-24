Excetion Handling in SQL:

	DECLARE handler_action HANDLER
    FOR condition_value [, condition_value] ...
    statement

	handler_action: {
		CONTINUE
	  | EXIT
	  | UNDO
	}

	condition_value: {
		mysql_error_code
	  | SQLSTATE [VALUE] sqlstate_value
	  | condition_name
	  | SQLWARNING
	  | NOT FOUND
	  | SQLEXCEPTION
	}
	
	-- The DECLARE ... HANDLER statement specifies a handler that deals with one or more conditions. If one of these conditions occurs, the specified statement executes. statement can be a simple statement such as SET var_name = value, or a compound statement written using BEGIN and END 
	
	-- Types of handler_action
	
	-- CONTINUE: Execution of the current program continues.

	-- EXIT: Execution terminates for the BEGIN ... END compound statement in which the handler is declared. This is true even if the condition occurs in an inner block.

	-- UNDO: Not supported.
	
	-- The condition_value indicates the specific condition or class of conditions that activates the handler. It can take the following forms:
	
	-- mysql_error_code: An integer literal indicating a MySQL error code, such as 1051 to specify “unknown table”
	
	DECLARE CONTINUE HANDLER FOR 1051
	BEGIN
		-- body of handler
	END;
	
	-- sqlstate_value: A 5-character string literal indicating an SQLSTATE value, such as '42S01' to specify “unknown table”:
	
	DECLARE CONTINUE HANDLER FOR SQLSTATE '42S02'
	  BEGIN
		-- body of handler
	  END;
	
	--condition_name: A condition name can be associated with a MySQL error code or SQLSTATE value.
	
	DECLARE CONTINUE HANDLER FOR SQLWARNING
	  BEGIN
		-- body of handler
	  END;
	  
	
-- Important points
	
	-- Example 1
	DECLARE CONTINUE HANDLER FOR SQLEXCEPTION SET has_error = 1;

	 -- Example 2
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
	ROLLBACK;
	SELECT 'An error has occurred, operation rollbacked and terminated';
	END;

	-- Example 3
	DECLARE CONTINUE HANDLER FOR NOT FOUND SET no_row_found = 1;

	-- Example 4
	DECLARE CONTINUE HANDLER FOR 1062
	SELECT 'Error, duplicate key occurred';