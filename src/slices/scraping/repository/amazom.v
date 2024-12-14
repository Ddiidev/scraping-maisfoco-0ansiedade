module repository

import slices.shareds.db
import slices.scraping.models

pub struct RepoAmazon {}

pub fn RepoAmazon.new(repo models.AmazomScraping) ! {
	con := db.new()!

	sql con {
		insert repo into models.AmazomScraping
	}!
	
}