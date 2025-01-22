module handles

import veb
import scraping.models
import scraping.handles.amazon
import scraping.handles.instant_gaming
import scraping.handles.scraping_netflix
import scraping.handles.mercado_livre_play
import scraping.handles.scraping_livros_gratuitos

type TypeScrapings = models.AmazonScraping
	| models.InstantGamesScraping
	| []models.MercadoLivrePlayScraping
	| models.NetflixScraping
	| models.LivroGratuitoScraping

pub fn handle(url string, lang string) !TypeScrapings {
	return if ['amzn.to', 'amazon'].any(url.contains(it)) {
		scraping_handle := amazon.AmazonHandle{lang}

		return scraping_handle.scraping_amazon(url)!
	} else if url.contains('instant-gaming') {
		scraping_handle := instant_gaming.InstantGamesHandle{lang}

		return scraping_handle.scraping_instantgames(url)!
	} else if url.contains('mercadolivre') {
		scraping_handle := mercado_livre_play.MercadoLivrePlayHandle{lang}

		return scraping_handle.scraping_mercado_livre_play(url)!
	} else if url.contains('netflix') {
		scraping_handle := scraping_netflix.NetflixHandle{}

		return scraping_handle.scraping_netflix(url)!
	} else if url.contains('livrosgratuitos') {
		scraping_handle := scraping_livros_gratuitos.LivrosGratuitosHandle{}

		return scraping_handle.scraping_livros_gratuitos(url)!
	} else {
		error(veb.tr(lang, 'msg_error_not_found_handler_from_plataform'))
	}
}
