CREATE TABLE peeps(id SERIAL PRIMARY KEY, text VARCHAR(140), time VARCHAR(20), user_id INTEGER REFERENCES users(id) ON DELETE CASCADE);
