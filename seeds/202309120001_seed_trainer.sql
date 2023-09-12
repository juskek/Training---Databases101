INSERT INTO trainer (name)
VALUES ('Ash'),
    ('Misty'),
    ('Brock') ON CONFLICT DO NOTHING;
INSERT INTO pokemon (species_id, nickname, trainer_id)
VALUES (
        (
            SELECT id
            FROM pokemon_species
            WHERE name = 'Pikachu'
        ),
        'Sparky',
        (
            SELECT id
            FROM trainer
            WHERE name = 'Ash'
        )
    ),
    (
        (
            SELECT id
            FROM pokemon_species
            WHERE name = 'Bulbasaur'
        ),
        'Bulby',
        (
            SELECT id
            FROM trainer
            WHERE name = 'Ash'
        )
    ),
    (
        (
            SELECT id
            FROM pokemon_species
            WHERE name = 'Charmander'
        ),
        'Flame',
        (
            SELECT id
            FROM trainer
            WHERE name = 'Ash'
        )
    ),
    (
        (
            SELECT id
            FROM pokemon_species
            WHERE name = 'Squirtle'
        ),
        'Squirt',
        (
            SELECT id
            FROM trainer
            WHERE name = 'Misty'
        )
    ) ON CONFLICT DO NOTHING;