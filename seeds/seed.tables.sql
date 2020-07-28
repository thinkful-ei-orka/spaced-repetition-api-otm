-- to run this file enter the following:
-- psql -d spaced-repetition -f ./seeds/seed.tables.sql

BEGIN;

TRUNCATE
  "word",
  "language",
  "user";

INSERT INTO "user" ("id", "username", "name", "password")
VALUES
  (
    1,
    'admin',
    'Dunder Mifflin Admin',
    -- password = "pass"
    '$2a$10$fCWkaGbt7ZErxaxclioLteLUgg4Q3Rp09WW0s/wSLxDKYsaGYUpjG'
  ),
  (
    2,
    'oozekin',
    'Orkun Ozekin',
    -- password = "Password1!"
    '$2a$12$wm5l3DviGd5jMjd3SUvW.OGYbQvONDkc40gbszp3JfsGTFZqs.DS.'
  ),
  (
    3,
    'tkwak',
    'Taeil Kwak',
    -- password = "Password1!"
    '$2a$12$wm5l3DviGd5jMjd3SUvW.OGYbQvONDkc40gbszp3JfsGTFZqs.DS.'
  ),
  (
    4,
    'mpainter',
    'Magdalena Painter',
    -- password = "Password1!"
    '$2a$12$wm5l3DviGd5jMjd3SUvW.OGYbQvONDkc40gbszp3JfsGTFZqs.DS.'
  );

INSERT INTO "language" ("id", "name", "user_id")
VALUES
  (1, 'French', 1),
  (2, 'French', 2),
  (3, 'French', 3),
  (4, 'French', 4);

INSERT INTO "word" ("id", "language_id", "original", "translation", "next")
VALUES
  (1, 1, 'Bonjour', 'hello', 2),
  (2, 1, 'Au revoir', 'goodbye', 3),
  (3, 1, 'Oui', 'yes', 4),
  (4, 1, 'Non', 'no', 5),
  (5, 1, 'Merci', 'thank you', 6),
  (6, 1, 'Merci beaucoup', 'thank you very much', 7),
  (7, 1, 'Fille', 'girl', 8),
  (8, 1, 'Garcon', 'boy', 9),
  (9, 1, 'Femme', 'woman', 10),
  (10, 1, 'Homme', 'man', 11),
  (11, 1, 'Amour', 'love', 12),
  (12, 1, 'Francais', 'french', 13),
  (13, 1, 'S&#39il vous plait', 'please', 14),
  (14, 1, 'Bonsoir', 'good evening', 15),
  (15, 1, 'Bonne Nuit', 'good night', 16),
  (16, 1, 'Excusez-moi', 'excuse me', 17),
  (17, 1, 'De Rien', 'you&#39re welcome (casual)', 18),
  (18, 1, 'Je vous en prie', 'you&#39re welcome (formal)', 19),
  (19, 1, 'Temps', 'time', 20),
  (20, 1, 'Jour', 'day', 21),
  (21, 1, 'Monde', 'world', 22),
  (22, 1, 'Monsieur', 'mister', 23),
  (23, 1, 'Raison', 'reason', 24),
  (24, 1, 'Madame', 'miss', 25),
  (25, 1, 'Beau', 'handsome', 26),
  (26, 1, 'Belle', 'beautiful', 27),
  (27, 1, 'Chat', 'cat', 28),
  (28, 1, 'Chien', 'dog', 29),
  (29, 1, 'Fort', 'strong', null),
  (30, 2, 'Bonjour', 'hello', 31),
  (31, 2, 'Au revoir', 'goodbye', 32),
  (32, 2, 'Oui', 'yes', 33),
  (33, 2, 'Non', 'no', 34),
  (34, 2, 'Merci', 'thank you', 35),
  (35, 2, 'Merci beaucoup', 'thank you very much', 36),
  (36, 2, 'Fille', 'girl', 37),
  (37, 2, 'Garcon', 'boy', 38),
  (38, 2, 'Femme', 'woman', 39),
  (39, 2, 'Homme', 'man', 40),
  (40, 2, 'Amour', 'love', 41),
  (41, 2, 'Francais', 'french', 42),
  (42, 2, 'S&#39il vous plait', 'please', 43),
  (43, 2, 'Bonsoir', 'good evening', 44),
  (44, 2, 'Bonne Nuit', 'good night', 45),
  (45, 2, 'Excusez-moi', 'excuse me', 46),
  (46, 2, 'De Rien', 'you&#39re welcome (casual)', 47),
  (47, 2, 'Je vous en prie', 'you&#39re welcome (formal)', 48),
  (48, 2, 'Temps', 'time', 49),
  (49, 2, 'Jour', 'day', 50),
  (50, 2, 'Monde', 'world', 51),
  (51, 2, 'Monsieur', 'mister', 52),
  (52, 2, 'Raison', 'reason', 53),
  (53, 2, 'Madame', 'miss', 54),
  (54, 2, 'Beau', 'handsome', 55),
  (55, 2, 'Belle', 'beautiful', 56),
  (56, 2, 'Chat', 'cat', 57),
  (57, 2, 'Chien', 'dog', 58),
  (58, 2, 'Fort', 'strong', null),
  (59, 3, 'Bonjour', 'hello', 60),
  (60, 3, 'Au revoir', 'goodbye', 61),
  (61, 3, 'Oui', 'yes', 62),
  (62, 3, 'Non', 'no', 63),
  (63, 3, 'Merci', 'thank you', 64),
  (64, 3, 'Merci beaucoup', 'thank you very much', 65),
  (65, 3, 'Fille', 'girl', 66),
  (66, 3, 'Garcon', 'boy', 67),
  (67, 3, 'Femme', 'woman', 68),
  (68, 1, 'Homme', 'man', 69),
  (69, 3, 'Amour', 'love', 70),
  (70, 3, 'Francais', 'french', 71),
  (71, 3, 'S&#39il vous plait', 'please', 72),
  (72, 3, 'Bonsoir', 'good evening', 73),
  (73, 3, 'Bonne Nuit', 'good night', 74),
  (74, 3, 'Excusez-moi', 'excuse me', 75),
  (75, 3, 'De Rien', 'you&#39re welcome (casual)', 76),
  (76, 3, 'Je vous en prie', 'you&#39re welcome (formal)', 77),
  (77, 3, 'Temps', 'time', 78),
  (78, 3, 'Jour', 'day', 79),
  (79, 3, 'Monde', 'world', 80),
  (80, 3, 'Monsieur', 'mister', 81),
  (81, 3, 'Raison', 'reason', 82),
  (82, 3, 'Madame', 'miss', 83),
  (83, 3, 'Beau', 'handsome', 84),
  (84, 3, 'Belle', 'beautiful', 85),
  (85, 3, 'Chat', 'cat', 86),
  (86, 3, 'Chien', 'dog', 87),
  (87, 3, 'Fort', 'strong', null),
  (88, 4, 'Bonjour', 'hello', 89),
  (89, 4, 'Au revoir', 'goodbye', 90),
  (90, 4, 'Oui', 'yes', 91),
  (91, 4, 'Non', 'no', 92),
  (92, 4, 'Merci', 'thank you', 93),
  (93, 4, 'Merci beaucoup', 'thank you very much', 94),
  (94, 4, 'Fille', 'girl', 95),
  (95, 4, 'Garcon', 'boy', 96),
  (96, 4, 'Femme', 'woman', 97),
  (97, 4, 'Homme', 'man', 98),
  (98, 4, 'Amour', 'love', 99),
  (99, 4, 'Francais', 'french', 100),
  (100, 4, 'S&#39il vous plait', 'please', 101),
  (101, 4, 'Bonsoir', 'good evening', 102),
  (102, 4, 'Bonne Nuit', 'good night', 103),
  (103, 4, 'Excusez-moi', 'excuse me', 104),
  (104, 4, 'De Rien', 'you&#39re welcome (casual)', 105),
  (105, 4, 'Je vous en prie', 'you&#39re welcome (formal)', 106),
  (106, 4, 'Temps', 'time', 107),
  (107, 4, 'Jour', 'day', 108),
  (108, 4, 'Monde', 'world', 109),
  (109, 4, 'Monsieur', 'mister', 110),
  (110, 4, 'Raison', 'reason', 111),
  (111, 4, 'Madame', 'miss', 112),
  (112, 4, 'Beau', 'handsome', 113),
  (113, 4, 'Belle', 'beautiful', 114),
  (114, 4, 'Chat', 'cat', 115),
  (115, 4, 'Chien', 'dog', 116),
  (116, 4, 'Fort', 'strong', null);

UPDATE "language" SET head = 1 WHERE id = 1;

-- because we explicitly set the id fields
-- update the sequencer for future automatic id setting
SELECT setval('word_id_seq', (SELECT MAX(id) from "word"));
SELECT setval('language_id_seq', (SELECT MAX(id) from "language"));
SELECT setval('user_id_seq', (SELECT MAX(id) from "user"));

COMMIT;
