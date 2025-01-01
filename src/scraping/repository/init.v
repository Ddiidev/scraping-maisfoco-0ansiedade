module repository

import os
import shareds.db
import scraping.models

fn init() {
	println('Initializing the repository...')
	con := db.new() or { panic(err.str()) }

	sql con {
		create table models.AmazonScraping
		create table models.InstantGamesScraping
		create table models.InstantGamesImage
	} or { panic(err.str()) }
}

pub fn write_json(current_date string, name_file string, content string) ! {
	os.mkdir_all('./db/jsons/${current_date}') or {}
	os.write_file('./db/jsons/${current_date}/${name_file}', content)!
}
