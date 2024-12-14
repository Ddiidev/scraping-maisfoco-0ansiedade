module page

import veb
import json
import slices.shareds.wcontext
import slices.scraping.handles
import slices.shareds.components.badge

@['/']
fn (page &PageIndex) index(mut ctx wcontext.WsCtx) veb.Result {
	badge_construct := badge.construct
	
	return $veb.html('\\view\\index.html')
}

@['/scraping'; post]
fn (page &PageIndex) scraping(mut ctx wcontext.WsCtx) veb.Result {
	dados := handles.scraping_amazom(ctx.form['urlToCrawler']) or {
		return $veb.html('\\view\\card_dados_fail.html')
	}

	json_dados := json.encode(dados) 

	price_printed := dados.price_printed or { 0 }.str()
	price_kindle_ebook := dados.price_kindle_ebook or { 0 }.str()

	return $veb.html('\\view\\card_dados_amazon.html')
}

@['/save'; post]
fn (page &PageIndex) save(mut ctx wcontext.WsCtx) veb.Result {
	return ctx.text('')
}