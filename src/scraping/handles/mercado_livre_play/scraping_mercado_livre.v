module mercado_livre_play

// import veb
// import shareds.utils
import tmdb
import scraping.models

pub struct MercadoLivrePlayHandle {
pub:
	lang string
}

pub const genres = {
	28:    'Ação'
	12:    'Aventura'
	16:    'Animação'
	35:    'Comédia'
	80:    'Crime'
	99:    'Documentário'
	18:    'Drama'
	10751: 'Família'
	14:    'Fantasia'
	36:    'História'
	27:    'Terror'
	10402: 'Música'
	9648:  'Mistério'
	10749: 'Romance'
	878:   'Ficção científica'
	10770: 'Cinema TV'
	53:    'Thriller'
	10752: 'Guerra'
	37:    'Faroeste'
}

pub fn (self MercadoLivrePlayHandle) scraping_mercado_livre_play(url string) ?[]models.MercadoLivrePlayScraping {
	name_media := url.find_between('assistir/', '/').replace('-', ' ').capitalize()

	data := tmdb.search_multimedia(name_media) or { return none }

	if data.results.len == 0 {
		return none
	}

	trailer_link := tmdb.search_trailer_movie(id: data.results[0].id, mode: data.multimedia) or {
		''
	}

	mut contents := []models.MercadoLivrePlayScraping{}

	for i, result in data.results {
		if i >= 10 {
			break
		}
		contents << models.MercadoLivrePlayScraping{
			link:             url
			title:            result.title
			year:             result.release_date.split('-')[0].int()
			overview:         result.overview
			genders:          result.genre_ids.map(genres[it]).join(', ')
			qtde_evaluation:  result.vote_count
			geral_evaluation: result.vote_average
			trailer_link:     trailer_link
			thumbnails_links: 'https://image.tmdb.org/t/p/w500/${result.poster_path}'
		}
	}

	return contents
}
