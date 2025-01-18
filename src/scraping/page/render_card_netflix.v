module page

import veb
import json
import scraping.models
import shareds.wcontext

fn render_netflix(data models.NetflixScraping, mut ctx wcontext.WsCtx) veb.Result {
	save_is := 'netflix'

	json_data := json.encode(data)

	return $veb.html('\\view\\card_data_netflix.html')
}
