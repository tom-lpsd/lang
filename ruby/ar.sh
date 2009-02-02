#!/bin/sh

createdb arsample
psql -c 'CREATE TABLE mytests (id SERIAL PRIMARY KEY, name TEXT UNIQUE)' arsample
