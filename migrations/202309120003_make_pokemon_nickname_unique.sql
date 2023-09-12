-- Update values in pokemon.nickname to become "Trainer's Pokemon" if they appear more than once
UPDATE pokemon
SET nickname = trainer.name || '''s ' || pokemon.nickname
FROM trainer
WHERE pokemon.trainer_id = trainer.id
AND nickname IN (
    SELECT nickname
    FROM pokemon
    GROUP BY nickname
    HAVING COUNT(*) > 1
);


-- Make pokemon nickname unique
ALTER TABLE pokemon
ADD CONSTRAINT unique_nickname UNIQUE (nickname);