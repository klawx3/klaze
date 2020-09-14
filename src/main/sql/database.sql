DROP DATABASE IF EXITS klaze;
CREATE DATABASE klaze;
USE klaze;

CREATE TABLE user (
    id INT AUTO_INCREMENT,
    nickname VARCHAR(50) NOT NULL,
    email VARCHAR(50) NOT NULL,
    passwd VARCHAR(64) NOT NULL,

    PRIMARY KEY (id),
    UNIQUE (nickname)
);


