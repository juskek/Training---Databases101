INSERT INTO pokemon (species_id, nickname)
VALUES ((SELECT id FROM pokemon_species WHERE name = 'Pikachu'),'I Pikachuse You'),
    ((SELECT id FROM pokemon_species WHERE name = 'Charmander'),'I Charmander Your Socks Off'),
    ((SELECT id FROM pokemon_species WHERE name = 'Squirtle'),'And Squirtle On'),
    ((SELECT id FROM pokemon_species WHERE name = 'Pikachu'),'I Pikarefuse'),
    ((SELECT id FROM pokemon_species WHERE name = 'Charmander'),'You aint got no Charmander');