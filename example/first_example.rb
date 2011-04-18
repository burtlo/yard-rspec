class String
  # Pig latin of a String
  def pig_latin
    self[1..-1] + self[0] + "ay"
  end
end

# 
# Specs
# 
describe String do
  describe '#pig_latin' do
    it "should be a pig!" do
      "hello".pig_latin.should == "ellohay"
     end
  
    it "should fail to be a pig!" do
      "hello".pig_latin.should == "hello"
    end
  end
  
  context '#pig_latin' do
    it "should be a pig (within a context)" do
      "hello".pig_latin.should == "ellohay"
    end
  end
  
end

describe String do
  it "should be empty" do
    subject.should eq("") 
  end
end

describe Fixnum do
  it "should be equal to 0" do
    subject.should eq(0)
  end
end