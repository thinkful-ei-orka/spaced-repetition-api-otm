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
  -- (30, 2, 'Bonjour', 'hello', ),
  -- (31, 2, 'Au revoir', 'goodbye', ),
  -- (, 2, 'Oui', 'yes', ),
  -- (, 2, 'Non', 'no', ),
  -- (, 2, 'Merci', 'thank you', ),
  -- (, 2, 'Merci beaucoup', 'thank you very much', ),
  -- (, 2, 'Fille', 'girl', ),
  -- (, 2, 'Garcon', 'boy', ),
  -- (, 2, 'Femme', 'woman', ),
  -- (, 2, 'Homme', 'man', ),
  -- (, 2, 'Amour', 'love', ),
  -- (, 2, 'Francais', 'french', ),
  -- (, 2, 'S&#39il vous plait', 'please', ),
  -- (, 2, 'Bonsoir', 'good evening', ),
  -- (, 2, 'Bonne Nuit', 'good evening', ),
  -- (, 2, 'Excusez-moi', 'excuse me', ),
  -- (, 2, 'De Rien', 'you&#39re welcome (casual)', ),
  -- (, 2, 'Je vous en prie', 'you&#39re welcome (formal)', ),
  -- (, 2, 'Temps', 'time', ),
  -- (, 2, 'Jour', 'day', ),
  -- (, 2, 'Monde', 'world', ),
  -- (, 2, 'Monsieur', 'mister', ),
  -- (, 2, 'Raison', 'reason', ),
  -- (, 2, 'Madame', 'miss', ),
  -- (, 2, 'Beau', 'handsome', ),
  -- (, 2, 'Belle', 'beautiful', ),
  -- (, 2, 'Chat', 'cat', ),
  -- (, 2, 'Chien', 'dog', ),
  -- (, 2, 'Fort', 'strong', null),
  -- (, 3, 'Bonjour', 'hello', ),
  -- (, 3, 'Au revoir', 'goodbye', ),
  -- (, 3, 'Oui', 'yes', ),
  -- (, 3, 'Non', 'no', ),
  -- (, 3, 'Merci', 'thank you', ),
  -- (, 3, 'Merci beaucoup', 'thank you very much', ),
  -- (, 3, 'Fille', 'girl', ),
  -- (, 3, 'Garcon', 'boy', ),
  -- (, 3, 'Femme', 'woman', ),
  -- (, 1, 'Homme', 'man', ),
  -- (, 3, 'Amour', 'love', ),
  -- (, 3, 'Francais', 'french', ),
  -- (, 3, 'S&#39il vous plait', 'please', ),
  -- (, 3, 'Bonsoir', 'good evening', ),
  -- (, 3, 'Bonne Nuit', 'good evening', ),
  -- (, 3, 'Excusez-moi', 'excuse me', ),
  -- (, 3, 'De Rien', 'you&#39re welcome (casual)', ),
  -- (, 3, 'Je vous en prie', 'you&#39re welcome (formal)', ),
  -- (, 3, 'Temps', 'time', ),
  -- (, 3, 'Jour', 'day', ),
  -- (, 3, 'Monde', 'world', ),
  -- (, 3, 'Monsieur', 'mister', ),
  -- (, 3, 'Raison', 'reason', ),
  -- (, 3, 'Madame', 'miss', ),
  -- (, 3, 'Beau', 'handsome', ),
  -- (, 3, 'Belle', 'beautiful', ),
  -- (, 3, 'Chat', 'cat', ),
  -- (, 3, 'Chien', 'dog', ),
  -- (, 3, 'Fort', 'strong', null),
  -- (, 4, 'Bonjour', 'hello', ),
  -- (, 4, 'Au revoir', 'goodbye', ),
  -- (, 4, 'Oui', 'yes', ),
  -- (, 4, 'Non', 'no', ),
  -- (, 4, 'Merci', 'thank you', ),
  -- (, 4, 'Merci beaucoup', 'thank you very much', ),
  -- (, 4, 'Fille', 'girl', ),
  -- (, 4, 'Garcon', 'boy', ),
  -- (, 4, 'Femme', 'woman', ),
  -- (, 4, 'Homme', 'man', ),
  -- (, 4, 'Amour', 'love', ),
  -- (, 4, 'Francais', 'french', ),
  -- (, 4, 'S&#39il vous plait', 'please', ),
  -- (, 4, 'Bonsoir', 'good evening', ),
  -- (, 4, 'Bonne Nuit', 'good evening', ),
  -- (, 4, 'Excusez-moi', 'excuse me', ),
  -- (, 4, 'De Rien', 'you&#39re welcome (casual)', ),
  -- (, 4, 'Je vous en prie', 'you&#39re welcome (formal)', ),
  -- (, 4, 'Temps', 'time', ),
  -- (, 4, 'Jour', 'day', ),
  -- (, 4, 'Monde', 'world', ),
  -- (, 4, 'Monsieur', 'mister', ),
  -- (, 4, 'Raison', 'reason', ),
  -- (, 4, 'Madame', 'miss', ),
  -- (, 4, 'Beau', 'handsome', ),
  -- (, 4, 'Belle', 'beautiful', ),
  -- (, 4, 'Chat', 'cat', ),
  -- (, 4, 'Chien', 'dog', ),
  -- (, 4, 'Fort', 'strong', null);

UPDATE "language" SET head = 1 WHERE id = 1;

-- because we explicitly set the id fields
-- update the sequencer for future automatic id setting
SELECT setval('word_id_seq', (SELECT MAX(id) from "word"));
SELECT setval('language_id_seq', (SELECT MAX(id) from "language"));
SELECT setval('user_id_seq', (SELECT MAX(id) from "user"));

COMMIT;
