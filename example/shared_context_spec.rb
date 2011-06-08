require File.expand_path(File.dirname(__FILE__) + '/shared_context')

shared_context "shared_stuff", :a => :b do
  before { @some_var = :some_value }
  def shared_method
    "it works"
  end
  let(:shared_let) { {'arbitrary' => 'object'} }
  subject do
    'this is the subject'
  end
end

describe "group that includes a shared context using 'include_context'" do
  include_context "shared stuff"

  it "has access to methods defined in shared context" do
    shared_method.should eq("it works")
  end

  it "has access to methods defined with let in shared context" do
    shared_let['arbitrary'].should eq('object')
  end

  it "runs the before hooks defined in the shared context" do
    @some_var.should be(:some_value)
  end

  it "accesses the subject defined in the shared context" do
    subject.should eq('this is the subject')
  end
end

describe "group that includes a shared context using 'include_context'", :a => :b do

  it "has access to methods defined in shared context" do
    shared_method.should eq("it works")
  end

  it "has access to methods defined with let in shared context" do
    shared_let['arbitrary'].should eq('object')
  end

  it "runs the before hooks defined in the shared context" do
    @some_var.should be(:some_value)
  end

  it "accesses the subject defined in the shared context" do
    subject.should eq('this is the subject')
  end
end

