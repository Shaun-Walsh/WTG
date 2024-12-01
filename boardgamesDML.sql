
use boardgamegroup;

-- -----------------------------------------------------
-- Simple select statements for diplaying popular data
-- -----------------------------------------------------
SELECT * 
FROM members; 

SELECT * 
FROM event;

SELECT * 
FROM game;

SELECT * 
FROM venue;

SELECT * 
FROM sponsor;

-- --------------------------------------------------------------
-- Select statement to display playtime between a certain length
-- --------------------------------------------------------------
SELECT * 
FROM game 
WHERE duration BETWEEN 60 AND 150;

-- --------------------------------------------------------------
-- Select statement to display only supervisor members
-- --------------------------------------------------------------
SELECT CONCAT(fName, " ", lName) as "Name"
FROM members
WHERE supervisorId is not null;

-- ------------------------------------------------------------------
-- Select statement to display members affiliated with certain group
-- ------------------------------------------------------------------
SELECT CONCAT(fName, " ", lName) as "Name", phoneNumber, email
FROM members
WHERE email like "%@wtg%.com";

-- ------------------------------------------------------------------
-- Select statement to display members not affiliated with wtg
-- ------------------------------------------------------------------
SELECT CONCAT(fName, " ", lName) as "Name", phoneNumber, email
FROM members
WHERE email NOT like "%@wtg%.com";

-- ------------------------------------------------------------------
-- Select statement to display only High compelxity games
-- ------------------------------------------------------------------
SELECT *
FROM game
WHERE complexity IN ("High");

-- ------------------------------------------------------------------
-- Select statement to display game that are not High Complexity
-- ------------------------------------------------------------------
SELECT *
FROM game
WHERE complexity NOT IN ("High")
ORDER BY minplayer;

-- ------------------------------------------------------------------
-- Select only future events 
-- ------------------------------------------------------------------
SELECT *
FROM event
where `date` > CURRENT_DATE;

-- ------------------------------------------------------------------
-- Dispay the total number games in the library
-- ------------------------------------------------------------------
SELECT COUNT(gameId) as "Number of Games"
FROM game;

-- ------------------------------------------------------------------
-- Dispay the average price of Board Games in the library
-- ------------------------------------------------------------------
SELECT ROUND(AVG(cost), 2) AS 'Average Boardgame Cost' 
FROM game
WHERE attribute = 'Boardgame';

-- ------------------------------------------------------------------
-- Group games by attribute type
-- ------------------------------------------------------------------
SELECT attribute, COUNT(attribute) as "Total"
FROM game
GROUP BY attribute;

-- ------------------------------------------------------------------
-- Display most expensive for least expensive for each type of game 
-- ------------------------------------------------------------------
SELECT attribute, MAX(cost) AS 'Most expensive price', 
       MIN(cost) AS 'Least expensive' 
FROM game
GROUP BY attribute 
HAVING MAX(cost) >=1;

-- ------------------------------------------------------------------
-- Display details for member and the guests they brought
-- ------------------------------------------------------------------
SELECT CONCAT(members.fName, " ", members.lName) AS "Member Name", CONCAT(guest.fName, " ", guest.lName) AS "Guest Name"
FROM members JOIN guest
ON members.membershipId = guest.membershipId;

-- ------------------------------------------------------------------
-- Display details for Event, the sponsor, and the venue
-- ------------------------------------------------------------------
SELECT style AS "Event Style", date, event.sponsorName AS "Sponsor", sponsor.phoneNumber AS "Sponsor Phone Number", nameOfVenue AS "Venue", address AS "Location"
FROM event JOIN sponsor
ON event.sponsorName = sponsor.sponsorName
JOIN venue
ON event.phoneNumber = venue.phoneNumber
ORDER BY date;

-- -----------------------------------------------------------------------
-- Display details for games available at a given event and who owns them
-- -----------------------------------------------------------------------
SELECT name, attribute AS "Type", style, date, CONCAT(fName, " ", lName) AS Owner
FROM available JOIN game
ON game.gameId = available.gameId
JOIN event
ON available.eventId = event.eventId
JOIN members
ON game.membershipId = members.membershipId
ORDER BY date;

-- -----------------------------------------------------------------------
-- Display all members and the events they have attended
-- -----------------------------------------------------------------------
SELECT CONCAT(fName, " ", lName) as "Member Name", style, date
FROM members RIGHT JOIN numberofattendees
ON members.membershipId = numberofattendees.membershipId
RIGHT JOIN event
ON numberofattendees.eventId = event.eventId;

-- -----------------------------------------------------------------------
-- Display all members and the games they own
-- -----------------------------------------------------------------------
SELECT CONCAT(fName, " ", lName) as "Member Name", name, attribute AS "Type"
FROM members LEFT JOIN game
ON members.membershipId = game.membershipId
ORDER BY fname;

-- -----------------------------------------------------------------------
-- Display games whose price is greater than the average price
-- -----------------------------------------------------------------------
SELECT name, cost 
FROM game 
WHERE cost > (SELECT avg(cost) from game);
