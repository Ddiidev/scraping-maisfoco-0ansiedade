module repository

import slices.shareds.db
import slices.scraping.models

fn init() {
	println('Initializing the repository...')
	con := db.new() or { panic(err.str()) }

	sql con {
		create table models.AmazonScraping
		create table models.InstantGamesScraping
		create table models.InstantGamesImage
	} or { panic(err.str()) }
}
