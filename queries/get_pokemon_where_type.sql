SELECT *
FROM pokemon
-- Join pokemon to species table
JOIN pokemon_species ON pokemon.species_id = pokemon_species.id
-- Join species to junction table
JOIN species_type ON pokemon_species.id = species_type.species_id
-- Join type to junction table
JOIN pokemon_type ON species_type.type_id = pokemon_type.id
-- Filter
WHERE pokemon_type.name = 'Fire';


-- Instead of a triple join, you can JOIN directly from pokemon.species_id to species_type.species_id