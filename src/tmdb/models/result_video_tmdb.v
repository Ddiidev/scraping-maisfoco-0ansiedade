module models

pub struct MovieVideoResponseTMDB {
pub:
	id      int                    @[omitempty]
	results []MovieVideoTMDBResult @[omitempty]
}

pub struct MovieVideoTMDBResult {
pub mut:
	iso_639_1    string @[omitempty]
	iso_3166_1   string @[omitempty]
	name         string @[omitempty]
	key          string @[omitempty]
	site         string @[omitempty]
	size         int    @[omitempty]
	type         string @[omitempty]
	official     bool   @[omitempty]
	published_at string @[omitempty]
	id           string @[omitempty]
}
