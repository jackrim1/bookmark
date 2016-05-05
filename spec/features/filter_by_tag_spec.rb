feature 'filter links by tag' do

  scenario 'only see links with the tag when filtering by a certain tag' do
    visit('/links/new')
    fill_in('link_title', with: 'Facebook')
    fill_in('link_url', with: 'http://facebook.com')
    fill_in('link_tag', with: 'bubbles')
    click_button('Add')
    visit('/links/new')
    fill_in('link_title', with: 'Google')
    fill_in('link_url', with: 'http://google.com')
    fill_in('link_tag', with: 'bubbles')
    click_button('Add')
    visit('/links/new')
    fill_in('link_title', with: 'Bing')
    fill_in('link_url', with: 'http://bing.com')
    fill_in('link_tag', with: 'no bubble')
    click_button('Add')
    visit('/links/new')
    fill_in('link_title', with: 'Yahoo')
    fill_in('link_url', with: 'http://yahoo.com')
    fill_in('link_tag', with: 'no bubble')
    click_button('Add')
    visit '/tags/bubbles'

    within('ul#links') do
      expect(page).to have_content 'Facebook'
      expect(page).to have_content 'Google'
      expect(page).not_to have_content 'Bing'
      expect(page).not_to have_content 'Yahoo'
    end
  end

end