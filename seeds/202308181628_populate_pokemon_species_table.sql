INSERT INTO pokemon_species (name)
VALUES ('Pikachu'),
    ('Bulbasaur'),
    ('Charmander'),
    ('Squirtle') ON CONFLICT (name) DO NOTHING;