CREATE OR REPLACE DATABASE db_music;

USE db_music;

CREATE TABLE artist (
    id int NOT NULL AUTO_INCREMENT PRIMARY KEY);

CREATE TABLE key_signature (
    id int NOT NULL AUTO_INCREMENT PRIMARY KEY,
    name char(2) NOT NULL);

CREATE TABLE song (
    id int NOT NULL AUTO_INCREMENT PRIMARY KEY,
    name varchar(50) NOT NULL,
    artist_id int NOT NULL,
    key_signature_id int NOT NULL,
    time_signature_upper tinyint NOT NULL,
    time_signature_lower tinyint NOT NULL,
	tempo smallint NOT NULL,
    duration time NOT NULL);

CREATE TABLE venue (
    id int NOT NULL AUTO_INCREMENT PRIMARY KEY
);

CREATE TABLE gig (
    id int NOT NULL AUTO_INCREMENT PRIMARY KEY,
    start_date datetime NOT NULL,
    venue_id int NOT NULL,
    set_list_id int NOT NULL);

-- Same set list can be recycled and be played in many gigs.
CREATE TABLE set_list (
    id int NOT NULL AUTO_INCREMENT PRIMARY KEY);

-- A song can be played in different key and tempo than the original
CREATE TABLE set_song (
    set_list_id int NOT NULL,
    song_id int NOT NULL,
    key_signature_id int NOT NULL,
    tempo int NOT NULL);

-- Add foreign keys for the table 'song'

ALTER TABLE song ADD FOREIGN KEY (artist_id)
    REFERENCES artist(id)
    ON DELETE CASCADE
    ON UPDATE RESTRICT;

ALTER TABLE song ADD FOREIGN KEY (key_signature_id)
    REFERENCES key_signature(id)
    ON DELETE CASCADE
    ON UPDATE RESTRICT;

-- Add foreign keys for the table 'gig'

ALTER TABLE gig ADD FOREIGN KEY (set_list_id)
    REFERENCES set_list(id)
    ON DELETE CASCADE
    ON UPDATE RESTRICT;

ALTER TABLE gig ADD FOREIGN KEY (venue_id)
    REFERENCES venue(id)
    ON DELETE CASCADE
    ON UPDATE RESTRICT;

-- Add foreign keys for the table 'set_song'

ALTER TABLE set_song ADD FOREIGN KEY (set_list_id)
    REFERENCES set_list(id)
    ON DELETE CASCADE
    ON UPDATE RESTRICT;

ALTER TABLE set_song ADD FOREIGN KEY (song_id)
    REFERENCES song(id)
    ON DELETE CASCADE
    ON UPDATE RESTRICT;

ALTER TABLE set_song ADD FOREIGN KEY (key_signature_id)
    REFERENCES key_signature(id)
    ON DELETE CASCADE
    ON UPDATE RESTRICT;
