module page

import veb
import json
import shareds.wcontext
import scraping.models
import shareds.components.badge

fn render_livros_gratuitos(data models.LivroGratuitoScraping, mut ctx wcontext.WsCtx) veb.Result {
	json_data := json.encode(data)

	save_is := 'livros_gratuitos'

	genres := badge.list_badge_to_html(data.genders.to_list().map({
		'status': 'none'
		'label':  it
	}))

	tags := badge.list_badge_to_html([
		{
			'status': if data.has_link_pdf { 'success' } else { 'failure' }
			'label':  'PDF'
			'icon':   if data.has_link_pdf {
				'/assets/icons/validate-svgrepo-com.svg'
			} else {
				'/assets/icons/invalide-svgrepo-com.svg'
			}
		},
		{
			'status': if data.has_link_read_online { 'success' } else { 'failure' }
			'label':  'PDF Online'
			'icon':   if data.has_link_read_online {
				'/assets/icons/validate-svgrepo-com.svg'
			} else {
				'/assets/icons/invalide-svgrepo-com.svg'
			}
		},
	])

	return $veb.html('\\view\\card_data_livros_gratuitos.html')
}
