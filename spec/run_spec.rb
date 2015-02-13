require 'rspec'
require 'run'
require 'split'

describe Run do
    time0 = Time.at(0)
    time10 = Time.at(10)
    time20 = Time.at(20)
    time30 = Time.at(30)

    splitnil = Split.new("Test split", nil, nil)
    split0 = Split.new("Test split 0", time0, time10)
    split10 = Split.new("Test split 10", time10, time20)
    split20 = Split.new("Test split 20", time20, time30)

    it "has correct constructer and fields" do
        urn = Run.new("Test game", "Test route", [splitnil])

        expect(urn.game).to eq("Test game")
        expect(urn.route).to eq("Test route")
        expect(urn.splits.first.name).to eq("Test split")
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
            urn = Run.new("Test game", "Test route", [splitnil, split0])
            expect(urn.running?).to be false
        end
        it "returns false if done" do
            urn = Run.new("Test game", "Test route", [split0, split10, split20])
            expect(urn.running?).to be false
        end
        it "returns true if started but not done" do
            urn = Run.new("Test game", "Test route", [split0, split10, splitnil])
            expect(urn.running?).to be true
        end
    end
end
