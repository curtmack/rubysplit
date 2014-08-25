require 'rspec'
require 'split'

describe Split do
    starttime = Time.at(0)
    endtime = Time.at(10)
    endtime_late = Time.at(20)

    describe "#-" do
        it "returns the difference in times" do
            split_a = Split.new("Test 1", starttime, endtime)
            split_b = Split.new("Test 2", starttime, endtime_late)
            (split_b - split_a).should == 10
        end
    end

    describe "#time" do
        it "returns the time in seconds between start and end" do
            split = Split.new("Test", starttime, endtime)
            split.time.should == 10
        end

        it "returns nil if start or end is nil" do
            splits = [
                Split.new("Test 1", starttime, nil),
                Split.new("Test 2", nil, endtime),
                Split.new("Test 3", nil, nil)
            ]
            splits.each do |split|
                split.time.should be_nil
            end
        end
    end

    describe "#elapsed" do
        it "returns the time from start to given time" do
            split = Split.new("Test", starttime, nil)
            split.elapsed(endtime).should == 10
        end
    end

    describe "#done?" do
        it "returns true if endtime is defined" do
            split = Split.new("Test", starttime, endtime)
            split.done?.should be_true
        end
        it "returns false if endtime is nil" do
            split = Split.new("Test", starttime, nil)
            split.done?.should be_false
        end
    end

    describe "#started?" do
        it "returns true if starttime is defined" do
            split = Split.new("Test", starttime, endtime)
            split.started?.should be_true
        end
        it "returns false if starttime is nil" do
            split = Split.new("Test", nil, endtime)
            split.started?.should be_false
        end
    end

    describe "#improved?" do
        it "returns true if current time is better than best time" do
            split_a = Split.new("Test 1", starttime, endtime_late)
            split_b = Split.new("Test 2", starttime, endtime, split_a.time)
            split_b.improved?.should be_true
        end
        it "returns false if current time is not better than best time" do
            split_a = Split.new("Test 1", starttime, endtime)
            split_b = Split.new("Test 2", starttime, endtime_late, split_a.time)
            split_b.improved?.should be_false
        end
    end

    describe "#gold" do
        it "returns the split reset with besttime set to current time" do
            split = Split.new("Test", starttime, endtime)
            split_g = split.gold
            split_g.name.should == split.name
            split_g.starttime.should == nil
            split_g.endtime.should == nil
            split_g.besttime.should == split.time
        end
    end
end
