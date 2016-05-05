feature 'Submitting new link' do
	
  scenario 'adds new link to links page when submitted' do
    add_link
    click_button('Add')
    within('ul#links') do
    	expect(page).to have_content('Facebook')
    end
  end

end