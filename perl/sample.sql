CREATE TABLE `data_node` (
  `pool_id` tinyint(3) unsigned NOT NULL default '0',
  `name` varchar(255) NOT NULL default '',
  `role` enum('m','s') NOT NULL default 'm',
  `is_fresh` enum('y','n') default 'n'
);
