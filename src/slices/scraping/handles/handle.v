module handles

import slices.scraping.models

type TypeScrapings = models.AmazonScraping | models.InstantGamesScraping

pub fn handle(url string) !TypeScrapings {
	return if url.contains('amazon') {
		scraping_handle := AmazonHandle{}

		return scraping_handle.scraping_amazon(url)!
	} else if url.contains('instant-gaming') {
		scraping_handle := InstantGamesHandle{}
		return scraping_handle.scraping_instantgames(url)!
	} else {
		error('Não identificado um manipulador adequado para esse url')
	}
}
