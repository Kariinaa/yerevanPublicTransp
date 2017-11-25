CREATE DATABASE IF NOT EXISTS public_transportation_production;
CREATE DATABASE IF NOT EXISTS public_transportation_test;

USE public_transportation_production;
USE public_transportation_test;

CREATE TABLE IF NOT EXISTS user (
  id        INT         NOT NULL AUTO_INCREMENT PRIMARY KEY,
  email     VARCHAR(50) NOT NULL UNIQUE,
  pass_hash VARCHAR(50)
)
  ENGINE INNODB;

CREATE TABLE IF NOT EXISTS stop (
  id        INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  longitute DOUBLE,
  latitude  DOUBLE
)
  ENGINE INNODB;


CREATE TABLE IF NOT EXISTS favorite (
  user_id INT,
  stop_id INT,
  FOREIGN KEY (user_id) REFERENCES user (id),
  FOREIGN KEY (stop_id) REFERENCES stop (id)

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
  FOREIGN KEY (vehicle_type_id) REFERENCES vehicle (id)

)
  ENGINE INNODB;

CREATE TABLE IF NOT EXISTS stop_vehicle (
  stop_id    INT,
  vehicle_id INT,
  FOREIGN KEY (stop_id) REFERENCES stop (id),
  FOREIGN KEY (vehicle_id) REFERENCES vehicle (id)
)
  ENGINE INNODB;



