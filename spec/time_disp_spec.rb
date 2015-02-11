require 'rspec'
require 'time_disp'

describe "Numeric#time_disp" do
    it "exists" do
        20.time_disp
    end

    it "shows the time in seconds to hundredths precision" do
        2.time_disp.should == " 0:02.00"
        (40.1).time_disp.should == " 0:40.10"
    end

    it "shows the time in minutes and seconds to hundredths precision" do
        (80.1).time_disp.should == " 1:20.10"
        (680.1).time_disp.should == "11:20.10"
    end

    it "shows the time in hours, minutes, seconds" do
        (3660.1).time_disp.should == " 1:01:00"
    end
end

describe "Numeric#time_disp_diff" do
    it "exists" do
        20.time_disp_diff(20)
    end

    it "shows the time in seconds to hundredths precision" do
        4.time_disp_diff(2).should == "+ 2.00"
        20.time_disp_diff(60.1).should == "-40.10"
        2.time_disp_diff(2).should == "+ 0.00"
    end

    it "shows the time in minutes and seconds to thundredths precision" do
        (90.1).time_disp_diff(10).should == "+ 1:20.10"
        (10).time_disp_diff(690.1).should == "-11:20.10"
    end 

    it "shows the time in hours, minutes, seconds" do
        (3670.1).time_disp_diff(10).should == "+ 1:01:00"
    end
end
