#!/usr/bin/env bash

source ./menu.sh

while true; do
    current_dir=$(pwd)

    connect="Connect to database with psql"
    schema="Show schema"
    get_pokemon_with_species_name="Get all pokemon with a particular species name"
    get_species_with_type="Get species of type"
    create="INIT: Create pokemon database"
    delete_db="WARNING: Delete pokemon database"
    exit="Exit"

    options=("$connect" "$schema" "$get_pokemon_with_species_name" "$get_species_with_type" "$create" "$delete_db" "$exit")

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

        "$get_pokemon_with_species_name")
            cd db-data/ || exit 1
            docker exec -i training---databases101-db-1 psql -U justin -d pokemon < ../queries/get_pokemon_where_species.sql
            ;;

        "$get_species_with_type")
            cd db-data/ || exit 1
            docker exec -i training---databases101-db-1 psql -U justin -d pokemon < ../queries/get_species_where_type.sql
            ;;

        "$create")
            cd db-data/ || exit 1
            docker exec -i training---databases101-db-1 psql -U justin -d postgres < ../migrations/202308170000_create_database.sql
            docker exec -i training---databases101-db-1 psql -U justin -d postgres < ../queries/check_database_exists.sql
            docker exec -i training---databases101-db-1 psql -U justin -d pokemon < ../migrations/202308181628_create_pokemon_species_table.sql
            docker exec -i training---databases101-db-1 psql -U justin -d pokemon < ../seeds/202308181628_populate_pokemon_species_table.sql
            docker exec -i training---databases101-db-1 psql -U justin -d pokemon < ../queries/get_all_species.sql
            docker exec -i training---databases101-db-1 psql -U justin -d pokemon < ../migrations/202308181628_create_pokemon_table.sql
            docker exec -i training---databases101-db-1 psql -U justin -d pokemon < ../seeds/202308181628_populate_pokemon_table.sql
            docker exec -i training---databases101-db-1 psql -U justin -d pokemon < ../queries/get_all_pokemon.sql
            docker exec -i training---databases101-db-1 psql -U justin -d pokemon < ../migrations/202309050000_create_pokemon_type_table.sql
            docker exec -i training---databases101-db-1 psql -U justin -d pokemon < ../seeds/202309050000_seed_pokemon_type.sql
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
