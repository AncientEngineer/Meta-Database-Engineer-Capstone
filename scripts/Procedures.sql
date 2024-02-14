USE `mydb`;
DROP procedure IF EXISTS `GetMaxQuantity`;

DELIMITER $$
USE `mydb`$$
CREATE PROCEDURE `GetMaxQuantity` ()
BEGIN
SELECT 	max(oi.qty)
FROM mydb.orderItem oi;
END$$

DELIMITER ;


USE `mydb`;
DROP procedure IF EXISTS `ManageBooking`;

DELIMITER $$
USE `mydb`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `ManageBooking`(IN date DATETIME, IN id INT)
BEGIN
SELECT *
FROM bookings
WHERE BookingDate = date
      AND id = tableID; END$$

DELIMITER ;
;

USE `mydb`;
DROP procedure IF EXISTS `AddCustomer`;

DELIMITER $$
USE `mydb`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `AddCustomer`(IN CustomerID INT, IN LastName VARCHAR(500), IN FirstName VARCHAR(500), IN Email VARCHAR(500), IN Phone VARCHAR(500))
BEGIN
START TRANSACTION;
INSERT INTO customer(CustomerID, LastName, FirstName, Email, Phone)
VALUES (CustomerID, LastName, FirstName, Email, Phone);
COMMIT; END$$

DELIMITER ;

CREATE DEFINER=`root`@`localhost` PROCEDURE `AddBooking`(IN BookingDate DATETIME, IN TableID INT, IN CustomerID INT)
BEGIN
START TRANSACTION;
INSERT INTO bookings(BookingDate, TableID, CustomerID)
VALUES (BookingDate, TableID, CustomerID);
COMMIT; END

USE `mydb`;
DROP procedure IF EXISTS `UpdateBooking`;

USE `mydb`;
DROP procedure IF EXISTS `mydb`.`UpdateBooking`;
;

DELIMITER $$
USE `mydb`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `UpdateBooking`(IN date DATETIME, IN id INT)
BEGIN
START TRANSACTION;
UPDATE bookings
SET BookingDate = date
WHERE id = tableID; 
COMMIT; END$$

DELIMITER ;
;


USE `mydb`;
DROP procedure IF EXISTS `CancelBooking`;

DELIMITER $$
USE `mydb`$$
CREATE PROCEDURE CancelBooking(IN id INT) BEGIN
DELETE
FROM bookings
WHERE id = bookingID; END;$$

DELIMITER ;