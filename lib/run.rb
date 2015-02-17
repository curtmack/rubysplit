require 'split'

class Run
    attr_reader :game, :route, :splits, :currsplit

    def initialize(game, route, splits = [], currsplit = 0)
        @game = game
        @route = route
        @splits = (splits.nil? ? [] : splits)
        @currsplit = (currsplit < 0 ? 0 : currsplit)
    end

    def starttime
        return nil if splits.length.zero?
        splits.first.starttime
    end

    def endtime
        return nil if splits.length.zero?
        splits.last.endtime
    end

    def time
        return nil if starttime.nil?
        return nil if endtime.nil?
        endtime - starttime
    end

    def elapsed(now)
        return nil if starttime.nil?
        now - starttime
    end

    def started?
        return nil if splits.length.zero?
        splits.first.started?
    end

    def done?
        return nil if splits.length.zero?
        splits.last.done?
    end

    def running?
        started? && !done?
    end

    def next(now)
        return self if splits.length.zero?
        return self if done?
        if !started? then
            nextsplits =
                [@splits[0].start(now)] +
                @splits[1, splits.length]
            return Run.new(@game, @route, nextsplits, @currsplit)
        else
            if @splits[@currsplit+1].nil? then
                nextsplits =
                    @splits[0, @currsplit] +
                    [@splits[@currsplit].stop(now)]
                return Run.new(@game, @route, nextsplits, @currsplit+1)
            else
                nextsplits =
                    @splits[0, @currsplit] +
                    [@splits[@currsplit].stop(now)] +
                    [@splits[@currsplit+1].start(now)] +
                    @splits[@currsplit+2, splits.length]
                return Run.new(@game, @route, nextsplits, @currsplit+1)
            end
        end
    end

end
