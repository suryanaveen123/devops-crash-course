-- Three-tier demo: initial schema and data
CREATE TABLE IF NOT EXISTS items (
  id   SERIAL PRIMARY KEY,
  name VARCHAR(255) NOT NULL
);

INSERT INTO items (name) VALUES ('Item One'), ('Item Two'), ('Item Three');
