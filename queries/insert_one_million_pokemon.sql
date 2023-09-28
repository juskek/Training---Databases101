DO $$ 
DECLARE
    i INTEGER := 0;
    species_id UUID;
    trainer_id UUID;
    target_count INTEGER := 1000000;

BEGIN
    -- Randomly select a species_id from the pokemon_species table
    SELECT id INTO species_id FROM pokemon_species ORDER BY RANDOM() LIMIT 1;

    IF (SELECT COUNT(*) FROM pokemon) < target_count THEN
        WHILE i < target_count LOOP
            SELECT id INTO trainer_id FROM trainer ORDER BY RANDOM() LIMIT 1;
            IF random() < 0.5 THEN
                trainer_id := NULL;
            END IF;

            INSERT INTO pokemon (id, species_id, nickname, trainer_id) 
            VALUES (uuid_generate_v4(), species_id, 'Pokemon_' || i::TEXT, trainer_id);

            i := i + 1;
            
            -- Raise a notice every 10,000 insertions
            IF i % 10000 = 0 THEN
                RAISE NOTICE 'Inserted % Pokémon', i;
            END IF;
        END LOOP;
    END IF;
    
END $$;
