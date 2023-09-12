-- A trainer can have many items
-- An item can be owned by many players
-- Therefore, many-to-many relation between trainer and items
-- Create the items table
CREATE TABLE IF NOT EXISTS items (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    name TEXT NOT NULL UNIQUE
);
-- Create the trainer_items junction table
CREATE TABLE IF NOT EXISTS trainer_items (
    trainer_id UUID NOT NULL REFERENCES trainer(id),
    item_id UUID NOT NULL REFERENCES items(id),
    quantity INT NOT NULL DEFAULT 1,
    PRIMARY KEY (trainer_id, item_id)
);
