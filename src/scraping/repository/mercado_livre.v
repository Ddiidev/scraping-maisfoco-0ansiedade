module repository

import json
import shareds.db
import scraping.models

pub struct RepoMercadoLivrePlay {}

pub fn RepoMercadoLivrePlay.new(model models.MercadoLivrePlayScraping) ! {
	RepoMercadoLivrePlay.save_json(model)!
	// RepoAmazon.save_db(model)!
}

fn RepoMercadoLivrePlay.save_db(model models.MercadoLivrePlayScraping) ! {
	con := db.new()!

	sql con {
		insert model into models.MercadoLivrePlayScraping
	}!
}

fn RepoMercadoLivrePlay.save_json(model models.MercadoLivrePlayScraping) ! {
	json_data := json.encode_pretty(model)

	current_date := model.current_date.get_fmt_date_str(.hyphen, .ddmmyyyy)
	date_file := model.current_date.get_fmt_str(.hyphen, .hhmm24, .ddmmyyyy).replace(':',
		'.')

	write_json(current_date, 'mercado_livre_play-${date_file}.json', json_data)!
}
