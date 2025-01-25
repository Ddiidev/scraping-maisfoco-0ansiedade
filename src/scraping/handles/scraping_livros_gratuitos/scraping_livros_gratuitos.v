module scraping_livros_gratuitos

import os
import json
import scraping.models

pub struct LivrosGratuitosHandle {}

pub fn (nh LivrosGratuitosHandle) scraping_livros_gratuitos(url string) !models.LivroGratuitoScraping {
	current_dir := os.executable().split('\\')#[0..-1].join('\\')

	webview_dir := os.join_path(current_dir, 'webview', 'scraping_pages.exe')

	res := os.execute_or_exit('${webview_dir} "${url}" "scraping_livros_gratuitos"')

	obj := if res.exit_code == 0 {
		json.decode(models.LivroGratuitoScraping, res.output)!
	} else {
		return error('not found data')
	}

	return obj
}
