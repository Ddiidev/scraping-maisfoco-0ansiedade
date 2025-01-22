module page

import veb
import json
import scraping.models
import shareds.wcontext
import scraping.repository

@['/save/:save_is'; post]
fn (page &PageIndex) save(mut ctx wcontext.WsCtx, save_is string) veb.Result {
	lng := rlock page.current_lang {
		page.current_lang.abbrev_lang
	}

	if save_is == 'amazon' {
		js := json.decode(models.AmazonScraping, ctx.req.data) or {
			return page.modal(mut ctx, veb.tr(lng, 'msg_error_fail_to_save'), 'error: Invalid JSON data')
		}

		repository.RepoAmazon.new(js) or {
			return page.modal(mut ctx, veb.tr(lng, 'msg_error_fail_to_save'), 'error: Data already exists')
		}
	} else if save_is == 'instant-gaming' {
		js := json.decode(models.InstantGamesScraping, ctx.req.data) or {
			return page.modal(mut ctx, veb.tr(lng, 'msg_error_fail_to_save'), 'error: Invalid JSON data')
		}

		repository.RepoInstantGaming.new(js) or {
			return page.modal(mut ctx, veb.tr(lng, 'msg_error_fail_to_save'), 'error: Data already exists')
		}
	} else if save_is == 'mercado_livre_play' {
		js := json.decode(models.MercadoLivrePlayScraping, ctx.req.data) or {
			return page.modal(mut ctx, veb.tr(lng, 'msg_error_fail_to_save'), 'error: Invalid JSON data')
		}

		repository.RepoMercadoLivrePlay.new(js) or {
			return page.modal(mut ctx, veb.tr(lng, 'msg_error_fail_to_save'), 'error: Data already exists')
		}
	} else if save_is == 'netflix' {
		js := json.decode(models.NetflixScraping, ctx.req.data) or {
			return page.modal(mut ctx, veb.tr(lng, 'msg_error_fail_to_save'), 'error: Invalid JSON data')
		}

		repository.RepoNetflix.new(js) or {
			return page.modal(mut ctx, veb.tr(lng, 'msg_error_fail_to_save'), 'error: Data already exists')
		}
	} else if save_is == 'livros_gratuitos' {
		js := json.decode(models.LivroGratuitoScraping, ctx.req.data) or {
			return page.modal(mut ctx, veb.tr(lng, 'msg_error_fail_to_save'), 'error: Invalid JSON data')
		}

		repository.RepoLivrosGratuitos.new(js) or {
			return page.modal(mut ctx, veb.tr(lng, 'msg_error_fail_to_save'), 'error: Data already exists')
		}
	}

	return page.modal(mut ctx, veb.tr(lng, 'msg_successfully_saved'), veb.tr(lng, 'msg_all_completed'))
}
