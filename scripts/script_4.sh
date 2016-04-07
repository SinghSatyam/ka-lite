#!/bin/bash
read -s -p "Enter Email For Postgres Docker: " postgresemail
echo $postgresemail
read -s -p "Enter UserName For Postgres Docker: " postgresusername
echo $postgresusername
read -s -p "Enter Password For Postgres Docker: " postgrespassword
echo ''
echo 'Trying to login to dockerhub using the given credentials.'
docker login -e $postgresemail -u $postgresusername -p $postgrespassword
echo ''
read -s -p "Enter Postgres tag to pull: " postgrestag
echo ''
echo "Trying to pull the given tag : "
docker pull magogenie/postgres:$postgrestag
echo "Postgres Machine is pulled from dockerhub. You need to put the database.sql file into that machine. Use either wget or scp to get the file."

