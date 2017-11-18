CREATE DATABASE IF NOT EXISTS public_transportation_production;
CREATE DATABASE IF NOT EXISTS public_transportation_test;

USE public_transportation_production;

CREATE TABLE IF NOT EXISTS user (
  id        INT         NOT NULL AUTO_INCREMENT PRIMARY KEY,
  email     VARCHAR(50) NOT NULL UNIQUE,
  pass_hash VARCHAR(50)
)
  ENGINE INNODB;