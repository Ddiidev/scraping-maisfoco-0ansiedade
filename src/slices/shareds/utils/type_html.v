module utils

pub type StringHtml = string

pub fn (sh []StringHtml) str() string {
	return sh.join_lines()
}