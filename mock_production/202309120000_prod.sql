-- Insert new trainers
INSERT INTO trainer (name)
VALUES ('Dawn'),
    ('Brock') ON CONFLICT (name) DO NOTHING;
-- Insert new Pokémon species
INSERT INTO pokemon_species (name)
VALUES ('Turtwig'),
    ('Chimchar'),
    ('Piplup') ON CONFLICT (name) DO NOTHING;
-- Insert new Pokémon
INSERT INTO pokemon (species_id, nickname, trainer_id)
VALUES (
        (
            SELECT id
            FROM pokemon_species
            WHERE name = 'Turtwig'
        ),
        'Twiggy',
        (
            SELECT id
            FROM trainer
            WHERE name = 'Dawn'
        )
    ),
    (
        (
            SELECT id
            FROM pokemon_species
            WHERE name = 'Chimchar'
        ),
        'Chimmy',
        (
            SELECT id
            FROM trainer
            WHERE name = 'Dawn'
        )
    ),
    (
        (
            SELECT id
            FROM pokemon_species
            WHERE name = 'Piplup'
        ),
        'Pippy',
        (
            SELECT id
            FROM trainer
            WHERE name = 'Brock'
        )
    ) ON CONFLICT (nickname) DO NOTHING;
-- -- Insert new items
-- INSERT INTO items (name)
-- VALUES ('Heal Ball'),
--     ('Dusk Ball'),
--     ('Gym Badge - Oreburgh City') ON CONFLICT (name) DO NOTHING;
-- -- Insert new trainer-item relationships
-- INSERT INTO trainer_items (trainer_id, item_id, quantity)
-- VALUES (
--         (
--             SELECT id
--             FROM trainer
--             WHERE name = 'Dawn'
--         ),
--         (
--             SELECT id
--             FROM items
--             WHERE name = 'Heal Ball'
--         ),
--         5
--     ),
--     (
--         (
--             SELECT id
--             FROM trainer
--             WHERE name = 'Dawn'
--         ),
--         (
--             SELECT id
--             FROM items
--             WHERE name = 'Dusk Ball'
--         ),
--         3
--     ),
--     (
--         (
--             SELECT id
--             FROM trainer
--             WHERE name = 'Brock'
--         ),
--         (
--             SELECT id
--             FROM items
--             WHERE name = 'Gym Badge - Oreburgh City'
--         ),
--         1
--     ) ON CONFLICT (trainer_id, item_id) DO
-- UPDATE
-- SET quantity = EXCLUDED.quantity;