require 'spec_helper'

describe UsersHelper do
  describe "#get_gravatar" do
    let(:user) { build(:user, email: "user@test.com") }

    it 'returns an expected image url to gravatar with correctly hashed email' do
      email_md5 = Digest::MD5.hexdigest(user.email).to_s
      url = "http://www.gravatar.com/avatar/#{email_md5}.jpg?s=80"

      expect(helper.get_gravatar(user, 80)).to eql(url)
    end
  end
end
