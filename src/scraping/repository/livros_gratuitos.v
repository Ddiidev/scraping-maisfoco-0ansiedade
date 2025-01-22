module repository

import json
import shareds.db
import scraping.models

pub struct RepoLivrosGratuitos {}

pub fn RepoLivrosGratuitos.new(model models.LivroGratuitoScraping) ! {
	RepoLivrosGratuitos.save_json(model)!
	// RepoAmazon.save_db(model)!
}

fn RepoLivrosGratuitos.save_db(model models.LivroGratuitoScraping) ! {
	con := db.new()!

	sql con {
		insert model into models.LivroGratuitoScraping
	}!
}

fn RepoLivrosGratuitos.save_json(model models.LivroGratuitoScraping) ! {
	json_data := json.encode_pretty(model)

	current_date := model.current_date.get_fmt_date_str(.hyphen, .ddmmyyyy)
	date_file := model.current_date.get_fmt_str(.hyphen, .hhmm24, .ddmmyyyy).replace(':',
		'.')

	write_json(current_date, 'livros_gratuitos-${date_file}.json', json_data)!
}
