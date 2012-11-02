CREATE TABLE IF NOT EXISTS players (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  name VARCHAR(50),
  email VARCHAR(128) UNIQUE,
  win INTEGER,
  loss INTEGER,
  draw INTEGER,
  created_at TIMESTAMP,
  updated_at TIMESTAMP DEFAULT (datetime('now','localtime'))

);

CREATE TABLE IF NOT EXISTS games (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  player1 INTEGER,
  player2 INTEGER,
  winner INTEGER,
  created_at TIMESTAMP,
  updated_at TIMESTAMP DEFAULT (datetime('now','localtime'))
);

CREATE TABLE IF NOT EXISTS game_moves (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  game_id INTEGER,
  player_id INTEGER,
  move VARCHAR(5),
  FOREIGN KEY (game_id) REFERENCES games(id),
  FOREIGN KEY (player_id) REFERENCES players(id)  
);

