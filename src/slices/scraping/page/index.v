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
	data := handles.handle(ctx.form['urlToScraping']) or {
		return $veb.html('\\view\\card_dados_fail.html')
	}

	if data is models.AmazonScraping {
		return render_amazom(data, mut ctx)
	} else if data is models.InstantGamesScraping {
		return render_instantgaming(data, mut ctx)
	}

	err := error("unknown scraping type")
	return $veb.html('\\view\\card_dados_fail.html')
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
