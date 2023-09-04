CREATE TABLE IF NOT EXISTS pokemon (
    id SERIAL PRIMARY KEY,
    species_id INTEGER NOT NULL REFERENCES pokemon_species(id),
    nickname TEXT NOT NULL
);