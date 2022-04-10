CREATE TABLE images(
  random_id INTEGER NOT NULL,
  id TEXT NOT NULL,
  server TEXT NOT NULL,
  secret TEXT NOT NULL,
  original_secret TEXT NOT NULL,
  width INTEGER NOT NULL,
  height INTEGER NOT NULL,
  faves INTEGER NOT NULL,
  comments INTEGER NOT NULL,
  views INTEGER NOT NULL,
  bookid INTEGER NOT NULL
);

.separator ' '
.import data.txt images

create index idx_faves
    on images(faves desc, views desc, comments desc, id desc, server, secret, original_secret, width, height, random_id);

create index idx_random
    on images(random_id, views, faves, comments, id, server, secret, original_secret, width, height);

pragma journal_mode = delete; -- to be able to actually set page size
pragma page_size = 4096; -- trade off of number of requests that need to be made vs overhead.
vacuum; -- reorganize database and apply changed page size
