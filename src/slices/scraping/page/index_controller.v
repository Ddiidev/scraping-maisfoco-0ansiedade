module page

import veb
import slices.shareds.wcontext

pub struct PageIndex {
	veb.Middleware[wcontext.WsCtx]
}