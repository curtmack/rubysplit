require 'rspec'
require 'time_disp'

describe "Numeric#time_disp" do
    it "exists" do
        20.time_disp
    end

    it "shows the time in seconds to hundredths precision" do
        expect(2.time_disp).to eq(" 0:02.00")
        expect((40.1).time_disp).to eq(" 0:40.10")
    end

    it "shows the time in minutes and seconds to hundredths precision" do
        expect((80.1).time_disp).to eq(" 1:20.10")
        expect((680.1).time_disp).to eq("11:20.10")
    end

    it "shows the time in hours, minutes, seconds" do
        expect((3660.1).time_disp).to eq(" 1:01:00")
    end
end

describe "Numeric#time_disp_diff" do
    it "exists" do
        20.time_disp_diff
    end

    it "shows the time in seconds to hundredths precision" do
        expect(2.time_disp_diff).to eq("+ 2.00")
        expect((-40.1).time_disp_diff).to eq("-40.10")
        expect(0.time_disp_diff).to eq("+ 0.00")
    end

    it "shows the time in minutes and seconds to thundredths precision" do
        expect((80.1).time_disp_diff).to eq("+ 1:20.10")
        expect((-680.1).time_disp_diff).to eq("-11:20.10")
    end 

    it "shows the time in hours, minutes, seconds" do
        expect((3660.1).time_disp_diff).to eq("+ 1:01:00")
    end
end
