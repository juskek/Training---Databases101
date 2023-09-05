#!/usr/bin/env bash

source ./menu.sh

while true; do
    current_dir=$(pwd)

    connect="Connect to database with psql"
    schema="Show schema"
    init_pokemon_species="Create, seed and view pokemon_species table"
    init_pokemon_table="Create, seed and view pokemon table"
    create="INIT: Create pokemon database"
    delete_db="WARNING: Delete pokemon database"
    exit="Exit"

    options=("$connect" "$schema" "$init_pokemon_species" "$init_pokemon_table" "$create" "$delete_db" "$exit")

    select_option "${options[@]}"
    result="${options[$?]}"

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
            
        "$create")
            cd db-data/ || exit 1

            cat ../migrations/202308170000_create_database.sql | docker exec -i training---databases101-db-1 psql -U justin -d postgres
            cat ../queries/check_database_exists.sql | docker exec -i training---databases101-db-1 psql -U justin -d postgres
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
done