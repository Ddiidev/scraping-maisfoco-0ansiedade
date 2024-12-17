module repository

import slices.shareds.db
import slices.scraping.models

pub struct RepoInstantGaming {}

pub fn RepoInstantGaming.new(model models.InstantGamesScraping) ! {
	con := db.new()!

	sql con {
		insert model into models.InstantGamesScraping
	}!
}
