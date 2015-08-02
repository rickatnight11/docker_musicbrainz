#!/bin/bash
docker create -v /var/lib/postgresql/data --name postgres-data alpine:latest /bin/true 
