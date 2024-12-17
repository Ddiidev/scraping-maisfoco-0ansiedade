module utils

// The primitive string type is displayed as #text in HTML.
// However, if it is a String Alias, the content will be rendered.
pub type StringHtml = string

pub fn (sh []StringHtml) str() string {
	return sh.join_lines()
}
