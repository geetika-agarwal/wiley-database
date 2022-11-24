Triggers:

	-- CREATE a TABLE
	CREATE TABLE account (acct_num INT, amount DECIMAL(10,2));

	-- BEFORE INSERT ON
	
	CREATE TRIGGER ins_sum BEFORE INSERT ON account
	FOR EACH ROW set @sum = @sum + New.amount;
	
	-- It is possible to define multiple triggers for a given table that have the same trigger event and action time. 
	
	-- By default, triggers that have the same trigger event and action time activate in the order they were created. 
	
	-- To affect trigger order, specify a clause after FOR EACH ROW that indicates FOLLOWS or PRECEDES and the name of an existing trigger that also has the same trigger event and action time.
	
	-- With FOLLOWS, the new trigger activates after the existing trigger. With PRECEDES, the new trigger activates before the existing trigger.
	
	CREATE TRIGGER ins_transaction BEFORE INSERT ON account
       FOR EACH ROW PRECEDES ins_sum
       SET
       @deposits = @deposits + IF(NEW.amount>0,NEW.amount,0),
       @withdrawals = @withdrawals + IF(NEW.amount<0,-NEW.amount,0);
	   
	-- In an INSERT trigger, only NEW.col_name can be used; there is no old row. In a DELETE trigger, only OLD.col_name can be used; there is no new row. In an UPDATE trigger, you can use OLD.col_name to refer to the columns of a row before it is updated and NEW.col_name to refer to the columns of the row after it is updated.
	
	-- you can use a trigger to modify the values to be inserted into a new row or used to update a row. (Such a SET statement has no effect in an AFTER trigger because the row change has already occurred.)
	
	mysql> delimiter //
	mysql> CREATE TRIGGER upd_check BEFORE UPDATE ON account
       FOR EACH ROW
       BEGIN
           IF NEW.amount < 0 THEN
               SET NEW.amount = 0;
           ELSEIF NEW.amount > 100 THEN
               SET NEW.amount = 100;
           END IF;
       END;//
	mysql> delimiter ;
	
	-- Triggers can contain call statements for the store procedures which is bettre than having the stored PROCEDURE inside the TRIGGER
	
	-- Triggers can contain direct references to tables by name, such as the trigger named testref shown in this example:
	
		CREATE TABLE test1(a1 INT);
		CREATE TABLE test2(a2 INT);
		CREATE TABLE test3(a3 INT NOT NULL AUTO_INCREMENT PRIMARY KEY);
		CREATE TABLE test4(
		  a4 INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
		  b4 INT DEFAULT 0
		);


		delimiter |
		CREATE TRIGGER testref BEFORE INSERT ON test1
		  FOR EACH ROW
		  BEGIN
			INSERT INTO test2 SET a2 = NEW.a1;
			DELETE FROM test3 WHERE a3 = NEW.a1;
			UPDATE test4 SET b4 = b4 + 1 WHERE a4 = NEW.a1;
		  END;
		|

		delimiter ;

		INSERT INTO test3 (a3) VALUES
		  (NULL), (NULL), (NULL), (NULL), (NULL),
		  (NULL), (NULL), (NULL), (NULL), (NULL);

		INSERT INTO test4 (a4) VALUES
		  (0), (0), (0), (0), (0), (0), (0), (0), (0), (0);