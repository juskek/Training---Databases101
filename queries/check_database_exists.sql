DO $$
DECLARE 
    db_exists BOOLEAN;
BEGIN 
    SELECT INTO db_exists 
    EXISTS (
        SELECT 1 
        FROM pg_database 
        WHERE datname='pokemon'
    );

    IF db_exists THEN 
        RAISE NOTICE 'Pokemon database successfully created';
    ELSE 
        RAISE NOTICE 'Database does not exist';
    END IF; 
END $$;
