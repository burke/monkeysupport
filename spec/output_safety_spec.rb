require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe String do
  context "newly created" do
    it "should not be html_safe" do
      "foo bar baz".html_safe?.should be_false
    end
  end

  context "not marked as html_safe" do
    it "should be html_safe once marked as html_safe" do
      "foo".html_safe.html_safe?.should be_true
    end
    it "should be equal to the same html_safe string" do
      "foo".html_safe.should ==("foo")
    end
    it "should return the same string after calling html_safe!" do
      foo = "bar"
      bar = foo.html_safe!
      foo.should equal(bar)
    end
    it "should be modified when html_safe! is called" do
      foo = "bar"
      foo.html_safe!
      foo.html_safe?.should be_true
    end
  end

  context "marked as html_safe" do
    it "should become html_unsafe when an unsafe string is concatenated to it" do
      foo = "bar".html_safe
      foo << "baz"
      foo.html_safe?.should be_false
    end
    it "should remain html_safe when a safe string is concatenated to it" do
      foo = "bar".html_safe
      foo << "baz".html_safe
      foo.html_safe?.should be_true
    end
    it "should return an unsafe string when added to an unsafe string" do
      ("foo".html_safe + "bar").html_safe?.should be_false
    end
    it "should return safe string when added to a safe string" do
      ("foo".html_safe + "bar".html_safe).html_safe?.should be_true
    end
  end
  
end
