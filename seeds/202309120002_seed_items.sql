-- Insert some sample items
INSERT INTO items (name)
VALUES ('Gym Badge - Pewter City'),
    ('Gym Badge - Cerulean City'),
    ('Pokeball'),
    ('Great Ball'),
    ('Ultra Ball') ON CONFLICT (name) DO NOTHING;
-- Insert some sample trainer-item relationships
INSERT INTO trainer_items (trainer_id, item_id, quantity)
VALUES (
        (
            SELECT id
            FROM trainer
            WHERE name = 'Ash'
        ),
        (
            SELECT id
            FROM items
            WHERE name = 'Gym Badge - Pewter City'
        ),
        1
    ),
    (
        (
            SELECT id
            FROM trainer
            WHERE name = 'Ash'
        ),
        (
            SELECT id
            FROM items
            WHERE name = 'Pokeball'
        ),
        10
    ),
    (
        (
            SELECT id
            FROM trainer
            WHERE name = 'Misty'
        ),
        (
            SELECT id
            FROM items
            WHERE name = 'Gym Badge - Cerulean City'
        ),
        1
    ),
    (
        (
            SELECT id
            FROM trainer
            WHERE name = 'Misty'
        ),
        (
            SELECT id
            FROM items
            WHERE name = 'Great Ball'
        ),
        5
    ) ON CONFLICT (trainer_id, item_id) DO
UPDATE
SET quantity = EXCLUDED.quantity;