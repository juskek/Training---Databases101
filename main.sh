#!/usr/bin/env bash

source ./menu.sh

# example usage
one="Create, seed and view pokemon_species table"
two="Create, seed and view pokemon table"
three="WARNING: Delete pokemon database"
options=("$one" "$two" "$three")

select_option "${options[@]}"
result="${options[$?]}"

echo "You chose: $result"

case $result in
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