module tmdb

import json
import dotenv
import net.http
import tmdb.models
import scraping.models as scrap_models

const url_search_tv = 'https://api.themoviedb.org/3/search/tv'
const url_search_movie = 'https://api.themoviedb.org/3/search/movie'

const url_movie_trailer = 'https://api.themoviedb.org/3/movie'
const url_tv_trailer = 'https://api.themoviedb.org/3/tv'
const language = 'pt-BR'

@[params]
pub struct SearchMultimediaParams {
pub:
	name string
	mode models.MultimediaMode = .search_movie
}

@[params]
pub struct SearchTrailerParams {
pub:
	id                 int
	mode               models.MultimediaMode = .search_movie
	with_language_ptbr bool                  = true
}

// search_multimedia retorna um objeto tmdb.models.TMDBResult com os resultados da busca do movie
pub fn search_multimedia(name string) ?models.TMDBResult {
	mut res := search_multimedia_with_params(name: name)

	if res == none || res?.total_results == 0 {
		res = search_multimedia_with_params(name: name, mode: .search_tv)
	}

	return res
}

// search_multimedia retorna um objeto tmdb.models.TMDBResult com os resultados da busca do movie
pub fn search_multimedia_with_params(params SearchMultimediaParams) ?models.TMDBResult {
	conf := dotenv.parse('./.env')
	bearer_token := conf['TMDB_BEARER_TOKEN']
	api_key := conf['TMDB_API_KEY']

	response := http.fetch(
		method: .get
		url:    if params.mode == .search_tv { url_search_tv } else { url_search_movie }
		header: http.new_header(http.HeaderConfig{.authorization, 'Bearer ${bearer_token}'})
		params: {
			'api_key':  api_key
			'query':    params.name
			'language': language
		}
	) or { return none }

	mut res := json.decode(models.TMDBResult, response.body) or { return none }
	res.multimedia = params.mode

	return res
}

// search_trailer_movie pega um trailer baseado no id do filme e retorna o trailer no formato de string
pub fn search_trailer_movie(params SearchTrailerParams) ?scrap_models.TrailerLink {
	res := search_trailer_movie_with_params(params)

	if res == none {
		return search_trailer_movie_with_params(SearchTrailerParams{
			...params
			with_language_ptbr: false
		})
	}

	return res
}

pub fn search_trailer_movie_with_params(params SearchTrailerParams) ?scrap_models.TrailerLink {
	conf := dotenv.parse('./.env')
	bearer_token := conf['TMDB_BEARER_TOKEN']
	api_key := conf['TMDB_API_KEY']

	mut params_req := {
		'api_key': api_key
		'page':    '1'
	}
	if params.with_language_ptbr {
		params_req['language'] = language
	}

	response := http.fetch(
		method: .get
		url:    if params.mode == .search_tv {
			'${url_tv_trailer}/${params.id}/videos'
		} else {
			'${url_movie_trailer}/${params.id}/videos'
		}
		header: http.new_header(http.HeaderConfig{.authorization, 'Bearer ${bearer_token}'})
		params: params_req
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
