module page

import veb
import json
import slices.scraping.models
import slices.shareds.wcontext
import slices.scraping.handles
import slices.scraping.repository
import slices.shareds.components.badge

const badges = [
	{
		'status': 'success'
		'icon':   '/assets/icons/validate-svgrepo-com.svg'
		'label':  'Amazon Livros'
	},
	{
		'status': 'failure'
		'icon':   '/assets/icons/invalide-svgrepo-com.svg'
		'label':  'InstantGames'
	},
	{
		'status': 'failure'
		'icon':   '/assets/icons/invalide-svgrepo-com.svg'
		'label':  'EpicGames'
	},
	{
		'status': 'failure'
		'icon':   '/assets/icons/invalide-svgrepo-com.svg'
		'label':  'Steam'
	},
	{
		'status': 'failure'
		'icon':   '/assets/icons/invalide-svgrepo-com.svg'
		'label':  'Netflix'
	},
	{
		'status': 'failure'
		'icon':   '/assets/icons/invalide-svgrepo-com.svg'
		'label':  'Prime'
	},
	{
		'status': 'failure'
		'icon':   '/assets/icons/invalide-svgrepo-com.svg'
		'label':  'Disney+'
	},
	{
		'status': 'failure'
		'icon':   '/assets/icons/invalide-svgrepo-com.svg'
		'label':  'HBO'
	},
]

@['/']
fn (page &PageIndex) index(mut ctx wcontext.WsCtx) veb.Result {
	badges_html := badge.list_badge_to_html(badges)

	return $veb.html('\\view\\index.html')
}

@['/scraping'; post]
fn (page &PageIndex) scraping(mut ctx wcontext.WsCtx) veb.Result {
	dados := handles.handle(ctx.form['urlToCrawler']) or {
		return $veb.html('\\view\\card_dados_fail.html')
	}

	if dados is models.AmazonScraping {
		json_dados := json.encode(dados)

		price_printed := dados.price_printed or { 0 }.str()
		price_kindle_ebook := dados.price_kindle_ebook or { 0 }.str()
		url := ctx.get_custom_header('HX-Current-URL') or { '' }
		save_is := 'amazon'

		return $veb.html('\\view\\card_dados_amazon.html')
	} else if dados is models.InstantGamesScraping {
		json_dados := json.encode(dados)

		price := dados.price
		discount := dados.discount or { 0 }.str()
		old_price := dados.price_old or { 0 }.str()
		banner_img := dados.images[0] or { models.InstantGamesImage{} }.image_url
		url := ctx.get_custom_header('HX-Current-URL') or { '' }
		badges_html := badge.list_badge_to_html(dados.tags.to_list().map({
			'status': 'none'
			'label':  it
		}))
		save_is := 'instant-gaming'

		return $veb.html('\\view\\card_dados_instantgames.html')
	}

	return ctx.text('erro')
}

@['/save/:save_is'; post]
fn (page &PageIndex) save(mut ctx wcontext.WsCtx, save_is string) veb.Result {
	if save_is == 'amazon' {
		js := json.decode(models.AmazonScraping, ctx.req.data) or {
			return page.modal(mut ctx, 'Falhou ao salvar', 'error: Invalid JSON data')
		}

		repository.RepoAmazon.new(js) or {
			return page.modal(mut ctx, 'Falhou ao salvar', 'error: Data already exists')
		}
	} else if save_is == 'instant-gaming' {
		js := json.decode(models.InstantGamesScraping, ctx.req.data) or {
			return page.modal(mut ctx, 'Falhou ao salvar', 'error: Invalid JSON data')
		}

		repository.RepoInstantGaming.new(js) or {
			return page.modal(mut ctx, 'Falhou ao salvar', 'error: Data already exists')
		}
	}


	return page.modal(mut ctx, 'Salvou com sucesso!', 'Tudo pronto!')
}

fn (page &PageIndex) modal(mut ctx wcontext.WsCtx, title string, content string) veb.Result {
	return $veb.html('\\view\\modal.html')
}
