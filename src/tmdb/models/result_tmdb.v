module models

pub struct TMDBResult {
pub mut:
	multimedia    MultimediaMode
	page          int
	results       []Results
	total_pages   int
	total_results int
}

pub struct Results {
pub mut:
	adult             bool
	backdrop_path     string
	genre_ids         []int
	id                int
	original_language string
	original_title    string
	overview          string
	popularity        f32
	poster_path       string
	release_date      string
	title             string
	video             bool
	vote_average      f32
	vote_count        int
}
