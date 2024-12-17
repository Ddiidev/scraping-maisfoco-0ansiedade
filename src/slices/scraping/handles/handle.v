module handles

import slices.scraping.models
import slices.scraping.handles.amazon
import slices.scraping.handles.instant_gaming

type TypeScrapings = models.AmazonScraping | models.InstantGamesScraping

pub fn handle(url string) !TypeScrapings {
	return if url.contains('amazon') {
		scraping_handle := amazon.AmazonHandle{}

		return scraping_handle.scraping_amazon(url)!
	} else if url.contains('instant-gaming') {
		scraping_handle := instant_gaming.InstantGamesHandle{}
		return scraping_handle.scraping_instantgames(url)!
	} else {
		error('Não identificado um manipulador adequado para esse url')
	}
}
