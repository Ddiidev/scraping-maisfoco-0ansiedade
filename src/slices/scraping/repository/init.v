module repository

import slices.shareds.db
import slices.scraping.models

fn init() {
	db.create_table[models.AmazomScraping]() or {
		panic(err.str())
	}
}
