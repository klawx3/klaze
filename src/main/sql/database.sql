DROP DATABASE IF EXISTS klaze;
CREATE DATABASE klaze;
USE klaze;


-- TABLES
CREATE TABLE user_type(
    id INT AUTO_INCREMENT,
    name VARCHAR(50) NOT NULL,
    is_admin TINYINT(1),

    PRIMARY KEY (id),
    UNIQUE (name)
);

CREATE TABLE user (
    id INT AUTO_INCREMENT,
    nickname VARCHAR(50) NOT NULL,
    fullname VARCHAR(100) NOT NULL,
    email VARCHAR(50) NOT NULL,
    passwd VARCHAR(64) NOT NULL,
    user_type_id_fk INT NOT NULL,

    PRIMARY KEY (id),
    FOREIGN KEY (user_type_id_fk) REFERENCES user_type(id),
    UNIQUE (nickname),
    UNIQUE (email)
);

CREATE TABLE experience_type(
    id INT AUTO_INCREMENT,
    name TEXT NOT NULL,
    total_experience INT NOT NULL,

    PRIMARY KEY(id)
);

CREATE TABLE experience_historical(
    id INT AUTO_INCREMENT,
    reciver_id_user_fk INT NOT NULL,
    giver_id_user_fk INT NOT NULL,
    reason TEXT,
    exp_gained INT NOT NULL,
    experience_type_id_fk INT NOT NULL,
    date DATETIME NOT NULL,

    PRIMARY KEY (id),
    FOREIGN KEY (reciver_id_user_fk) REFERENCES user (id),
    FOREIGN KEY (giver_id_user_fk) REFERENCES user (id),
    FOREIGN KEY (experience_type_id_fk) REFERENCES experience_type(id)
);

-- DATA
INSERT INTO user_type(name,is_admin) VALUES ('Profesor',1),('Alumno',0);

SET @profesorId = (SELECT id FROM user_type WHERE name = 'Profesor');
SET @alumnoId = (SELECT id FROM user_type WHERE name = 'Alumno');

INSERT INTO user (nickname,fullname,email,passwd,user_type_id_fk)
    VALUES  ('klawx3','CEV','klawx3@asd.asd',SHA2('123',0), @profesorId),
            ('alumno1','asd1','alumno1@alumno.cl',SHA2('123',0),@alumnoId ),
            ('alumno2','asd2','alumno2@alumno.cl',SHA2('123',0),@alumnoId ),
            ('alumno3','asd3','alumno3@alumno.cl',SHA2('123',0),@alumnoId );

INSERT INTO experience_type VALUES  (NULL,'Test experience value 1',100),
                                    (NULL,'Test experience value 2',500);

-- TESTING
SET @giverUser = (SELECT id FROM user WHERE nickname = 'klawx3');
SET @reciverUser = (SELECT id FROM user WHERE nickname = 'alumno1');

CALL giveExperience(@giverUser,@reciverUser,1,'por bakan');
CALL giveExperience(@giverUser,@reciverUser,2,'por cool y bakan');
-- QUERY

SELECT SUM(exp_gained) 'total_exp'
FROM experience_historical
WHERE reciver_id_user_fk = (SELECT id FROM user WHERE nickname = 'klawx3');

SELECT
    CASE WHEN COUNT(*) > 0
    THEN true
    ELSE false
    END AS 'result'
FROM user
WHERE nickname = 'klawx3' AND passwd = SHA2('123',0);

-- BUSSINESS LOGIC

DELIMITER // -- DROP PROCEDURE giveExperience;
CREATE PROCEDURE giveExperience(_giver_id INT,_reciver_id INT,_experience_type_id INT, _reason TEXT)
BEGIN
    -- VARS
    DECLARE giverExists TINYINT(1);
    DECLARE reciverExists TINYINT(1);
    DECLARE experienceTypeExists TINYINT(1);
    DECLARE giverIsAdmin TINYINT(1);

    DECLARE gained_exp INT;

    -- VALUES
    SET giverExists = (SELECT COUNT(*) FROM user WHERE id = _giver_id );
    SET reciverExists = (SELECT COUNT(*) FROM user WHERE id = _reciver_id );
    SET experienceTypeExists = (SELECT COUNT(*) FROM experience_type WHERE id = _experience_type_id );
    SET giverIsAdmin = (SELECT COUNT(*) FROM user
                            INNER JOIN user_type ON user.user_type_id_fk = user_type.id
                            WHERE user.id = _giver_id AND user_type.is_admin = 1);
    IF giverExists = 1 THEN
        IF reciverExists = 1 THEN
            IF giverIsAdmin = 1 THEN
                IF experienceTypeExists = 1 THEN
                    -- CODE
                    SET gained_exp = (SELECT total_experience FROM experience_type WHERE id = _experience_type_id);

                    INSERT INTO experience_historical
                        VALUES (NULL,_reciver_id,_giver_id,_reason,gained_exp,_experience_type_id,now());
                ELSE
                    SELECT 'error experience type doent exist' AS 'result';
                END IF;
            ELSE
                SELECT 'error GIVER is NOT an ADMIN' AS 'result';
            END IF;
        ELSE
            SELECT 'error RECIVER id doest exist' AS 'result';
        END IF;
    ELSE
        SELECT 'error GIVER id doest exist' AS 'result';
    END IF;

END //
DELIMITER ;



