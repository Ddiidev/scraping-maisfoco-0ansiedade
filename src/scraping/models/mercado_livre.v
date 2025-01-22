module models

import time

pub type Languages = string

pub fn (l Languages) to_list() []string {
	return l.split(',')
}

pub fn (l Languages) add(languages ...string) Languages {
	return l + ',' + languages.join(',')
}

pub type Subtitles = string

pub fn (s Subtitles) to_list() []string {
	return s.split(',')
}

pub fn (s Subtitles) add(subtitles ...string) Subtitles {
	return s + ',' + subtitles.join(',')
}

@[table: 'MercadoLivrePlayScrapings']
pub struct MercadoLivrePlayScraping {
pub:
	year             int
	geral_evaluation f32
	qtde_evaluation  int
	title            string
	overview         string
	link             string
	genders          Genders
	languages        Languages
	subtitles        Subtitles
	thumbnails_links ThumbLink
	trailer_link     TrailerLink
	current_date     time.Time @[omitempty; sql_type: 'INTEGER']
}
