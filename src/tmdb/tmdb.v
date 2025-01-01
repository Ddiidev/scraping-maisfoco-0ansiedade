module tmdb

import json
import dotenv
import net.http
import tmdb.models

const url = 'https://api.themoviedb.org/3/search/movie'
const language = 'pt-BR'

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
