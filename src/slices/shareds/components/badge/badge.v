module badge

pub enum StateBadge {
	success
	failure
}

pub fn construct(state StateBadge, icon string, content string) string {
	state_badge := match state {
		.success {
			'badge-success'
		}
		.failure {
			'badge-error'
		}
	}
	
	return $tmpl('./badge.html')
}