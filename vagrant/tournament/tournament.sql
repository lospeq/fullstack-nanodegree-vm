-- Table definitions for the tournament project.
--
-- Put your SQL 'create table' statements in this file; also 'create view'
-- statements if you choose to use it.
--
-- You can write comments in this file by starting them with two dashes, like
-- these lines here.

CREATE DATABASE tournament;
\c tournament;

CREATE TABLE Players(
id SERIAL PRIMARY KEY,
name TEXT);

CREATE TABLE Matches(
	id SERIAL PRIMARY KEY,
	win_id INTEGER REFERENCES Players(id),
	los_id INTEGER REFERENCES Players(id));

CREATE VIEW wins_v AS 
	SELECT win_id, COUNT(win_id) AS win_count
	FROM Matches
	GROUP BY win_id;

CREATE VIEW matches_v AS
	SELECT p.id, count(m.id) AS match_count
	FROM Players p LEFT JOIN Matches m
		ON p.id = m.win_id OR p.id = m.los_id
		GROUP BY p.id;