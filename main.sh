#!/usr/bin/env bash

source ./menu.sh

while true; do
    current_dir=$(pwd)

    connect="Connect to database with psql"
    schema="Show schema"
    get_pokemon_with_species_name="Get all pokemon with a particular species name"
    create="INIT: Create pokemon database"
    init_pokemon_species="INIT: Create, seed and view pokemon_species table"
    init_pokemon_table="INIT: Create, seed and view pokemon table"
    init_pokemon_type_table="INIT: Create, migrate, seed and view pokemon species table"
    delete_db="WARNING: Delete pokemon database"
    exit="Exit"

    options=("$connect" "$schema" "$get_pokemon_with_species_name" "$create"  "$init_pokemon_species" "$init_pokemon_table" "$init_pokemon_type_table" "$delete_db" "$exit")

    select_option "${options[@]}"
    result="${options[$?]}"
    
    echo -e "\n===============OUTPUT===============\n"
    echo "You chose: $result"

    case $result in
        "$connect")
            cd db-data/ || exit 1
            # Equivalent to
            # terminal --> docker compose exec db bash
            # docker --> psql -U justin -d pokemon
            docker-compose exec db bash -c "psql -U justin -d pokemon"
            ;;

        "$schema")
            cd db-data/ || exit 1

            cat ../queries/show_schema.sql | docker exec -i training---databases101-db-1 psql -U justin -d pokemon
        
            ;;

        "$get_pokemon_with_species_name")
            cd db-data/ || exit 1

            cat ../queries/get_pokemon_where_species.sql | docker exec -i training---databases101-db-1 psql -U justin -d pokemon
        
            ;;

        "$create")
            cd db-data/ || exit 1

            cat ../migrations/202308170000_create_database.sql | docker exec -i training---databases101-db-1 psql -U justin -d postgres
            cat ../queries/check_database_exists.sql | docker exec -i training---databases101-db-1 psql -U justin -d postgres
            ;;

        "$init_pokemon_species")
            cd db-data/ || exit 1
            # Create table
            cat ../migrations/202308181628_create_pokemon_species_table.sql | docker exec -i training---databases101-db-1 psql -U justin -d pokemon

            # Seed table
            cat ../seeds/202308181628_populate_pokemon_species_table.sql | docker exec -i training---databases101-db-1 psql -U justin -d pokemon

            # Select all records
            cat ../queries/get_all_species.sql | docker exec -i training---databases101-db-1 psql -U justin -d pokemon
            ;;

        "$init_pokemon_table")
            cd db-data/ || exit 1
            # Create table
            cat ../migrations/202308181628_create_pokemon_table.sql | docker exec -i training---databases101-db-1 psql -U justin -d pokemon

            # Seed table
            cat ../seeds/202308181628_populate_pokemon_table.sql | docker exec -i training---databases101-db-1 psql -U justin -d pokemon

            # Select all records
            cat ../queries/get_all_pokemon.sql | docker exec -i training---databases101-db-1 psql -U justin -d pokemon
            ;;
        
        "$init_pokemon_type_table")
            cd db-data/ || exit 1
            # Create and migrate table
            cat ../migrations/202309050000_create_pokemon_type_table.sql | docker exec -i training---databases101-db-1 psql -U justin -d pokemon

            # Seed table
            cat ../seeds/202309050000_seed_pokemon_type.sql | docker exec -i training---databases101-db-1 psql -U justin -d pokemon
            ;;

        "$delete_db")
            cd db-data/ || exit 1

            cat ../queries/drop_database.sql | docker exec -i training---databases101-db-1 psql -U justin -d postgres
            ;;

        "$exit")  # Add this case
            echo "Exiting..."
            break  # This will break the while loop and exit
            ;;

        *)
            print_error "Invalid option: $result"
            ;;
    esac

    cd "$current_dir" || exit 1 # return to previous dir
    echo -e "\n===============OUTPUT===============\n"
done