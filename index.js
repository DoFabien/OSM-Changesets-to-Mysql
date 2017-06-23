var request = require('request');
var zlib = require('zlib');
var parser = require('xml2json');
var mysql = require('mysql');
var turfInside = require('@turf/inside');
var turfPoint = require('turf-point');
var fs = require('fs');

var enableGeojsonMask = true; // false => all changeset
var connection = mysql.createConnection({
    host: 'localhost',
    user: 'root',
    password: 'root',
    database: 'osmchangesets'
});

var geojsonMask = JSON.parse(fs.readFileSync('./france.geojson', 'utf8'));

var sequence = fs.readFileSync('./sequence.txt', 'utf8');
var sequenceEnd = 0;

init();
function init() {
    getLastSequence((lastSeq) => {
        console.log(lastSeq);
        sequenceEnd = lastSeq;
        connection.connect();
        gogogo(sequence);

    })
}

function gogogo(sequence) {
    getChangsetJson(sequence, (csJson) => {
        fs.writeFileSync('./sequence.txt', sequence.toString(), 'utf8');

        pushToMysql(connection, csJson, (err) => {
            sequence++;
            console.log(sequence);
            if (sequence < sequenceEnd) {
                gogogo(sequence)
            } else {
                console.log('Ok :)');
                connection.end();
            }

        });
    })
}

function isInMaskGeojson(min_lat, min_lon, max_lat, max_lon) {
    let pmin = turfPoint([parseFloat(min_lon), parseFloat(min_lat)]);
    let pmax = turfPoint([parseFloat(max_lon), parseFloat(max_lat)]);

    if (!turfInside(pmin, geojsonMask))
        return false

    if (!turfInside(pmax, geojsonMask))
        return false

    return true
}


function pushToMysql(connection, csJson, callback) {
    if (!csJson)
        return callback()
    connection.beginTransaction(function (err) {
        for (let i = 0; i < csJson.length; i++) {
            let cs = csJson[i];
            let att = [cs.id, cs.created_at, cs.closed_at, cs.open, cs.num_changes, cs.user, cs.uid, cs.created_by, cs.wkt]
            let querry = "REPLACE  INTO changesets (id, created_at, closed_at, open, num_changes, user, uid, created_by, geom) VALUES (?, ?, ?, ?, ?, ?, ?, ?, GeomFromText(?));"
            connection.query(querry, att, function (error, results, fields) {
                if (error) throw error;
            });

        }
    })
    connection.commit(function (err) {
        return callback()
    })

}

function getLastSequence(callback) {
    request({ url: 'http://planet.osm.org/replication/changesets/state.yaml' }, function (error, response, body) {
        if (!error && response.statusCode == 200) {
            let seq = body.match(/sequence:\s[0-9]*/)[0].split(': ')[1].trim();
            return callback(seq);
        }
        else {
            return callback(null);
        }
    })
}

function getChangsetJson(sequence, callback) {
    sequence = sequence.toString();
    var urlPart = ['00' + sequence.substr(sequence.length - 7, sequence.length - 6),
    sequence.substr(sequence.length - 6, sequence.length - 4),
    sequence.substr(sequence.length - 3)]
    var urlCsOsm = 'http://planet.osm.org/replication/changesets/' + urlPart.join('/') + '.osm.gz';

    request({ url: urlCsOsm, encoding: null }, function (error, response, body) {
        if (!error && response.statusCode == 200) {

            var osmFile = zlib.gunzipSync(body);
            var osmStr = osmFile.toString('utf8');
            var changesets = JSON.parse(parser.toJson(osmStr)).osm.changeset;
            if (!changesets)
                return callback(null);

            let res = [];
            for (let i = 0; i < changesets.length; i++) {
                let cs = changesets[i];
               
                if (!enableGeojsonMask || (cs.tag && parseInt(cs.num_changes) > 0 && isInMaskGeojson(cs.min_lat, cs.min_lon, cs.max_lat, cs.max_lon))) {
                    for (let j = 0; j < cs.tag.length; j++) {
                        let tag = cs.tag[j];
                        if (tag.k == 'created_by') {

                            let wkt = 'POLYGON((' +
                                cs.min_lon + ' ' + cs.min_lat + ',' +
                                cs.min_lon + ' ' + cs.max_lat + ',' +
                                cs.max_lon + ' ' + cs.max_lat + ',' +
                                cs.max_lon + ' ' + cs.min_lat + ',' +
                                cs.min_lon + ' ' + cs.min_lat + '))';

                            let csJson = {
                                id: cs.id,
                                created_at: cs.created_at.replace('T', ' ').replace('Z', ''),
                                closed_at: cs.closed_at ? cs.closed_at.replace('T', ' ').replace('Z', '') : null,
                                open: cs.open,
                                num_changes: cs.num_changes,
                                user: cs.user,
                                uid: cs.uid,
                                created_by: tag.v,
                                wkt: wkt
                            }
                            res.push(csJson);
                            break
                        }
                    }
                }
            }
            return (callback(res));
        } else {
            callback(null);
        }
    })
}