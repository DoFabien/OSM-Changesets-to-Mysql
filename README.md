# OSM-Changesets-to-Mysql
Get osm changesets from planet.osm.org &amp; push in mysql db


## Install
```
npm install
```
Create table => createTable.sql

Update database connection settings (index.js)

Update the first sequence number in sequence.txt (the last sequence is : http://planet.osm.org/replication/changesets/state.yaml)
(2403917 =>2017-06-10)  

Update the geojson Mask -default: france.geojson- to filter the data that is only in this polygon.
It can be disabled (var enableGeojsonMask => false)

## Run 
```
node index.js
```