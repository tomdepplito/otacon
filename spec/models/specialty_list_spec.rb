require 'spec_helper'

describe SpecialtyList do

  it { should belong_to(:user) }

  describe '#add_keyword' do
    before :each do
      @list = FactoryGirl.create(:specialty_list)
      @list.add_keyword('wires', 'electronics')
    end
    it 'should add a single keyword to the proper keyword array' do
      @list.electronics.length.should == 1
    end

    it 'should not add a duplicate keyword to an array' do
      @list.add_keyword('wires', 'electronics')
      @list.electronics.length.should == 1
    end
  end

  describe '#all_keywords' do
    before :each do
      @list = FactoryGirl.create(:specialty_list)
      @list.electronics << /breakers/
      @list.electronics << /wires/
    end

    it 'should return an array with the correct number of keywords' do
      @list.all_keywords.length.should == 2
    end

    it 'should return the correct keywords' do
      @list.all_keywords.include?(/breakers/)
      @list.all_keywords.include?(/wires/)
    end
  end
end
