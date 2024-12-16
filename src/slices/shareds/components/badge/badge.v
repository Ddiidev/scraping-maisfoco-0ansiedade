module badge

import slices.shareds.utils

pub enum StateBadge {
	none
	success
	failure
}

pub fn StateBadge.str_to(state string) ?StateBadge {
	return match state {
		'none' {
			StateBadge.none
		}
		'success' {
			StateBadge.success
		}
		'failure' {
			StateBadge.failure
		}
		else {
			none
		}
	}
}

// list_badge_to_html lista de dados de badges para tipo especial de string
// map['status'], map['icon'], map['label']
pub fn list_badge_to_html(badges []map[string]string) []utils.StringHtml {
	mut result := []utils.StringHtml{}

	for current_badge in badges {
		state := StateBadge.str_to(current_badge['status']) or { badge.StateBadge.failure }
		result << badge.construct(state, current_badge['icon'], current_badge['label'])
	}

	return result
}


pub fn construct(state StateBadge, icon string, content string) string {
	state_badge := match state {
		.none {
			'badge-none'
		}
		.success {
			'badge-success'
		}
		.failure {
			'badge-error'
		}
	}

	return $tmpl('./badge.html')
}
