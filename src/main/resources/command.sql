DROP DATABASE IF EXISTS public_transportation_production;

CREATE DATABASE IF NOT EXISTS public_transportation_production;
# CREATE DATABASE IF NOT EXISTS public_transportation_test;

USE public_transportation_production;
# USE public_transportation_test;
#
# DROP TRIGGER IF EXISTS chk_route_dir;
# DROP TABLE IF EXISTS stop_vehicle;
# DROP VIEW IF EXISTS bus;
# DROP VIEW IF EXISTS minibus;
# DROP VIEW IF EXISTS trolleybus;
# DROP TABLE IF EXISTS vehicle;
# DROP TABLE IF EXISTS vehicle_type;
# DROP TABLE IF EXISTS favorite;
# DROP TABLE IF EXISTS user_history_2017;
# DROP TABLE IF EXISTS stop;
# DROP TABLE IF EXISTS user;

CREATE TABLE IF NOT EXISTS user (
  id        INT         NOT NULL AUTO_INCREMENT PRIMARY KEY,
  email     VARCHAR(50) NOT NULL UNIQUE,
  pass_hash VARCHAR(50) NOT NULL
)
  ENGINE INNODB;

CREATE TABLE IF NOT EXISTS stop (
  id        INT          NOT NULL AUTO_INCREMENT PRIMARY KEY,
  longitute DOUBLE       NOT NULL,
  latitude  DOUBLE       NOT NULL,
  name      VARCHAR(100) NOT NULL,
  UNIQUE INDEX (longitute, latitude)
)
  ENGINE INNODB;

CREATE TABLE IF NOT EXISTS favorite (
  user_id INT,
  stop_id INT,
  FOREIGN KEY (user_id) REFERENCES user (id),
  FOREIGN KEY (stop_id) REFERENCES stop (id),
  PRIMARY KEY (user_id, stop_id)
)
  ENGINE INNODB;

CREATE TABLE IF NOT EXISTS vehicle_type (
  id   INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(10)
)
  ENGINE INNODB;

CREATE TABLE IF NOT EXISTS vehicle (
  id              INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  number          INT NOT NULL,
  vehicle_type_id INT NOT NULL,
  cycle_length    INT,
  quantity        INT,
  `interval`      INT,
  UNIQUE INDEX (number, vehicle_type_id),
  FOREIGN KEY (vehicle_type_id) REFERENCES vehicle_type (id)

)
  ENGINE INNODB;

CREATE VIEW bus
  AS
    SELECT *
    FROM vehicle
    WHERE
      vehicle_type_id = (SELECT id
                         FROM vehicle_type
                         WHERE UPPER(name) = 'BUS');

CREATE VIEW minibus
  AS
    SELECT *
    FROM vehicle
    WHERE
      vehicle_type_id = (SELECT id
                         FROM vehicle_type
                         WHERE UPPER(name) = 'MINIBUS');

CREATE VIEW trolleybus
  AS
    SELECT *
    FROM vehicle
    WHERE
      vehicle_type_id = (SELECT id
                         FROM vehicle_type
                         WHERE UPPER(name) = 'TROLLEYBUS');

CREATE TABLE IF NOT EXISTS stop_vehicle (
  stop_id    INT     NOT NULL,
  vehicle_id INT     NOT NULL,
  route      BOOLEAN NOT NULL,
  route_back BOOLEAN NOT NULL,
  FOREIGN KEY (stop_id) REFERENCES stop (id),
  FOREIGN KEY (vehicle_id) REFERENCES vehicle (id),
  PRIMARY KEY (stop_id, vehicle_id)
)
  ENGINE INNODB;

DELIMITER //
CREATE TRIGGER chk_route_dir
BEFORE INSERT ON stop_vehicle
FOR EACH ROW
  BEGIN
    IF ((NEW.route | NEW.route_back) = FALSE)
    THEN
      SIGNAL SQLSTATE '45000'
      SET MESSAGE_TEXT = 'Cannot add or update row: route or route back';
    END IF;
  END //

DELIMITER ;

DELIMITER //
CREATE PROCEDURE create_history_table_procedure(IN sqlq VARCHAR(5000))
  BEGIN
    SET @create_history_table_syntax = sqlq;
    PREPARE stmt FROM @create_history_table_syntax;
    EXECUTE stmt;
    DEALLOCATE PREPARE stmt;
  END//
DELIMITER ;


CREATE EVENT new_history_table
  ON SCHEDULE EVERY 1 YEAR
  STARTS '2017-12-11 22:37:00'
DO
  BEGIN
    SET @sqlq =  CONCAT('create table `user_history_', date_format(curdate(), '%Y'), '` (user_id    INT,   stop_id    INT,   FOREIGN KEY (user_id) REFERENCES user (id),   FOREIGN KEY (stop_id) REFERENCES stop (id) ) ENGINE INNODB');
    CALL create_history_table_procedure(sqlq);
  END;


# INSERT INTO vehicle_type (id, name) VALUES (1, 'Minibus');
# INSERT INTO vehicle_type (id, name) VALUES (2, 'Bus');
# INSERT INTO vehicle_type (id, name) VALUES (3, 'Trolleybus');
#
# INSERT INTO stop (id, longitute, latitude, name) VALUES (1, 1, 1, 'asdf');
# INSERT INTO vehicle (id, number, vehicle_type_id, cycle_length, quantity, `interval`) VALUES (1, 1, 1, 1, 1, 1);
# INSERT INTO stop_vehicle (stop_id, vehicle_id, route, route_back) VALUES (1, 1, TRUE, FALSE);
# INSERT INTO stop_vehicle (stop_id, vehicle_id, route, route_back) VALUES (1, 1, FALSE, FALSE);