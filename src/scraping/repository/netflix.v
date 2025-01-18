module repository

import json
import shareds.db
import scraping.models

pub struct RepoNetflix {}

pub fn RepoNetflix.new(model models.NetflixScraping) ! {
	RepoNetflix.save_json(model)!
}

fn RepoNetflix.save_db(model models.NetflixScraping) ! {
	con := db.new()!

	sql con {
		insert model into models.NetflixScraping
	}!
}

fn RepoNetflix.save_json(model models.NetflixScraping) ! {
	json_data := json.encode_pretty(model)

	current_date := model.current_date.get_fmt_date_str(.hyphen, .ddmmyyyy)
	date_file := model.current_date.get_fmt_str(.hyphen, .hhmm24, .ddmmyyyy).replace(':',
		'.')

	write_json(current_date, 'netflix-${date_file}.json', json_data)!
}
