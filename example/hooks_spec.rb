require "rspec/expectations"

class Thing
  def widgets
    @widgets ||= []
  end
end

describe Thing do
  before(:each) do
    @thing = Thing.new
  end

  describe "initialized in before(:each)" do
    it "has 0 widgets" do
      @thing.should have(0).widgets
    end

    it "can get accept new widgets" do
      @thing.widgets << Object.new
    end

    it "does not share state across examples" do
      @thing.should have(0).widgets
    end
  end
end

class Database
  def self.transaction
    puts "open transaction"
    yield
    puts "close transaction"
  end
end

describe "around filter" do
  around(:each) do |example|
    Database.transaction(&example)
  end

  it "gets run in order" do
    puts "run the example"
  end
end