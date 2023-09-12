-- Insert pokemon types
INSERT INTO pokemon_type (name)
VALUES ('Normal'),
    ('Fire'),
    ('Water'),
    ('Electric'),
    ('Grass'),
    ('Ice'),
    ('Fighting'),
    ('Poison'),
    ('Ground'),
    ('Flying'),
    ('Psychic'),
    ('Bug'),
    ('Rock'),
    ('Ghost'),
    ('Dragon'),
    ('Dark'),
    ('Steel'),
    ('Fairy') ON CONFLICT (name) DO NOTHING;

-- Insert pokemon species
INSERT INTO pokemon_species (name)
VALUES ('Lanturn') ON CONFLICT (name) DO NOTHING;
-- Relate species and types in junction table
INSERT INTO species_type (species_id, type_id)
VALUES (
        (
            SELECT id
            FROM pokemon_species
            WHERE name = 'Pikachu'
        ),
        (
            SELECT id
            FROM pokemon_type
            WHERE name = 'Electric'
        )
    ),
    (
        (
            SELECT id
            FROM pokemon_species
            WHERE name = 'Charmander'
        ),
        (
            SELECT id
            FROM pokemon_type
            WHERE name = 'Fire'
        )
    ),
    (
        (
            SELECT id
            FROM pokemon_species
            WHERE name = 'Squirtle'
        ),
        (
            SELECT id
            FROM pokemon_type
            WHERE name = 'Water'
        )
    ),
    (
        (
            SELECT id
            FROM pokemon_species
            WHERE name = 'Lanturn'
        ),
        (
            SELECT id
            FROM pokemon_type
            WHERE name = 'Water'
        )
    );