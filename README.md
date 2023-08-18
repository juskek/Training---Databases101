<p align="center">
  <a href="https://www.postgresql.org/" target="blank"><img src="https://www.postgresql.org/media/img/about/press/elephant.png" width="100" alt="PostgreSQL Logo" /></a>
  <a href="https://pokemmo.com/" target="blank"><img src="https://forums.pokemmo.com/uploads/monthly_2022_09/PokeMMO-Logo.thumb.png.f72a577606b2aedae630e968143471c7.png" width="300" alt="PokeMMO Logo" /></a>
</p>

# Databases101 - Postgres Docker container

This repo has a [docker-compose](https://docs.docker.com/compose/) file which creates a container built from the `postgres:latest` image.

It runs a database service on port `5432` which you can connect to with a PostgreSQL client such as [Postico](https://eggerapps.at/postico2/) or SQLTools (`mtxr.sqltools` and `mtxr.sqltools-driver-pg` extensions in the recommended extensions of this repo).

## ✨ Get started

1. Create a new file called `.env` from the `.env.example` file.
2. Make sure the docker daemon is running.
3. Run `docker-compose up` to start the container. 
   - You can add the `-d` flag to run it in the background, but remember to run `docker-compose down` to stop the container when you are finished with it.
   - The postgres data is mirrored in your local `/db-data` directory through a [volume](https://docs.docker.com/storage/volumes/).
4. cd to the volume and run `docker compose exec db bash` to start a bash script from inside the database container. 
5. Run `psql -U <username> -W -d pokemon`


## Running SQL scripts
Create pokemon table: 
```
cat ../migrations/202308181628/_create_pokemon_species_table.sql | docker exec -i training---databases101-db-1 psql -U justin -d pokemon
```
Seed pokemon table:
```
cat ../seeds/202308181628/_populate_pokemon_species_table.sql | docker exec -i training---databases101-db-1 psql -U justin -d pokemon
```


## 🌄 The project

We're going to be building a database for [PokeMMO](https://pokemmo.com/), an MMO version of pokemon where players can meet in-game to trade or battle.
