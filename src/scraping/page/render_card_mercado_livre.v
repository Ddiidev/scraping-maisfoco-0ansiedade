module page

import veb
import json
import shareds.wcontext
import scraping.models

fn render_mercado_livre_play(datas []models.MercadoLivrePlayScraping, mut ctx wcontext.WsCtx) veb.Result {
	mut jsons_data := []string{}

	for data in datas {
		jsons_data << json.encode(data)
	}

	save_is := 'mercado_livre_play'

	return $veb.html('\\view\\card_data_mercado_livre_play.html')
}
