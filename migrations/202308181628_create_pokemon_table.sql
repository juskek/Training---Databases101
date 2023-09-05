CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

CREATE TABLE IF NOT EXISTS pokemon (
    id UUID DEFAULT uuid_generate_v4() PRIMARY KEY,
    species_id UUID NOT NULL REFERENCES pokemon_species(id),
    nickname TEXT NOT NULL
);
