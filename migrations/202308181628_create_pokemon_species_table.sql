DROP TABLE IF EXISTS pokemon_species;
CREATE TABLE pokemon_species (
    id SERIAL PRIMARY KEY,
    name TEXT UNIQUE
);