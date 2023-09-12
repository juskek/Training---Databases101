-- A trainer can have many pokemon
-- A pokemon can only have one trainer
-- Therefore, one-to-many relation between trainer and pokemon

-- Create the trainer table
CREATE TABLE IF NOT EXISTS trainer (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    name TEXT NOT NULL UNIQUE
);
-- Alter the pokemon table to add a trainer_id column
ALTER TABLE pokemon
ADD COLUMN IF NOT EXISTS trainer_id UUID,
    ADD FOREIGN KEY (trainer_id) REFERENCES trainer(id);