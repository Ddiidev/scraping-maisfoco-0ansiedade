module models

import time

@[table: 'AmazonScrapings']
pub struct AmazonScraping {
pub:
	price_printed      ?f64
	price_kindle_ebook ?f64
	geral_evaluation   f32
	qtde_evaluation    int
	link               string
	title              string
	author             string
	sinopse            string
	images_links       string
	thumbnails_links   ThumbLink
	current_date       time.Time @[omitempty; sql_type: 'INTEGER']
}
