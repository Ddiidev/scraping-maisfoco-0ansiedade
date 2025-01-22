module tmdb

import json
import dotenv
import net.http
import tmdb.models
import scraping.models as scrap_models

const url = 'https://api.themoviedb.org/3/search/movie'
const url_movie_trailer = 'https://api.themoviedb.org/3/movie'
const language = 'pt-BR'

// search_multimedia retorna um objeto tmdb.models.TMDBResult com os resultados da busca do movie
pub fn search_multimedia(name string) ?models.TMDBResult {
	conf := dotenv.parse('./.env')
	bearer_token := conf['TMDB_BEARER_TOKEN']
	api_key := conf['TMDB_API_KEY']

	response := http.fetch(
		method: .get
		url:    url
		header: http.new_header(http.HeaderConfig{.authorization, 'Bearer ${bearer_token}'})
		params: {
			'api_key':  api_key
			'query':    name
			'language': language
		}
	) or { return none }

	return json.decode(models.TMDBResult, response.body) or { return none }
}

// search_trailer_movie pega um trailer baseado no id do filme e retorna o trailer no formato de string
pub fn search_trailer_movie(id int) ?scrap_models.TrailerLink {
	conf := dotenv.parse('./.env')
	bearer_token := conf['TMDB_BEARER_TOKEN']
	api_key := conf['TMDB_API_KEY']

	response := http.fetch(
		method: .get
		url:    '${url_movie_trailer}/${id}/videos'
		header: http.new_header(http.HeaderConfig{.authorization, 'Bearer ${bearer_token}'})
		params: {
			'api_key':  api_key
			'language': language
			'page':     '1'
		}
	) or { return none }

	obj := json.decode(models.MovieVideoResponseTMDB, response.body) or { return none }

	if obj.results.len == 0 {
		return none
	}

	return if obj.results[0].site.to_lower() == 'youtube' {
		'https://www.youtube.com/watch?v=${obj.results[0].key}'
	} else {
		none
	}
}
