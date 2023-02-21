# Databases101 - Postgres Docker container

<p align="center">
  <a href="https://www.postgresql.org/" target="blank"><img src="https://www.postgresql.org/media/img/about/press/elephant.png" width="100" alt="PostgreSQL Logo" /></a>
</p>

This repo has a [docker-compose](https://docs.docker.com/compose/) file which creates a container built from the `postgres:latest` image.

It runs a database service on port `5432` which you can connect to with a PostgreSQL client such as [Postico](https://eggerapps.at/postico2/) or SQLTools (`mtxr.sqltools` and `mtxr.sqltools-driver-pg` extensions in the recommended extensions of this repo).

## ✨ Get started

Create a new file called `.env` from the `.env.example` file.

Make sure the docker daemon is running.

Run `docker-compose up` to start the container. You can add the `-d` flag to run it in the background, but remember to run `docker-compose down` to stop the container when you are finished with it.

The postgres data is mirrored in your local `/db-data` directory through a [volume](https://docs.docker.com/storage/volumes/).
