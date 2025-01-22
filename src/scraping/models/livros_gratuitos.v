module models

import time

@[table: 'LivrosGratuitos']
pub struct LivroGratuitoScraping {
pub:
	has_link_pdf         bool
	has_link_read_online bool
	title                string
	author               string
	overview             string
	genders              Genders
	current_date         time.Time @[omitempty; sql_type: 'INTEGER']
	thumbnail_link       ThumbLink
}
