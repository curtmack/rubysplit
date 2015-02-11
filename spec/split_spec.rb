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
            expect(split_b - split_a).to eq(10)
        end
    end

    describe "#time" do
        it "returns the time in seconds between start and end" do
            split = Split.new("Test", starttime, endtime)
            expect(split.time).to eq(10)
        end

        it "returns nil if start or end is nil" do
            splits = [
                Split.new("Test 1", starttime, nil),
                Split.new("Test 2", nil, endtime),
                Split.new("Test 3", nil, nil)
            ]
            splits.each do |split|
                expect(split.time).to be_nil
            end
        end
    end

    describe "#elapsed" do
        it "returns the time from start to given time" do
            split = Split.new("Test", starttime, nil)
            expect(split.elapsed(endtime)).to eq(10)
        end
    end

    describe "#done?" do
        it "returns true if endtime is defined" do
            split = Split.new("Test", starttime, endtime)
            expect(split.done?).to be true
        end
        it "returns false if endtime is nil" do
            split = Split.new("Test", starttime, nil)
            expect(split.done?).to be false
        end
    end

    describe "#started?" do
        it "returns true if starttime is defined" do
            split = Split.new("Test", starttime, endtime)
            expect(split.started?).to be true
        end
        it "returns false if starttime is nil" do
            split = Split.new("Test", nil, endtime)
            expect(split.started?).to be false
        end
    end
end
