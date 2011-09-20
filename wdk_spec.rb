#encoding: utf-8
require "./wdk_method.rb"


  describe Wadoku do
    it "should parse <HW NAr: C>" do
    "<HW NAr: C>".gsub(Wadoku::HW_regex, "").should == "C"
    end
    it "should parse  <HW m: Vokal> „<Topic: a>“" do
    "<HW m: Vokal> „<Topic: a>“".gsub(Wadoku::HW_regex, "").should == "Vokal „<Topic: a>“"
    end
  end
