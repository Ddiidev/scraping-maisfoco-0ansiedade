import os
import time
import ttytm.webview { Event }

#include <windows.h>

fn C.ShowWindow(hwnd HWND, nCmdShow int) int

const sw_minimize = 6

const scripts = {
	'scraping_netflix': $embed_file('./scripts_js/scrapPageNetflix.js')
}

fn main() {
	run_webview(os.args[1], os.args[2])!
}

fn run_webview(url string, file_script string) ! {
	w := webview.create(debug: true)

	defer {
		w.destroy()
	}
	w.set_title('Netflix scraping')
	w.set_size(1280, 1024, .@none)
	C.ShowWindow(w.get_window(), sw_minimize)

	// w.set_icon('${@VMODROOT}/icon.ico')!
	w.bind('scrapedNetflix', scraped_netflix)
	w.navigate(url)

	time.sleep(1000 * time.millisecond)
	w.eval(scripts[file_script] or { exit(1) }.to_string())

	w.run()
}

fn scraped_netflix(e &Event) voidptr {
	arg := e.get_arg[string](0) or { exit(1) }

	println(arg)
	exit(0)
}
