feature 'adding tags to links' do

	scenario 'adds tags to link' do
		add_link
		fill_in('link_tag', with: 'social media')
		click_button('Add')
		within('ul#links') do
    	expect(page).to have_content('social media')

    end
  end

  scenario 'adds multiple tags to link' do
  	add_link
  	fill_in('link_tag', with: 'social media, procrastination')
  	click_button('Add')
  	#within('ul#links') do
  	link = Link.first
  	expect(link.tags.map(&:name)).to eq ['social media', 'procrastination']
  end

end

