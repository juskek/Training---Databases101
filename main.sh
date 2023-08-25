#!/usr/bin/env bash

source ./menu.sh

# example usage
one="Create, seed and view pokemon_species table"
two="Option Two"
three="Option Three"
options=("$one" "$two" "$three")

select_option "${options[@]}"
result="${options[$?]}"

echo "You chose: $result"

case $result in
    "$one")
        cd db-data/
        # Create table
        cat ../migrations/202308181628/_create_pokemon_species_table.sql | docker exec -i training---databases101-db-1 psql -U justin -d pokemon

        # Seed table
        cat ../seeds/202308181628/_populate_pokemon_species_table.sql | docker exec -i training---databases101-db-1 psql -U justin -d pokemon

        # Select all records
        cat ../queries/get_all_species.sql | docker exec -i training---databases101-db-1 psql -U justin -d pokemon
        ;;
    "$two")
        echo "Not implemented"
        ;;
    "$three")
        echo "Not implemented"
        ;;
    *)
        print_error "Invalid option: $result"
        ;;
esac