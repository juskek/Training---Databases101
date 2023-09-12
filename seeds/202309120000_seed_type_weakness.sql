INSERT INTO type_weakness (type_id, weak_against_id)
VALUES (
        (
            SELECT id
            FROM pokemon_type
            WHERE name = 'Fire'
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
            FROM pokemon_type
            WHERE name = 'Water'
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
            FROM pokemon_type
            WHERE name = 'Grass'
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
            FROM pokemon_type
            WHERE name = 'Electric'
        ),
        (
            SELECT id
            FROM pokemon_type
            WHERE name = 'Ground'
        )
    ) ON CONFLICT (type_id, weak_against_id) DO NOTHING;