#!/usr/bin/env bash

source ./menu.sh

while true; do
    current_dir=$(pwd)

    connect="Connect to database with psql"
    schema="Show schema"
    dump_schema="Dump schema"
    get_pokemon_where_species="Get pokemon where species = foo"
    get_species_where_type="Get species where type = foo"
    get_pokemon_where_type="Get pokemon with type = foo"
    migrate="Mock live data and migrate"
    create="INIT: Create pokemon database"
    delete_db="WARNING: Delete pokemon database"
    exit="Exit"

    options=("$connect" "$schema" "$dump_schema" "$get_pokemon_where_species" "$get_species_where_type" "$get_pokemon_where_type" "$migrate" "$create" "$delete_db" "$exit")

    select_option "${options[@]}"
    result="${options[$?]}"
    
    echo -e "\n===============OUTPUT===============\n"
    echo "You chose: $result"

    case $result in
        "$connect")
            cd db-data/ || exit 1
            docker-compose exec db bash -c "psql -U justin -d pokemon"
            ;;

        "$schema")
            cd db-data/ || exit 1
            docker exec -i training---databases101-db-1 psql -U justin -d pokemon < ../queries/show_schema.sql
            ;;
        
        "$dump_schema")
            cd db-data/ || exit 1
            mkdir -p ../dumps
            docker exec -i training---databases101-db-1 bash -c "pg_dump -U justin -d pokemon --schema-only --file=/var/lib/postgresql/data/schema_dump.sql"
            docker cp training---databases101-db-1:/var/lib/postgresql/data/schema_dump.sql ../dumps/schema_dump.sql
            echo "Schema dumped to ../dumps/schema_dump.sql"
            ;;

        "$get_pokemon_where_species")
            cd db-data/ || exit 1
            docker exec -i training---databases101-db-1 psql -U justin -d pokemon < ../queries/get_pokemon_where_species.sql
            ;;

        "$get_species_where_type")
            cd db-data/ || exit 1
            docker exec -i training---databases101-db-1 psql -U justin -d pokemon < ../queries/get_pokemon_where_type.sql
            ;;
        
        "$get_pokemon_where_type")
            cd db-data/ || exit 1
            docker exec -i training---databases101-db-1 psql -U justin -d pokemon < ../queries/get_species_where_type.sql
            ;;
            
        "$migrate")
            cd db-data/ || exit 1
            # Make pokemon nickname unique
            docker exec -i training---databases101-db-1 psql -U justin -d pokemon < ../migrations/202309120003_make_pokemon_nickname_unique.sql
            # Add live data
            docker exec -i training---databases101-db-1 psql -U justin -d pokemon < ../mock_production/202309120000_prod.sql
            ;;

        "$create")
            cd db-data/ || exit 1
            # Create db
            docker exec -i training---databases101-db-1 psql -U justin -d postgres < ../migrations/202308170000_create_database.sql
            docker exec -i training---databases101-db-1 psql -U justin -d postgres < ../queries/check_database_exists.sql
            # Create pokemon species
            docker exec -i training---databases101-db-1 psql -U justin -d pokemon < ../migrations/202308181628_create_pokemon_species_table.sql
            docker exec -i training---databases101-db-1 psql -U justin -d pokemon < ../seeds/202308181628_populate_pokemon_species_table.sql
            docker exec -i training---databases101-db-1 psql -U justin -d pokemon < ../queries/get_all_species.sql
            # Create pokemon 
            docker exec -i training---databases101-db-1 psql -U justin -d pokemon < ../migrations/202308181628_create_pokemon_table.sql
            docker exec -i training---databases101-db-1 psql -U justin -d pokemon < ../seeds/202308181628_populate_pokemon_table.sql
            docker exec -i training---databases101-db-1 psql -U justin -d pokemon < ../queries/get_all_pokemon.sql
            # Create pokemon type
            docker exec -i training---databases101-db-1 psql -U justin -d pokemon < ../migrations/202309050000_create_pokemon_type_table.sql
            docker exec -i training---databases101-db-1 psql -U justin -d pokemon < ../seeds/202309050000_seed_pokemon_type.sql
            # Create type weakness
            docker exec -i training---databases101-db-1 psql -U justin -d pokemon < ../migrations/202309120000_create_type_weakness.sql
            docker exec -i training---databases101-db-1 psql -U justin -d pokemon < ../seeds/202309120000_seed_type_weakness.sql
            # Create trainer
            docker exec -i training---databases101-db-1 psql -U justin -d pokemon < ../migrations/202309120001_create_trainer.sql
            docker exec -i training---databases101-db-1 psql -U justin -d pokemon < ../seeds/202309120001_seed_trainer.sql
            # Create items
            docker exec -i training---databases101-db-1 psql -U justin -d pokemon < ../migrations/202309120002_create_items.sql
            docker exec -i training---databases101-db-1 psql -U justin -d pokemon < ../seeds/202309120002_seed_items.sql
            ;;

        "$delete_db")
            cd db-data/ || exit 1
            docker exec -i training---databases101-db-1 psql -U justin -d postgres < ../queries/drop_database.sql
            ;;

        "$exit")
            echo "Exiting..."
            break
            ;;

        *)
            print_error "Invalid option: $result"
            ;;
    esac

    cd "$current_dir" || exit 1
    echo -e "\n===============OUTPUT===============\n"
done
