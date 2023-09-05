#!/usr/bin/env bash

source ./menu.sh

# example usage
connect="Connect to database with psql"
create="Create database"
one="Create, seed and view pokemon_species table"
two="Create, seed and view pokemon table"
three="WARNING: Delete pokemon database"
options=("$connect" "$create" "$one" "$two" "$three")

select_option "${options[@]}"
result="${options[$?]}"

echo "You chose: $result"

case $result in
    "$connect")
        cd db-data/
        # Equivalent to
        # terminal --> docker compose exec db bash
        # docker --> psql -U justin -d pokemon
        docker-compose exec db bash -c "psql -U justin -d pokemon"
        ;;

    "$create")
        cd db-data/

        cat ../migrations/202308170000_create_database.sql | docker exec -i training---databases101-db-1 psql -U justin -d postgres
        cat ../queries/check_database_exists.sql | docker exec -i training---databases101-db-1 psql -U justin -d postgres
        ;;
        
    "$one")
        cd db-data/
        # Create table
        cat ../migrations/202308181628_create_pokemon_species_table.sql | docker exec -i training---databases101-db-1 psql -U justin -d pokemon

        # Seed table
        cat ../seeds/202308181628_populate_pokemon_species_table.sql | docker exec -i training---databases101-db-1 psql -U justin -d pokemon

        # Select all records
        cat ../queries/get_all_species.sql | docker exec -i training---databases101-db-1 psql -U justin -d pokemon
        ;;
    "$two")
        cd db-data/
        # Create table
        cat ../migrations/202308181628_create_pokemon_table.sql | docker exec -i training---databases101-db-1 psql -U justin -d pokemon

        # Seed table
        cat ../seeds/202308181628_populate_pokemon_table.sql | docker exec -i training---databases101-db-1 psql -U justin -d pokemon

        # Select all records
        cat ../queries/get_all_pokemon.sql | docker exec -i training---databases101-db-1 psql -U justin -d pokemon
        ;;
    "$three")
        cd db-data/

        cat ../queries/drop_database.sql | docker exec -i training---databases101-db-1 psql -U justin -d postgres
        ;;
    *)
        print_error "Invalid option: $result"
        ;;
esac