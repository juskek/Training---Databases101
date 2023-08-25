DROP TABLE IF EXISTS pokemon;
CREATE TABLE pokemon (
    id SERIAL PRIMARY KEY,
    species_id INTEGER REFERENCES pokemon_species(id),
    nickname TEXT
);