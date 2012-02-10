require 'spec_helper'

describe "Artist Model" do
  let(:artist) { Artist.new }
  it 'can be created' do
    artist.should_not be_nil
  end
end
