-- A type can have many weaknesses (e.g. grass is weak to fire, bug)
-- A type can be strong to many types (e.g. grass is strong against water, ground)
-- Therefore, many-to-many relation between pokemon_type and pokemon_type


-- Create junction table to relate pokemon_type and pokemon_type

CREATE TABLE IF NOT EXISTS type_weakness (
    type_id UUID NOT NULL REFERENCES pokemon_type(id),
    weak_against_id UUID NOT NULL REFERENCES pokemon_type(id),
    PRIMARY KEY (type_id, weak_against_id)
);
