module repository

import json
import shareds.db
import scraping.models

pub struct RepoInstantGaming {}

pub fn RepoInstantGaming.new(model models.InstantGamesScraping) ! {
	RepoInstantGaming.save_json(model)!
	// RepoInstantGaming.save_db(model)!
}

fn RepoInstantGaming.save_db(model models.InstantGamesScraping) ! {
	con := db.new()!

	sql con {
		insert model into models.InstantGamesScraping
	}!
}

fn RepoInstantGaming.save_json(model models.InstantGamesScraping) ! {
	json_data := json.encode_pretty(model)

	current_date := model.current_date.get_fmt_date_str(.hyphen, .ddmmyyyy)
	date_file := model.current_date.get_fmt_str(.hyphen, .hhmm24, .ddmmyyyy).replace(':',
		'.')

	write_json(current_date, 'instantgaming-${date_file}.json', json_data)!
}
