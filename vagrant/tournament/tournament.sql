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


create view wins_v as 
	select win_id, count(win_id) as win_count
	from Matches
	group by win_id;

create view matches_v as
	select p.id, count(m.id) as match_count
	from Players p left join Matches m
		on p.id = m.win_id or p.id = m.los_id
		group by p.id;