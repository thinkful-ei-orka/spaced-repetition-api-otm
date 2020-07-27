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
  (1, 'French', 1);

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
  (15, 1, 'Bonne Nuit', 'good evening', 16),
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
  (29, 1, 'Fort', 'strong', null);

UPDATE "language" SET head = 1 WHERE id = 1;

-- because we explicitly set the id fields
-- update the sequencer for future automatic id setting
SELECT setval('word_id_seq', (SELECT MAX(id) from "word"));
SELECT setval('language_id_seq', (SELECT MAX(id) from "language"));
SELECT setval('user_id_seq', (SELECT MAX(id) from "user"));

COMMIT;
