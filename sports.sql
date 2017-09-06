CREATE TABLE players (
  id INTEGER PRIMARY KEY,
  fname VARCHAR(255) NOT NULL,
  lname VARCHAR(255) NOT NULL,
  team_id INTEGER,

  FOREIGN KEY(team_id) REFERENCES teams(id)
);

CREATE TABLE teams (
  id INTEGER PRIMARY KEY,
  name VARCHAR(255) NOT NULL,
  city_id INTEGER,

  FOREIGN KEY(city_id) REFERENCES cities(id)
);

CREATE TABLE cities (
  id INTEGER PRIMARY KEY,
  name VARCHAR(255) NOT NULL
);

INSERT INTO
  cities (id, name)
VALUES
  (1, "Los Angeles"), (2, "New York");

INSERT INTO
  teams (id, name, city_id)
VALUES
  (1, "Lakers", 1),
  (2, "Clippers", 1),
  (3, "Dodgers", 1),
  (4, "Knicks", 2),
  (5, "Mets", 2);
  (6, "Bulls", NULL);

INSERT INTO
  players (id, name, team_id)
VALUES
  (1, "Lonzo", "Ball" 1),
  (2, "Brandon", "Ingram", 1),
  (3, "Cody", "Bellinger", 2),
  (4, "Kristaps", "Porzingis", 3),
  (5, "Carmelo", "Anthony", 3),
  (6, "Noah", "Syndergaard", 4),
  (7, "Steph", "Curry", NULL);
