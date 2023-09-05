SELECT *
FROM pokemon
JOIN pokemon_species ON pokemon.species_id = pokemon_species.id
WHERE pokemon_species.name = 'Pikachu';