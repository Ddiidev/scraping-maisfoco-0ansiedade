module repository

import json
import shareds.db
import scraping.models

pub struct RepoAmazon {}

pub fn RepoAmazon.new(model models.AmazonScraping) ! {
	RepoAmazon.save_json(model)!
	// RepoAmazon.save_db(model)!
}

fn RepoAmazon.save_db(model models.AmazonScraping) ! {
	con := db.new()!

	sql con {
		insert model into models.AmazonScraping
	}!
}

fn RepoAmazon.save_json(model models.AmazonScraping) ! {
	json_data := json.encode_pretty(model)

	current_date := model.current_date.get_fmt_date_str(.hyphen, .ddmmyyyy)
	date_file := model.current_date.get_fmt_str(.hyphen, .hhmm24, .ddmmyyyy).replace(':',
		'.')
	free := if model.price_printed or {0} == 0 { 'Free' } else { '' }

	write_json(current_date, 'amazon-${free}-${date_file}.json', json_data)!
}
