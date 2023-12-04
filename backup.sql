-- Valentina Studio --
-- MySQL dump --
-- ---------------------------------------------------------


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
-- ---------------------------------------------------------


-- DROP DATABASE "hefish_1" --------------------------------
DROP DATABASE IF EXISTS `hefish_1`;
-- ---------------------------------------------------------


-- CREATE DATABASE "hefish_1" ------------------------------
CREATE DATABASE `hefish_1` CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `hefish_1`;
-- ---------------------------------------------------------


-- CREATE TABLE "fish_types" -----------------------------------
CREATE TABLE `fish_types`( 
	`id` Int( 0 ) NOT NULL,
	`name` VarChar( 50 ) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
	PRIMARY KEY ( `id` ) )
CHARACTER SET = utf8mb4
COLLATE = utf8mb4_general_ci
ENGINE = InnoDB;
-- -------------------------------------------------------------


-- CREATE TABLE "fishes" ---------------------------------------
CREATE TABLE `fishes`( 
	`id` Int( 0 ) NOT NULL,
	`user_id` Int( 0 ) NOT NULL,
	`fish_type_id` Int( 0 ) NOT NULL,
	`name` VarChar( 50 ) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
	`description` VarChar( 255 ) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
	`price` Int( 0 ) NOT NULL,
	`image_path` VarChar( 100 ) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
	PRIMARY KEY ( `id` ) )
CHARACTER SET = utf8mb4
COLLATE = utf8mb4_general_ci
ENGINE = InnoDB;
-- -------------------------------------------------------------


-- CREATE TABLE "users" ----------------------------------------
CREATE TABLE `users`( 
	`id` Int( 0 ) NOT NULL,
	`email` VarChar( 50 ) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
	`username` VarChar( 50 ) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
	`password` VarChar( 20 ) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
	`token` Char( 10 ) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
	PRIMARY KEY ( `id` ) )
CHARACTER SET = utf8mb4
COLLATE = utf8mb4_general_ci
ENGINE = InnoDB;
-- -------------------------------------------------------------


-- Dump data of "fish_types" -------------------------------
BEGIN;

INSERT INTO `fish_types`(`id`,`name`) VALUES 
( '1', 'Salt Water' ),
( '2', 'Fresh Water' ),
( '3', 'Other' );
COMMIT;
-- ---------------------------------------------------------


-- Dump data of "fishes" -----------------------------------
BEGIN;

INSERT INTO `fishes`(`id`,`user_id`,`fish_type_id`,`name`,`description`,`price`,`image_path`) VALUES 
( '1', '1', '1', 'Clown Fish', 'Clown fish likes to play with anemon and live in group', '50000', 'clown.jpg' ),
( '2', '1', '1', 'Scorpion Fish', 'Scorpion fish is known as beautiful and dangerous fish', '250000', 'scorpion.jpg' ),
( '3', '1', '1', 'Blue Tang Fish', 'Known as Dory in Finding Nemo has beautiful blue color', '450000', 'blue_tang.jpg' ),
( '4', '1', '2', 'Piranha Fish', 'Meat eater fish who live in group on Amazon River', '125000', 'piranha.jpeg' ),
( '5', '1', '2', 'Tiger Catfish', 'Tiger like catfish which can grow to very big size', '200000', 'tiger.jpg' ),
( '6', '1', '2', 'Channa Fish', 'Channa is very popular because of its beautiful pattern', '140000', 'channa.jpg' ),
( '7', '1', '3', 'Milk Fish', 'Milk fish live in both water. Its famous because of its taste', '75000', 'milkfish.jpg' ),
( '8', '1', '3', 'Salmon Fish', 'Salmon very popular because its taste among sushi lovers', '125000', 'salmon.jpg' );
COMMIT;
-- ---------------------------------------------------------


-- Dump data of "users" ------------------------------------
BEGIN;

INSERT INTO `users`(`id`,`email`,`username`,`password`,`token`) VALUES 
( '1', 'adminhe@gmail.com', 'admin', 'Admin123', 'hfRQebrO6V' ),
( '2', 'user@gmail.com', 'user1', 'User123', 'MTvG38J4He' ),
( '3', 'test@gmail.com', 'test1', 'Test123', 'wwZxlTHuiu' ),
( '4', 'test2@gmail.com', 'test2', 'Test123', 'IUwEtXMRgt' );
COMMIT;
-- ---------------------------------------------------------


-- CREATE INDEX "lnk_fish_types_fishes" ------------------------
CREATE INDEX `lnk_fish_types_fishes` USING BTREE ON `fishes`( `fish_type_id` );
-- -------------------------------------------------------------


-- CREATE INDEX "lnk_users_fishes" -----------------------------
CREATE INDEX `lnk_users_fishes` USING BTREE ON `fishes`( `user_id` );
-- -------------------------------------------------------------


-- CREATE LINK "lnk_fish_types_fishes" -------------------------
ALTER TABLE `fishes`
	ADD CONSTRAINT `lnk_fish_types_fishes` FOREIGN KEY ( `fish_type_id` )
	REFERENCES `fish_types`( `id` )
	ON DELETE Cascade
	ON UPDATE Cascade;
-- -------------------------------------------------------------


-- CREATE LINK "lnk_users_fishes" ------------------------------
ALTER TABLE `fishes`
	ADD CONSTRAINT `lnk_users_fishes` FOREIGN KEY ( `user_id` )
	REFERENCES `users`( `id` )
	ON DELETE Cascade
	ON UPDATE Cascade;
-- -------------------------------------------------------------


/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
-- ---------------------------------------------------------


