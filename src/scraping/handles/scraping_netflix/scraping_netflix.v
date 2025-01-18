module scraping_netflix

import os
import json
import scraping.models

pub struct NetflixHandle {}

pub fn (nh NetflixHandle) scraping_netflix(url string) !models.NetflixScraping {
	current_dir := '${@FILE}'.split('\\')#[0..-1].join('\\')

	webview_dir := os.join_path(current_dir, 'webview', 'scraping_netflix.exe')

	res := os.execute_or_exit('${webview_dir} "${url}" "scraping_netflix"')

	if res.exit_code == 0 {
		return json.decode(models.NetflixScraping, res.output)
	}

	return error('not implemented')
}
