CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

-- A species can belong to many types (e.g. `Bulbasaur` is grass and poison).
-- A type relates to many species (e.g. both `Bulbasaur` and `Ivysaur` are grass type).
-- Therefore, many-to-many relation between pokemon_type and pokemon_species

CREATE TABLE IF NOT EXISTS pokemon_type (
    id UUID DEFAULT uuid_generate_v4() PRIMARY KEY,
    name TEXT NOT NULL UNIQUE
);

-- Create junction table to relate pokemon_species and pokemon_type

CREATE TABLE species_type (
    species_id UUID REFERENCES pokemon_species(id),
    type_id UUID REFERENCES pokemon_type(id),
    PRIMARY KEY (species_id, type_id)
);
