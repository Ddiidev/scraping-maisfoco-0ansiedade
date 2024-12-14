module db

import db.sqlite

const path = './db/scraping.db'

pub fn new() !sqlite.DB {
	return sqlite.connect(path)
}

pub fn create_table[T]() ! {
	con := new()!

	sql con {
		create table T
	}!
}