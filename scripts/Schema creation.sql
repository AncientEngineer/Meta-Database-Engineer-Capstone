-- MySQL Script generated by MySQL Workbench
-- Tue May  9 21:28:34 2023
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`address`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`address` ;

CREATE TABLE IF NOT EXISTS `mydb`.`address` (
  `AddressID` INT NOT NULL,
  `Postcode` VARCHAR(45) NULL,
  `City` VARCHAR(500) NULL,
  `State` VARCHAR(500) NULL,
  `StreetLineOne` VARCHAR(500) NULL,
  `StreetLineTwo` VARCHAR(500) NULL,
  `default` BINARY(1) NULL,
  `Customer ID` INT NOT NULL,
  `Country` VARCHAR(500) NULL,
  PRIMARY KEY (`AddressID`),
  CONSTRAINT `fk_address_customer1`
    FOREIGN KEY (`Customer ID`)
    REFERENCES `mydb`.`customer` (`CustomerID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_address_customer1_idx` ON `mydb`.`address` (`Customer ID` ASC) VISIBLE;

-- -----------------------------------------------------
-- Table `mydb`.`bookings`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`bookings` ;

CREATE TABLE IF NOT EXISTS `mydb`.`bookings` (
  `BookingID` INT NOT NULL,
  `BookingDate` TIMESTAMP(6) NULL,
  `TableID` INT NULL,
  `CustomerID` INT NOT NULL,
  PRIMARY KEY (`BookingID`),
  CONSTRAINT `fk_bookings_customer1`
    FOREIGN KEY (`CustomerID`)
    REFERENCES `mydb`.`customer` (`CustomerID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

ALTER TABLE `mydb`.`bookings` 
ADD UNIQUE INDEX `BookingID_UNIQUE` (`BookingID` ASC) VISIBLE;
;

ALTER TABLE `mydb`.`bookings` 
CHANGE COLUMN `BookingID` `BookingID` INT NOT NULL AUTO_INCREMENT ;

CREATE INDEX `fk_bookings_customer1_idx` ON `mydb`.`bookings` (`CustomerID` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `mydb`.`category`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`category` ;

CREATE TABLE IF NOT EXISTS `mydb`.`category` (
  `CategoryID` INT NOT NULL,
  `CategoryName` VARCHAR(500) NULL,
  `CategoryID` INT NOT NULL,
  PRIMARY KEY (`CategoryID`),
  CONSTRAINT `fk_category_category1`
    FOREIGN KEY (`CategoryID`)
    REFERENCES `mydb`.`category` (`CategoryID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_category_category1_idx` ON `mydb`.`category` (`CategoryID` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `mydb`.`customer`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`customer` ;

CREATE TABLE IF NOT EXISTS `mydb`.`customer` (
  `CustomerID` INT NOT NULL,
  `LastName` VARCHAR(500) NULL,
  `FirstName` VARCHAR(500) NULL,
  `Email` VARCHAR(500) NULL,
  `Phone` VARCHAR(45) NULL,
  PRIMARY KEY (`CustomerID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`discount`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`discount` ;

CREATE TABLE IF NOT EXISTS `mydb`.`discount` (
  `DiscountID` INT NOT NULL,
  `DiscountName` VARCHAR(45) NULL,
  `DiscountCode` VARCHAR(45) NULL,
  PRIMARY KEY (`DiscountID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`discountItem`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`discountItem` ;

CREATE TABLE IF NOT EXISTS `mydb`.`discountItem` (
  `DiscountItemID` INT NOT NULL,
  `Discount` DECIMAL(10) NULL,
  `DiscountID` INT NOT NULL,
  `OrderID` INT NOT NULL,
  PRIMARY KEY (`DiscountItemID`),
  CONSTRAINT `fk_discount item_discount1`
    FOREIGN KEY (`DiscountID`)
    REFERENCES `mydb`.`discount` (`DiscountID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_discount item_order1`
    FOREIGN KEY (`OrderID`)
    REFERENCES `mydb`.`order` (`OrderID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_discount item_discount1_idx` ON `mydb`.`discountItem` (`DiscountID` ASC) VISIBLE;

CREATE INDEX `fk_discount item_order1_idx` ON `mydb`.`discountItem` (`OrderID` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `mydb`.`order`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`order` ;

CREATE TABLE IF NOT EXISTS `mydb`.`order` (
  `OrderID` INT NOT NULL,
  `OrderDate` DATETIME NULL,
  `OrderPriority` VARCHAR(45) NULL,
  `CustomerID` INT NOT NULL,
  PRIMARY KEY (`OrderID`),
  CONSTRAINT `fk_order_customer1`
    FOREIGN KEY (`CustomerID`)
    REFERENCES `mydb`.`customer` (`CustomerID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_order_customer1_idx` ON `mydb`.`order` (`CustomerID` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `mydb`.`orderItem`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`orderItem` ;

CREATE TABLE IF NOT EXISTS `mydb`.`orderItem` (
  `OrderItemID` INT NOT NULL,
  `qty` INT NULL,
  `ProductID` INT NOT NULL,
  `OrderID` INT NOT NULL,
  PRIMARY KEY (`OrderItemID`),
  CONSTRAINT `fk_order item_product`
    FOREIGN KEY (`ProductID`)
    REFERENCES `mydb`.`product` (`ProductID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_order item_order1`
    FOREIGN KEY (`OrderID`)
    REFERENCES `mydb`.`order` (`OrderID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_order item_product_idx` ON `mydb`.`orderItem` (`ProductID` ASC) VISIBLE;

CREATE INDEX `fk_order item_order1_idx` ON `mydb`.`orderItem` (`OrderID` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `mydb`.`payment`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`payment` ;

CREATE TABLE IF NOT EXISTS `mydb`.`payment` (
  `PaymentID` INT NOT NULL,
  `PaymentStatus` BINARY(1) NULL,
  `PaymentAmount` DECIMAL(10) NULL,
  `OrderID` INT NOT NULL,
  PRIMARY KEY (`PaymentID`),
  CONSTRAINT `fk_payment_order1`
    FOREIGN KEY (`OrderID`)
    REFERENCES `mydb`.`order` (`OrderID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_payment_order1_idx` ON `mydb`.`payment` (`OrderID` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `mydb`.`product`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`product` ;

CREATE TABLE IF NOT EXISTS `mydb`.`product` (
  `ProductID` INT NOT NULL,
  `ProductName` VARCHAR(500) NULL,
  `ProductPrice` DECIMAL(10) NULL,
  `CategoryID` INT NOT NULL,
  PRIMARY KEY (`ProductID`),
  CONSTRAINT `fk_product_category1`
    FOREIGN KEY (`CategoryID`)
    REFERENCES `mydb`.`category` (`CategoryID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_product_category1_idx` ON `mydb`.`product` (`CategoryID` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `mydb`.`shipping`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`shipping` ;

CREATE TABLE IF NOT EXISTS `mydb`.`shipping` (
  `ShippingID` INT NOT NULL,
  `AddressID` INT NOT NULL,
  `OrderID` INT NOT NULL,
  `ShipDate` DATETIME NULL,
  `ShipMode` VARCHAR(500) NULL,
  `ShippingCost` DECIMAL(10) NULL,
  PRIMARY KEY (`ShippingID`),
  CONSTRAINT `fk_shipping_address1`
    FOREIGN KEY (`AddressID`)
    REFERENCES `mydb`.`address` (`AddressID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_shipping_order1`
    FOREIGN KEY (`OrderID`)
    REFERENCES `mydb`.`order` (`OrderID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_shipping_address1_idx` ON `mydb`.`shipping` (`AddressID` ASC) VISIBLE;

CREATE INDEX `fk_shipping_order1_idx` ON `mydb`.`shipping` (`OrderID` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `mydb`.`table1`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`table1` ;

CREATE TABLE IF NOT EXISTS `mydb`.`table1` (
)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`table2`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`table2` ;

CREATE TABLE IF NOT EXISTS `mydb`.`table2` (
)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;