UPDATE `creature_template` SET `gossip_menu_id` = '0', `equipment_id` = '44726' WHERE `entry` =44726;

DELETE FROM `creature_equip_template` WHERE `entry` = 44726 AND `id` = 2;
INSERT INTO `creature_equip_template` (`entry`, `id`, `itemEntry1`, `itemEntry2`, `itemEntry3`) VALUES
(44726, 2, 13337, 0, 0);

UPDATE `creature_template` SET `VehicleId` = '0' WHERE `entry` =51195;

DELETE FROM `npc_trainer` WHERE `entry` IN (15279,44726,200008,200007,200005,200006);
INSERT INTO `npc_trainer` (`entry`, `spell`, `spellcost`, `reqskill`, `reqskillvalue`, `reqlevel`) VALUES
(15279, -200008, 0, 0, 0, 0),
(15279, -200007, 0, 0, 0, 0),
(44726, -200006, 0, 0, 0, 0),
(44726, -200005, 0, 0, 0, 0),
(200008, 5143, 100, 0, 0, 3),
(200008, 122, 400, 0, 0, 8),
(200008, 2139, 600, 0, 0, 9),
(200008, 5505, 700, 0, 0, 10),
(200008, 597, 1200, 0, 0, 12),
(200008, 12051, 1200, 0, 0, 12),
(200008, 118, 1500, 0, 0, 14),
(200008, 1953, 2100, 0, 0, 16),
(200008, 120, 3000, 0, 0, 18),
(200008, 30451, 3600, 0, 0, 20),
(200008, 5506, 3600, 0, 0, 20),
(200008, 1449, 4200, 0, 0, 22),
(200008, 990, 4200, 0, 0, 22),
(200008, 2948, 6000, 0, 0, 26),
(200008, 30455, 7500, 0, 0, 28),
(200008, 6127, 7500, 0, 0, 30),
(200008, 45438, 7500, 0, 0, 30),
(200008, 475, 7500, 0, 0, 30),
(200008, 130, 9000, 0, 0, 32),
(200008, 6129, 9000, 0, 0, 32),
(200008, 30482, 10500, 0, 0, 34),
(200008, 543, 12000, 0, 0, 36),
(200008, 3552, 13500, 0, 0, 38),
(200008, 42955, 13500, 0, 0, 38),
(200008, 10138, 15000, 0, 0, 40),
(200008, 10144, 16500, 0, 0, 42),
(200008, 2120, 20000, 0, 0, 44),
(200008, 1463, 20000, 0, 0, 46),
(200008, 759, 21000, 0, 0, 48),
(200008, 10053, 21000, 0, 0, 48),
(200008, 55342, 22500, 0, 0, 50),
(200008, 89744, 22500, 0, 0, 50),
(200008, 10139, 22500, 0, 0, 50),
(200008, 10145, 22500, 0, 0, 52),
(200008, 10, 22500, 0, 0, 52),
(200008, 7302, 24000, 0, 0, 54),
(200008, 44614, 25500, 0, 0, 56),
(200008, 10054, 30000, 0, 0, 58),
(200008, 28612, 30000, 0, 0, 60),
(200008, 10140, 30000, 0, 0, 60),
(200008, 37420, 99000, 0, 0, 65),
(200008, 6117, 117000, 0, 0, 68),
(200008, 27101, 117000, 0, 0, 68),
(200008, 33717, 132000, 0, 0, 70),
(200008, 30449, 132000, 0, 0, 70),
(200008, 27090, 132000, 0, 0, 70),
(200008, 43987, 200000, 0, 0, 76),
(200008, 42985, 150000, 0, 0, 77),
(200008, 66, 210000, 0, 0, 78),
(200008, 42956, 230000, 0, 0, 80),
(200008, 86467, 250000, 0, 0, 80),
(200008, 82731, 240000, 0, 0, 81),
(200008, 82676, 260000, 0, 0, 83),
(200008, 80353, 290000, 0, 0, 85),
(200007, 116, 300, 0, 0, 7),
(200007, 587, 200, 0, 0, 6),
(200007, 1459, 30000, 0, 0, 58),
(200007, 2136, 150, 0, 0, 5),
(200007, 5504, 100, 0, 0, 4),
(200005, 467, 150, 0, 0, 5),
(200005, 774, 100, 0, 0, 3),
(200005, 1126, 7500, 0, 0, 30),
(200005, 5487, 1800, 134, 0, 15),
(200005, 6795, 1800, 134, 0, 15),
(200005, 6807, 1800, 134, 0, 15),
(200005, 8921, 100, 0, 0, 4),
(200006, 99, 1800, 134, 0, 15),
(200006, 339, 300, 0, 0, 7),
(200006, 740, 117000, 0, 0, 68),
(200006, 768, 400, 0, 0, 8),
(200006, 770, 5100, 0, 0, 24),
(200006, 779, 12000, 134, 0, 36),
(200006, 783, 2100, 0, 0, 16),
(200006, 1066, 2100, 0, 0, 16),
(200006, 1079, 24000, 134, 0, 54),
(200006, 1082, 400, 134, 0, 8),
(200006, 1822, 400, 134, 0, 8),
(200006, 1850, 6000, 134, 0, 26),
(200006, 2637, 21000, 0, 0, 48),
(200006, 2782, 5100, 0, 0, 24),
(200006, 2908, 7500, 0, 0, 28),
(200006, 2912, 400, 0, 0, 8),
(200006, 5185, 210000, 0, 0, 78),
(200006, 5209, 7500, 134, 0, 28),
(200006, 5211, 9000, 134, 0, 32),
(200006, 5215, 700, 134, 0, 10),
(200006, 5217, 5100, 134, 0, 24),
(200006, 5221, 20000, 134, 0, 46),
(200006, 5225, 9000, 134, 0, 32),
(200006, 5229, 4200, 134, 0, 22),
(200006, 5570, 3600, 0, 0, 20),
(200006, 6785, 4200, 134, 0, 22),
(200006, 8936, 1200, 0, 0, 12),
(200006, 8998, 6000, 134, 0, 26),
(200006, 9005, 9000, 134, 0, 32),
(200006, 16689, 22500, 0, 0, 52),
(200006, 16857, 5100, 0, 0, 24),
(200006, 16864, 3600, 0, 0, 20),
(200006, 16914, 20000, 0, 0, 44),
(200006, 18960, 1800, 0, 0, 15),
(200006, 20484, 3600, 0, 0, 20),
(200006, 20719, 6000, 0, 0, 26),
(200006, 22568, 400, 134, 0, 8),
(200006, 22570, 82000, 134, 0, 62),
(200006, 22812, 30000, 0, 0, 58),
(200006, 22842, 22500, 134, 0, 52),
(200006, 29166, 7500, 0, 0, 28),
(200006, 33745, 105000, 134, 0, 66),
(200006, 33763, 93000, 0, 0, 64),
(200006, 33786, 168000, 0, 0, 74),
(200006, 33950, 30000, 0, 0, 60),
(200006, 40120, 132000, 0, 0, 70),
(200006, 48562, 3600, 0, 0, 20),
(200006, 50464, 400, 0, 0, 8),
(200006, 50769, 1200, 0, 0, 12),
(200006, 52610, 200000, 134, 0, 76),
(200006, 62078, 12000, 134, 0, 36),
(200006, 62600, 15000, 0, 0, 40),
(200006, 77758, 240000, 134, 0, 81),
(200006, 77761, 260000, 134, 0, 83),
(200006, 77764, 260000, 134, 0, 83),
(200006, 80964, 4200, 134, 0, 22),
(200006, 80965, 4200, 134, 0, 22),
(200006, 86530, 22500, 0, 0, 50),
(200006, 87491, 230000, 0, 0, 80),
(200006, 88747, 290000, 0, 0, 85),
(200006, 88751, 290000, 0, 0, 85);

DELETE FROM `trinity_string` WHERE `entry` IN (12004,12002,12001,12003,820,821);
INSERT INTO `trinity_string` (`entry`, `content_default`, `content_loc1`, `content_loc2`, `content_loc3`, `content_loc4`, `content_loc5`, `content_loc6`, `content_loc7`, `content_loc8`) VALUES
(12004, 'The Alliance lost the Venture Bay Lighthouse!', NULL, '', NULL, NULL, NULL, NULL, NULL, NULL),
(12002, 'The Alliance has taken the Venture Bay Lighthouse!', NULL, '', NULL, NULL, NULL, NULL, NULL, NULL),
(12001, 'The Horde has taken the Venture Bay Lighthouse!', NULL, '', NULL, NULL, NULL, NULL, NULL, NULL),
(12003, 'The Horde lost the Venture Bay Lighthouse!', NULL, '', NULL, NULL, NULL, NULL, NULL, NULL),
(820, '* has gossip (%u)', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(821, '* is quest giver (%u)', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

UPDATE `gameobject_template` SET `flags` = '48' WHERE `entry` =202443;

UPDATE `creature_template` SET `AIName` = '' WHERE `entry` =52530;

DELETE FROM `smart_scripts` WHERE `entryorguid` = 52530;

DELETE FROM `areatrigger_teleport` WHERE `id` = 6215;
INSERT INTO `areatrigger_teleport` (`id`, `name`, `target_map`, `target_position_x`, `target_position_y`, `target_position_z`, `target_orientation`) VALUES
(6215, 'Brutst', 1, 4563.54, -2585.77, 829.43, 1.92482);
