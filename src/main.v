module main

import veb
import slices.shareds.wcontext
import slices.scraping.page as page_scraping

pub struct Wservice {
	veb.Controller
	veb.StaticHandler
}

fn main() {
	mut wservice := &Wservice{}

	mut ctrl_page_index := page_scraping.PageIndex{}

	wservice.handle_static('src/slices/shareds/assets', false)!
	wservice.mount_static_folder_at('src/slices/shareds/assets', '/assets')!

	wservice.handle_static('src/slices/shareds/components', false)!
	wservice.mount_static_folder_at('src/slices/shareds/components', '/components')!

	wservice.register_controller[page_scraping.PageIndex, wcontext.WsCtx]('/inicio', mut
		ctrl_page_index)!

	veb.run[Wservice, wcontext.WsCtx](mut wservice, 3030)
}

fn (ws &Wservice) index(mut ctx wcontext.WsCtx) veb.Result {
	return ctx.redirect('/inicio')
}
