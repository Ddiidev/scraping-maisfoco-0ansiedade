module models

import time

pub struct NetflixScraping {
pub:
	year             int
	title            string
	overview         string
	link             string
	genders          Genders
	thumbnails_links ThumbLink
	current_date     time.Time @[omitempty; sql_type: 'INTEGER']
}
