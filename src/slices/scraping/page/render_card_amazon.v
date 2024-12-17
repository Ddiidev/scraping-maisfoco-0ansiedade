module page

import veb
import json
import slices.shareds.wcontext
import slices.scraping.models

fn render_amazom(data models.AmazonScraping, mut ctx wcontext.WsCtx) veb.Result {
	json_data := json.encode(data)

	price_printed := data.price_printed or { 0 }.str()
	price_kindle_ebook := data.price_kindle_ebook or { 0 }.str()
	url := ctx.get_custom_header('HX-Current-URL') or { '' }
	save_is := 'amazon'

	return $veb.html('\\view\\card_dados_amazon.html')
}
