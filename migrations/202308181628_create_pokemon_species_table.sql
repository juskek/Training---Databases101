CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

CREATE TABLE IF NOT EXISTS pokemon_species (
    id UUID DEFAULT uuid_generate_v4(),
    name TEXT UNIQUE NOT NULL
);