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

    describe "#running?" do
        it "returns true if started but not done" do
            split = Split.new("Test", starttime, nil)
            expect(split.running?).to be true
        end
        it "returns false if not started or done" do
            split = Split.new("Test", nil, nil)
            expect(split.running?).to be false
            split = Split.new("Test", starttime, endtime)
            expect(split.running?).to be false
        end
    end

    describe "#start" do
        it "returns a copy with starttime set to now" do
            split = Split.new("Test", nil, nil)
            started = split.start(starttime)
            expect(started.started?).to be true
            expect(started.starttime).to equal(starttime)
            expect(started.endtime).to be_nil
        end

        it "raises an ArgumentError if already started" do
            split = Split.new("Test", starttime, nil)
            expect { split.start(starttime) }.to raise_error(ArgumentError)
        end
    end

    describe "#stop" do
        it "returns a copy with endtime set to now" do
            split = Split.new("Test", starttime, nil)
            stopped = split.stop(endtime)
            expect(stopped.done?).to be true
            expect(stopped.starttime).to equal(starttime)
            expect(stopped.endtime).to equal(endtime)
        end

        it "raises an ArgumentError if already stopped or not started" do
            split = Split.new("Test", nil, nil)
            expect { split.stop(endtime) }.to raise_error(ArgumentError)
            split = Split.new("Test", starttime, endtime)
            expect { split.stop(endtime) }.to raise_error(ArgumentError)
        end

        it "raises an ArgumentError if stopping before starttime" do
            split = Split.new("Test", endtime, nil)
            expect { split.stop(starttime) }.to raise_error(ArgumentError)
        end
    end

    describe "#skip" do
        it "returns a copy with no time and skipped set to true" do
            split = Split.new("Test", starttime, nil)
            skipped = split.skip
            expect(skipped.skipped).to be true
            expect(skipped.starttime).to be_nil
            expect(skipped.endtime).to be_nil
        end

        it "raises an ArgumentError if not running" do
            split = Split.new("Test", nil, nil)
            expect { split.skip }.to raise_error(ArgumentError)
        end
    end
end
