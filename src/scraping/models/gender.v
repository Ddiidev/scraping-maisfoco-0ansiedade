module models

pub type Genders = string

pub fn (g Genders) to_list() []string {
	genders := g.split(',')
	return if genders.len == 0 {
		g.split(' e ')
	} else {
		genders
	}
}

pub fn (g Genders) add(genders ...string) Genders {
	return g + ',' + genders.join(',')
}
