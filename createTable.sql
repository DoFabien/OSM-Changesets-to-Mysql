CREATE TABLE `changesets` (
  `id` varchar(255) NOT NULL,
  `created_at` datetime DEFAULT NULL,
  `closed_at` datetime DEFAULT NULL,
  `open` varchar(20) DEFAULT NULL,
  `num_changes` int(11) DEFAULT NULL,
  `user` varchar(255) DEFAULT NULL,
  `uid` varchar(255) DEFAULT NULL,
  `created_by` varchar(255) DEFAULT NULL,
  `geom` polygon DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


ALTER TABLE `changesets`
  ADD PRIMARY KEY (`id`);


CREATE VIEW by_editor as
select 'JOSM' AS `editor`,sum(`osmchangesets`.`changesets`.`num_changes`) AS `num_change`,count(0) AS `count` from `osmchangesets`.`changesets` where (`osmchangesets`.`changesets`.`created_by` like 'JOSM%') union 
select 'iD' AS `editor`,sum(`osmchangesets`.`changesets`.`num_changes`) AS `num_change`,count(0) AS `count` from `osmchangesets`.`changesets` where (`osmchangesets`.`changesets`.`created_by` like 'iD%') union 
select 'Potlatch' AS `editor`,sum(`osmchangesets`.`changesets`.`num_changes`) AS `num_change`,count(0) AS `count` from `osmchangesets`.`changesets` where (`osmchangesets`.`changesets`.`created_by` like 'Potlatch%') union 
select 'Go Map!' AS `editor`,sum(`osmchangesets`.`changesets`.`num_changes`) AS `num_change`,count(0) AS `count` from `osmchangesets`.`changesets` where (`osmchangesets`.`changesets`.`created_by` like 'Go Map!%') union 
select 'OsmAnd' AS `editor`,sum(`osmchangesets`.`changesets`.`num_changes`) AS `num_change`,count(0) AS `count` from `osmchangesets`.`changesets` where (`osmchangesets`.`changesets`.`created_by` like 'OsmAnd%') union 
select 'MAPS.ME' AS `editor`,sum(`osmchangesets`.`changesets`.`num_changes`) AS `num_change`,count(0) AS `count` from `osmchangesets`.`changesets` where (`osmchangesets`.`changesets`.`created_by` like 'MAPS.ME%') union 
select 'Merkaartor' AS `editor`,sum(`osmchangesets`.`changesets`.`num_changes`) AS `num_change`,count(0) AS `count` from `osmchangesets`.`changesets` where (`osmchangesets`.`changesets`.`created_by` like 'Merkaartor%') union 
select 'MapContrib' AS `editor`,sum(`osmchangesets`.`changesets`.`num_changes`) AS `num_change`,count(0) AS `count` from `osmchangesets`.`changesets` where (`osmchangesets`.`changesets`.`created_by` like 'MapContrib%') union 
select 'Level0' AS `editor`,sum(`osmchangesets`.`changesets`.`num_changes`) AS `num_change`,count(0) AS `count` from `osmchangesets`.`changesets` where (`osmchangesets`.`changesets`.`created_by` like 'Level0%') union 
select 'ArcGIS Editor' AS `editor`,sum(`osmchangesets`.`changesets`.`num_changes`) AS `num_change`,count(0) AS `count` from `osmchangesets`.`changesets` where (`osmchangesets`.`changesets`.`created_by` like 'ArcGIS Editor%') union 
select 'Beeers' AS `editor`,sum(`osmchangesets`.`changesets`.`num_changes`) AS `num_change`,count(0) AS `count` from `osmchangesets`.`changesets` where (`osmchangesets`.`changesets`.`created_by` like 'Beeers%') union 
select 'Brick' AS `editor`,sum(`osmchangesets`.`changesets`.`num_changes`) AS `num_change`,count(0) AS `count` from `osmchangesets`.`changesets` where (`osmchangesets`.`changesets`.`created_by` like 'Brick%') union 
select 'CBR_' AS `editor`,sum(`osmchangesets`.`changesets`.`num_changes`) AS `num_change`,count(0) AS `count` from `osmchangesets`.`changesets` where (`osmchangesets`.`changesets`.`created_by` like 'CBR_%') union 
select 'Crée par Ubiflow.net' AS `editor`,sum(`osmchangesets`.`changesets`.`num_changes`) AS `num_change`,count(0) AS `count` from `osmchangesets`.`changesets` where (`osmchangesets`.`changesets`.`created_by` like 'Crée par Ubiflow.net%') union 
select 'erfasserKF' AS `editor`,sum(`osmchangesets`.`changesets`.`num_changes`) AS `num_change`,count(0) AS `count` from `osmchangesets`.`changesets` where (`osmchangesets`.`changesets`.`created_by` like 'erfasserKF%') union 
select 'FireYak' AS `editor`,sum(`osmchangesets`.`changesets`.`num_changes`) AS `num_change`,count(0) AS `count` from `osmchangesets`.`changesets` where (`osmchangesets`.`changesets`.`created_by` like 'FireYak%') union 
select 'gnome-maps' AS `editor`,sum(`osmchangesets`.`changesets`.`num_changes`) AS `num_change`,count(0) AS `count` from `osmchangesets`.`changesets` where (`osmchangesets`.`changesets`.`created_by` like 'gnome-maps%') union 
select 'MMWatch' AS `editor`,sum(`osmchangesets`.`changesets`.`num_changes`) AS `num_change`,count(0) AS `count` from `osmchangesets`.`changesets` where (`osmchangesets`.`changesets`.`created_by` like 'MMWatch%') union 
select 'OpenBeerMap' AS `editor`,sum(`osmchangesets`.`changesets`.`num_changes`) AS `num_change`,count(0) AS `count` from `osmchangesets`.`changesets` where (`osmchangesets`.`changesets`.`created_by` like 'OpenBeerMap%') union 
select 'OpenVegeMap' AS `editor`,sum(`osmchangesets`.`changesets`.`num_changes`) AS `num_change`,count(0) AS `count` from `osmchangesets`.`changesets` where (`osmchangesets`.`changesets`.`created_by` like 'OpenVegeMap%') union 
select 'Osm Go!' AS `editor`,sum(`osmchangesets`.`changesets`.`num_changes`) AS `num_change`,count(0) AS `count` from `osmchangesets`.`changesets` where (`osmchangesets`.`changesets`.`created_by` like 'Osm Go!%') union 
select 'OSM-Relation-Editor' AS `editor`,sum(`osmchangesets`.`changesets`.`num_changes`) AS `num_change`,count(0) AS `count` from `osmchangesets`.`changesets` where (`osmchangesets`.`changesets`.`created_by` like 'OSM-Relation-Editor%') union 
select 'osmapi' AS `editor`,sum(`osmchangesets`.`changesets`.`num_changes`) AS `num_change`,count(0) AS `count` from `osmchangesets`.`changesets` where (`osmchangesets`.`changesets`.`created_by` like 'osmapi%') union 
select 'OsmHydrant' AS `editor`,sum(`osmchangesets`.`changesets`.`num_changes`) AS `num_change`,count(0) AS `count` from `osmchangesets`.`changesets` where (`osmchangesets`.`changesets`.`created_by` like 'OsmHydrant%') union 
select 'Osmose Editor' AS `editor`,sum(`osmchangesets`.`changesets`.`num_changes`) AS `num_change`,count(0) AS `count` from `osmchangesets`.`changesets` where (`osmchangesets`.`changesets`.`created_by` like 'Osmose Editor%') union 
select 'osmtools' AS `editor`,sum(`osmchangesets`.`changesets`.`num_changes`) AS `num_change`,count(0) AS `count` from `osmchangesets`.`changesets` where (`osmchangesets`.`changesets`.`created_by` like 'osmtools%') union 
select 'parceco' AS `editor`,sum(`osmchangesets`.`changesets`.`num_changes`) AS `num_change`,count(0) AS `count` from `osmchangesets`.`changesets` where (`osmchangesets`.`changesets`.`created_by` like 'parceco%') union 
select 'POI+ ' AS `editor`,sum(`osmchangesets`.`changesets`.`num_changes`) AS `num_change`,count(0) AS `count` from `osmchangesets`.`changesets` where (`osmchangesets`.`changesets`.`created_by` like 'POI+ %') union 
select 'Pushpin' AS `editor`,sum(`osmchangesets`.`changesets`.`num_changes`) AS `num_change`,count(0) AS `count` from `osmchangesets`.`changesets` where (`osmchangesets`.`changesets`.`created_by` like 'Pushpin%') union 
select 'RawEdit' AS `editor`,sum(`osmchangesets`.`changesets`.`num_changes`) AS `num_change`,count(0) AS `count` from `osmchangesets`.`changesets` where (`osmchangesets`.`changesets`.`created_by` like 'RawEdit%') union 
select 'Redaction bot' AS `editor`,sum(`osmchangesets`.`changesets`.`num_changes`) AS `num_change`,count(0) AS `count` from `osmchangesets`.`changesets` where (`osmchangesets`.`changesets`.`created_by` like 'Redaction bot%') union 
select 'restore-version' AS `editor`,sum(`osmchangesets`.`changesets`.`num_changes`) AS `num_change`,count(0) AS `count` from `osmchangesets`.`changesets` where (`osmchangesets`.`changesets`.`created_by` like 'restore-version%') union 
select 'reverter;JOSM' AS `editor`,sum(`osmchangesets`.`changesets`.`num_changes`) AS `num_change`,count(0) AS `count` from `osmchangesets`.`changesets` where (`osmchangesets`.`changesets`.`created_by` like 'reverter;JOSM%') union 
select 'RoofMapper ' AS `editor`,sum(`osmchangesets`.`changesets`.`num_changes`) AS `num_change`,count(0) AS `count` from `osmchangesets`.`changesets` where (`osmchangesets`.`changesets`.`created_by` like 'RoofMapper %') union 
select 'rosemary' AS `editor`,sum(`osmchangesets`.`changesets`.`num_changes`) AS `num_change`,count(0) AS `count` from `osmchangesets`.`changesets` where (`osmchangesets`.`changesets`.`created_by` like 'rosemary%') union 
select 'schuepc' AS `editor`,sum(`osmchangesets`.`changesets`.`num_changes`) AS `num_change`,count(0) AS `count` from `osmchangesets`.`changesets` where (`osmchangesets`.`changesets`.`created_by` like 'schuepc%') union 
select 'StreetComplete' AS `editor`,sum(`osmchangesets`.`changesets`.`num_changes`) AS `num_change`,count(0) AS `count` from `osmchangesets`.`changesets` where (`osmchangesets`.`changesets`.`created_by` like 'StreetComplete%') union 
select 'Swiss Peaks Integration' AS `editor`,sum(`osmchangesets`.`changesets`.`num_changes`) AS `num_change`,count(0) AS `count` from `osmchangesets`.`changesets` where (`osmchangesets`.`changesets`.`created_by` like 'Swiss Peaks Integration%') union 
select 'Vespucci' AS `editor`,sum(`osmchangesets`.`changesets`.`num_changes`) AS `num_change`,count(0) AS `count` from `osmchangesets`.`changesets` where (`osmchangesets`.`changesets`.`created_by` like 'Vespucci%');