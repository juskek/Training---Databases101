CREATE TABLE IF NOT EXISTS pokemon (
    id SERIAL PRIMARY KEY,
    species_id INTEGER REFERENCES pokemon_species(id),
    nickname TEXT
);