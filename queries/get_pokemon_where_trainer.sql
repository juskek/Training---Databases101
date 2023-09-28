SELECT * 
FROM pokemon
JOIN trainer ON pokemon.trainer_id = trainer.id 
WHERE trainer.name = 'Ash';