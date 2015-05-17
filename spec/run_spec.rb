require 'rspec'
require 'run'
require 'split'

describe Run do
    time0 = Time.at(0)
    time10 = Time.at(10)
    time20 = Time.at(20)
    time30 = Time.at(30)

    splitnil = Split.new("Test split", nil, nil)
    split10nil = Split.new("Test split", time20, nil)
    split0 = Split.new("Test split 0", time0, time10)
    split10 = Split.new("Test split 10", time10, time20)
    split20 = Split.new("Test split 20", time20, time30)

    # For non-speedrunners who might read these tests someday:
    # Referring to a good run as "the urn" is a running joke.

    it "has correct constructer and fields" do
        urn = Run.new("Test game", "Test route", [splitnil])

            expect(urn.is_a? Run).to be true
            expect(urn.game).to eq("Test game")
            expect(urn.route).to eq("Test route")
            expect(urn.splits.first.name).to eq("Test split")
            expect(urn.currsplit).to eq(0)
        end
        it "raises ArgumentError if splits don't make sense" do
            expect { Run.new("Test game", "Test route", [split0, split20]) }.to raise_error(ArgumentError)
            expect { Run.new("Test game", "Test route", [split10, split0]) }.to raise_error(ArgumentError)
        end
    end

    describe "#starttime" do
        it "returns nil if no splits" do
            urn = Run.new("Test game", "Test route", [])
            expect(urn.starttime).to be_nil
        end
        it "returns nil if first split hasn't been started" do
            urn = Run.new("Test game", "Test route", [splitnil])
            expect(urn.starttime).to be_nil
        end
        it "returns the starttime of the first split" do
            urn = Run.new("Test game", "Test route", [split0, split10, split20])
            expect(urn.starttime).to eq(time0)
        end
    end

    describe "#endtime" do
        it "returns nil if no splits" do
            urn = Run.new("Test game", "Test route", [])
            expect(urn.endtime).to be_nil
        end
        it "returns nil if last split hasn't ended" do
            urn = Run.new("Test game", "Test route", [splitnil])
            expect(urn.endtime).to be_nil
        end
        it "returns the endtime of the last split" do
            urn = Run.new("Test game", "Test route", [split0, split10, split20])
            expect(urn.endtime).to eq(time30)
        end
    end

    describe "#time" do
        it "returns nil if start or end is nil" do
            runs = [
                Run.new("Test game", "Test route", []),
                Run.new("Test game", "Test route", [splitnil])
            ]
            runs.each do |urn|
                expect(urn.time).to be_nil
            end
        end
        it "returns the difference between starttime and endtime" do
            urn = Run.new("Test game", "Test route", [split0, split10, split20])
            expect(urn.time).to eq(30)
        end
    end

    describe "#elapsed" do
        it "returns nil if start is nil" do
            urn = Run.new("Test game", "Test route", [])
            expect(urn.elapsed(time30)).to be_nil
        end
        it "returns the time from starttime to end" do
            urn = Run.new("Test game", "Test route", [split0, split10, split10nil])
            expect(urn.elapsed(time30)).to eq(30)
        end
    end

    describe "#started?" do
        it "returns nil if no splits" do
            urn = Run.new("Test game", "Test route", [])
            expect(urn.started?).to be_nil
        end
        it "returns false if first split hasn't been started" do
            urn = Run.new("Test game", "Test route", [splitnil])
            expect(urn.started?).to be false
        end
        it "returns true if first split has started" do
            urn = Run.new("Test game", "Test route", [split0, split10, split20])
            expect(urn.started?).to be true
        end
    end

    describe "#done?" do
        it "returns nil if no splits" do
            urn = Run.new("Test game", "Test route", [])
            expect(urn.done?).to be_nil
        end
        it "returns false if last split hasn't ended" do
            urn = Run.new("Test game", "Test route", [splitnil])
            expect(urn.done?).to be false
        end
        it "returns true if last split has ended" do
            urn = Run.new("Test game", "Test route", [split0, split10, split20])
            expect(urn.done?).to be true
        end
    end

    describe "#running?" do
        it "returns nil if no splits" do
            urn = Run.new("Test game", "Test route", [])
            expect(urn.running?).to be_nil
        end
        it "returns false if not started" do
            urn = Run.new("Test game", "Test route", [splitnil, splitnil])
            expect(urn.running?).to be false
        end
        it "returns false if done" do
            urn = Run.new("Test game", "Test route", [split0, split10, split20])
            expect(urn.running?).to be false
        end
        it "returns true if started but not done" do
            urn = Run.new("Test game", "Test route", [split0, split10, split10nil])
            expect(urn.running?).to be true
        end
    end

    describe "#next" do
        splits = [
            Split.new("Test split 1", nil, nil),
            Split.new("Test split 2", nil, nil),
            Split.new("Test split 3", nil, nil)
        ]
        it "returns self if no splits" do
            urn = Run.new("Test game", "Test route", [])
            expect(urn.next(time0)).to eq(urn)
        end
        it "returns self with first split running if not started" do
            urn = Run.new("Test game", "Test route", splits)
            expect(urn.next(time0).splits.first.starttime).to eq(time0)
            expect(urn.next(time0).currsplit).to eq(0)
        end
        it "progresses the run" do
            urn = Run.new("Test game", "Test route", splits)

            urn0 = urn.next(time0)
            expect(urn0.started?).to be true

            urn10 = urn0.next(time10)
            expect(urn10.currsplit).to eq(1)
            expect(urn10.splits.first.time).to eq(10)

            urn20 = urn10.next(time20)
            expect(urn20.currsplit).to eq(2)
            expect(urn20.splits[1].time).to eq(10)

            urn30 = urn20.next(time30)
            expect(urn30.currsplit).to eq(3)
            expect(urn30.splits[2].time).to eq(10)
            expect(urn30.done?).to be true
        end
        it "returns self if done" do
            urn = Run.new("Test game", "Test route", [split0, split10, split20])
            expect(urn.next(time30)).to eq(urn)
        end
    end
end
