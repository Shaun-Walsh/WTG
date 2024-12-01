-- -----------------------------------------------------
-- Drop the 'boardgameGroup' database/schema
-- -----------------------------------------------------

DROP SCHEMA IF EXISTS boardgameGroup;
-- -----------------------------------------------------
-- Create 'boardgameGroup' database/schema and use this database
-- -----------------------------------------------------


CREATE SCHEMA IF NOT EXISTS boardgameGroup;

USE boardgameGroup;

-- -----------------------------------------------------
-- Create table Members
-- -----------------------------------------------------

CREATE TABLE Members (
 membershipId SMALLINT UNSIGNED NOT NULL AUTO_INCREMENT,
 fName VARCHAR(20) NOT NULL,
 lName VARCHAR(20) NOT NULL,
 phoneNumber VARCHAR(15),
 email VARCHAR (50),
 supervisorId SMALLINT UNSIGNED,
 PRIMARY KEY (membershipId),
 FOREIGN KEY (supervisorId) REFERENCES Members (membershipId)
);

-- -----------------------------------------------------
-- Create table Guest
-- -----------------------------------------------------

CREATE TABLE Guest(
 phoneNumber VARCHAR(15),
 fName VARCHAR(20) NOT NULL,
 lName VARCHAR(20) NOT NULL,
 guestId SMALLINT UNSIGNED NOT NULL AUTO_INCREMENT,
 membershipId SMALLINT UNSIGNED NOT NULL,
 PRIMARY KEY (guestId),
 FOREIGN KEY (membershipId) REFERENCES Members(membershipId) ON DELETE CASCADE
);

-- -----------------------------------------------------
-- Create Table venue
-- -----------------------------------------------------

CREATE TABLE venue( 
 phoneNumber VARCHAR(15) NOT NULL,
 nameOfVenue VARCHAR(100) NOT NULL,
 contactPerson VARCHAR (50),
 address VARCHAR (500),
 PRIMARY KEY (phoneNumber)
);

-- -----------------------------------------------------
-- Create Table sponsor
-- -----------------------------------------------------

CREATE TABLE sponsor( 
 sponsorName VARCHAR(100) NOT NULL,
 idNumber SMALLINT UNSIGNED,
 contactPerson VARCHAR (50),
 phoneNumber VARCHAR(15) NOT NULL,
 PRIMARY KEY (sponsorName)
);
-- -----------------------------------------------------
-- Create Table Event
-- -----------------------------------------------------

CREATE TABLE `Event` ( 
 eventId SMALLINT UNSIGNED NOT NULL AUTO_INCREMENT,
 style VARCHAR(50) NOT NULL,
 `date` DATETIME NOT NULL,
 phoneNumber VARCHAR(15),
 sponsorName VARCHAR(50),
 PRIMARY KEY (eventId),
 FOREIGN KEY (phoneNumber) REFERENCES Venue(phoneNumber) ON DELETE CASCADE,
 FOREIGN KEY (sponsorName) REFERENCES Sponsor(sponsorName) ON DELETE CASCADE
);

-- -----------------------------------------------------
-- Create table numberOfAttendees
-- -----------------------------------------------------

CREATE TABLE numberOfAttendees(
 guestId SMALLINT UNSIGNED NOT NULL,
 membershipId SMALLINT UNSIGNED NOT NULL,
 eventId SMALLINT UNSIGNED NOT NULL,
 PRIMARY KEY (membershipId, eventId, guestId),
 FOREIGN KEY (membershipId) REFERENCES Members (membershipId),
 FOREIGN KEY (guestId) REFERENCES Guest (guestId),
 FOREIGN KEY (eventId) REFERENCES Event (eventId)
 ON UPDATE CASCADE 
 ON DELETE CASCADE
);

-- -----------------------------------------------------
-- Create table Game
-- -----------------------------------------------------

CREATE TABLE Game( 
 gameId SMALLINT UNSIGNED NOT NULL AUTO_INCREMENT,
 name VARCHAR(100) NOT NULL,
 minPlayer TINYINT UNSIGNED,
 maxPlayer TINYINT UNSIGNED,
 duration SMALLINT UNSIGNED,
 attribute ENUM('Boardgame', 'CCG', 'RPG'),
 complexity VARCHAR (50),
 cost DECIMAL(5,2),
 membershipId SMALLINT UNSIGNED NOT NULL,
 PRIMARY KEY (gameId),
 FOREIGN KEY (membershipId) REFERENCES Members(membershipId) ON DELETE CASCADE
);

-- -----------------------------------------------------
-- Create table BoardGame 
-- -----------------------------------------------------

CREATE TABLE boardGame(
 gameId SMALLINT UNSIGNED NOT NULL,
 subgenre ENUM('Abstract Strategy', 'Eurogame', 'Ameritrash', 'Party', 'Cooperative', 'Thematic','Deck-building', 'Tile Placement', 'Worker Placement', 'Dexterity', 'Trivia', 'Racing', 'Social Deduction', 'Auction', 'Miniatures', 'Economic'),
 PRIMARY KEY (gameId),
 FOREIGN KEY (gameId) REFERENCES Game(gameId) ON UPDATE CASCADE ON DELETE CASCADE
);

-- -----------------------------------------------------
-- Create table CCG
-- -----------------------------------------------------

CREATE TABLE CCG(
 gameId SMALLINT UNSIGNED NOT NULL,
 brand ENUM('Magic: The Gathering', 'Yu-Gi-Oh!', 'Pokemon TCG', 'Hearthstone', 'KeyForge', 'Star Wars: Destiny', 'Flesh and Blood', 'The Lord of the Rings: The Card Game', 'Legend of the Five Rings', 'Dragons: The Card Game', 'Vampire: The Eternal Struggle', 'Android: Netrunner', 'Gwent', 'Force of Will', 'Artifacts'),
 PRIMARY KEY (gameId),
 FOREIGN KEY (gameId) REFERENCES Game(gameId) ON UPDATE CASCADE ON DELETE CASCADE
);

-- -----------------------------------------------------
-- Create table RPG
-- -----------------------------------------------------

CREATE TABLE RPG(
 gameId SMALLINT UNSIGNED NOT NULL,
 `system` ENUM('Dungeons & Dragons', 'Pathfinder', 'Call of Cthulhu', 'Shadowrun', 'World of Darkness', 'Warhammer Fantasy Roleplay', 'GURPS', 'Star Wars RPG', 'Fiasco', 'Cyberpunk 2020', 'Savage Worlds', 'Dungeon World', 'Blades in the Dark', 'Edge of the Empire', 'Vampire: The Masquerade'),
 PRIMARY KEY (gameId),
 FOREIGN KEY (gameId) REFERENCES Game(gameId) ON UPDATE CASCADE ON DELETE CASCADE
);

-- -----------------------------------------------------
-- Create Table available
-- -----------------------------------------------------

CREATE TABLE available( 
 eventId SMALLINT UNSIGNED NOT NULL,
 gameId SMALLINT UNSIGNED NOT NULL,
 PRIMARY KEY (eventId, gameId),
 FOREIGN KEY (eventId) REFERENCES event(eventId) ON DELETE CASCADE,
 FOREIGN KEY (gameId) REFERENCES game(gameId) ON DELETE CASCADE
);

-- -----------------------------------------------------
-- Creating Indexes
-- -----------------------------------------------------

CREATE INDEX gameNameInd on game(name);
CREATE INDEX gameGenreInd on boardgame(subgenre);
CREATE INDEX ccgBrandInd on ccg(brand);
CREATE INDEX rpgSystemInd on rpg(`system`);
CREATE INDEX eventDateInd on event(date);
CREATE INDEX guestFNameInd on guest(fName);
CREATE INDEX guestLNameInd on guest(lName);
CREATE INDEX memberFNameInd on guest(fName);
CREATE INDEX memberLNameInd on guest(lName);
CREATE INDEX idNumberInd on sponsor(idNumber);
CREATE INDEX venueNameInd on venue(nameOfVenue);


use boardgamegroup;

-- -----------------------------------------------------
-- Populate table Members 
-- -----------------------------------------------------

INSERT INTO members (fName, lName, phoneNumber, email, supervisorId) VALUES 
('Shaun', 'Walsh', '088123456789', 'sw@wtg.com', 1),
('Mary', 'Lyng', '088987654321', 'ml@setugaming.com', 2),
('Rosanne', 'Bierney', '088321654987', 'rb@setugaming.com', NULL),
('Frank', 'Walsh', '088789456123', 'fw@setugmaing.com', NULL),
('Caroline', 'Cahill', '088741852963', 'cc@setugaming.com', 3);

-- -----------------------------------------------------
-- Populate table Guest 
-- -----------------------------------------------------

INSERT INTO guest (phoneNumber, fName, lName, membershipId) VALUES 
('081123456789','Peter', 'Fortune', '1'),
('081987654321','Aisling', 'White', '2'),
('081741852963', 'Damien', 'Kirwan', '3');

-- -----------------------------------------------------
-- Populate table Venue 
-- -----------------------------------------------------

INSERT INTO venue VALUES
('051987654', 'Robinsons', 'Cathal O Hehir', 'Summerhill, Tramore'),
('051741852', 'Victoria House', 'John Kehoe', 'Queen Street, Tramore'),
('051369258', 'Geoffs', 'John Fitzgerald', 'Apple Market, Waterford');

-- -----------------------------------------------------
-- Populate table Sponsor 
-- -----------------------------------------------------

INSERT INTO sponsor VALUES
('Happygolucky', 1, 'Gildas Detournaay', '021789456'),
('Waterford Comics', 2, 'Tony Power', '051456789'),
('Dungeons & Donuts', 3, 'Terrence Foy', '062963789');

-- -----------------------------------------------------
-- Populate table Event 
-- -----------------------------------------------------

INSERT INTO `event` (style, `date`, phoneNumber, sponsorName) Values
('Newcomers', '2024-12-01 19:00:00', '051987654', 'Happygolucky'),
('Heavy Euros', '2024-12-15 20:00:00', '051741852', 'Waterford Comics'),
('Role Playing', '2025-01-10 15:00:00', '051369258', 'Dungeons & Donuts'),
('Card Games', '2025-02-14 18:00:00', '051987654', 'Happygolucky');

-- -----------------------------------------------------
-- Populate table numberOfAttendees 
-- -----------------------------------------------------

INSERT INTO numberofAttendees VALUES
(1,1,1),
(2,2,2),
(3,3,3);

-- -----------------------------------------------------
-- Populate table Game
-- -----------------------------------------------------

INSERT INTO game (name, minPlayer, maxPlayer, duration, attribute, complexity, cost, membershipId) VALUES 
('Oath', 1, 6, 150, 'Boardgame', 'High', 99.99, 1),
('Android: Netrunner', 2, 2, 30, 'CCG', 'High', 19.99, 2),
('Dungeons & Dragons', 3, 6, 180, 'RPG', 'Varies', 49.99, 3),
('Cascadia', 2, 6, 60, 'Boardgame', 'Low', 34.99, 4),
('Nemesis', 1, 5, 180, 'Boardgame', 'Medium', 154.99, 5);

-- -----------------------------------------------------
-- Populate table Boardgame
-- -----------------------------------------------------

INSERT INTO BoardGame VALUES 
(1, 'Eurogame'),
(4, 'Tile Placement'),
(5, 'Ameritrash');

-- -----------------------------------------------------
-- Populate table CCG
-- -----------------------------------------------------

INSERT INTO ccg VALUES 
(2, 'Android: Netrunner');

-- -----------------------------------------------------
-- Populate table RPG
-- -----------------------------------------------------

INSERT INTO rpg VALUES 
(3, 'Dungeons & Dragons');


-- -----------------------------------------------------
-- Populate table Available
-- -----------------------------------------------------

INSERT INTO available VALUES 
(1, 4),
(2, 1),
(3, 3),
(4, 4);

-- -----------------------------------------------------------------------
-- Create view to show details about Games and their owners
-- -----------------------------------------------------------------------
CREATE OR REPLACE VIEW GameDetails AS
SELECT CONCAT(fName, " ", lName) AS "Member Name", phoneNumber, email, members.membershipId, name, minPlayer, maxPlayer, duration, attribute AS "Type", complexity, cost
FROM members LEFT JOIN game
ON members.membershipId = game.membershipId;


-- -----------------------------------------------------------------------
-- Create view to show details about Events, venues, and Sponsors
-- -----------------------------------------------------------------------
CREATE OR REPLACE VIEW SponsorEventDetails AS
SELECT sponsor.sponsorName, venue.contactPerson, sponsor.phoneNumber, style, date, nameOfVenue, address AS "Location"
FROM sponsor JOIN event
ON sponsor.sponsorName = event.sponsorName
JOIN venue 
ON event.phoneNumber = venue.phoneNumber;

-- -----------------------------------------------------------------------
-- Create trigger to set the minimum player count
-- -----------------------------------------------------------------------
DELIMITER $$

CREATE TRIGGER SetDefaultMinPlayer
BEFORE INSERT ON Game
FOR EACH ROW
BEGIN
    IF NEW.minPlayer IS NULL THEN
        SET NEW.minPlayer = 1;
    END IF;
END $$

DELIMITER ;

-- -----------------------------------------------------------------------
-- Create trigger to track changes to a game
-- -----------------------------------------------------------------------
CREATE TABLE game_audit (
    id INT AUTO_INCREMENT PRIMARY KEY,
    minPlayer TINYINT UNSIGNED,
    maxPlayer TINYINT UNSIGNED,
    duration SMALLINT UNSIGNED,
    changedate DATETIME DEFAULT NULL,
    action VARCHAR(50) DEFAULT NULL
);

DELIMITER $$
CREATE TRIGGER before_game_update 
    BEFORE UPDATE ON game
    FOR EACH ROW 
BEGIN
    INSERT INTO game_audit
    SET action = 'update',
       minPlayer  = OLD.minPlayer,
	   maxPlayer = OLD.maxPlayer,
        changedate = NOW(); 
END $$
DELIMITER ; 

-- --------------------------------------------------------------------------------------
-- Creating Users
-- --------------------------------------------------------------------------------------
CREATE USER WTG IDENTIFIED BY 'gamer';
 
CREATE USER Member IDENTIFIED BY 'player';

-- ------------------------------------------------------------------------------------------------
-- Granting Permissions: WTG has access to everything, member can only update and select from Games
-- ------------------------------------------------------------------------------------------------
 GRANT ALL ON boardgamegroup.* TO WTG WITH GRANT OPTION;

 GRANT INSERT, UPDATE, DELETE, SELECT on game to Member;
  
COMMIT;