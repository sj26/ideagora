require "acceptance/acceptance_helper"

feature 'A user viewing and editing their profile' do
  let!(:camp) { create(:camp) }
  let!(:user) { create(:user).tap { |user| create(:attendance, camp: camp, user: user) } }

  before { sign_in_as(user) }

  context 'when a user views their profile page' do
    it 'shows them their profile info' do
      visit my_profile_path

      #showing all our attributes in editable fields?
      profile_attrs = %w(first_name last_name email bio twitter bonjour irc)
      profile_attrs.each do |attr|
        expect(page).to have_field(attr.humanize)
        expect(first(:field, attr.humanize).value).to eql(user.send(attr))
      end

      expect(page).to have_field('Skill list',    :with => user.skill_list.sort.join(', '))
      expect(page).to have_field('Interest list', :with => user.interest_list.sort.join(', '))
    end
  end

  context 'when a user updates their profile' do
    it 'saves the new values and shows them the edit page again' do
      visit my_profile_path

      new_attrs = { 
        :first_name => 'GabeNew',
        :last_name => 'HollombeNew',
        :email => 'gabenew@railscampers.com',
        :bio => 'New bio',
        :twitter => 'gabehollombenew',
        :bonjour => 'bonjournew',
        :irc => 'ircnew',
        :skill_list => 'javascriptnew, rspecnew',
        :interest_list => 'divingnew, game-devnew'
      }

      new_attrs.each do |attr, new_value|
        fill_in attr.to_s.humanize, with: new_value
      end

      page.click_button 'Update User'

      #redirected back on edit page?
      expect(current_path).to eql(my_profile_path)

      #new values saved?
      new_attrs.each do |attr, new_value|
        expect(page).to have_field(attr.to_s.humanize, with: new_value)
      end
    end
  end
end
