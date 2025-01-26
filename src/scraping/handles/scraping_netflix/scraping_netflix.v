module scraping_netflix

import os
import json
import tmdb
import scraping.models

pub struct NetflixHandle {}

pub fn (nh NetflixHandle) scraping_netflix(url string) !models.NetflixScraping {
	current_dir := os.executable().split('\\')#[0..-1].join('\\')

	webview_dir := os.join_path(current_dir, 'webview', 'scraping_pages.exe')

	res := os.execute_or_exit('${webview_dir} "${url}" "scraping_netflix"')

	obj := if res.exit_code == 0 {
		json.decode(models.NetflixScraping, res.output)!
	} else {
		return error('not found data')
	}

	multimedia := tmdb.search_multimedia(obj.title) or { return obj }

	if multimedia.total_pages == 0 {
		return obj
	}
	trailer_link := tmdb.search_trailer_movie(
		id:   multimedia.results[0].id
		mode: multimedia.multimedia
	)

	return models.NetflixScraping{
		...obj
		trailer_link: trailer_link
	}
}
