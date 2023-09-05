SELECT *
FROM pokemon_species
-- Join species to junction table
JOIN species_type ON pokemon_species.id = species_type.species_id
-- Join type to junction table
JOIN pokemon_type ON species_type.type_id = pokemon_type.id
-- Filter
WHERE pokemon_type.name = 'Fire';
