def add_link
	visit('/links/new')
  fill_in('link_title', with: 'Facebook')
  fill_in('link_url', with: 'http://facebook.com')
end
