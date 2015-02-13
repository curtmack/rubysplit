require 'split'

class Run
    attr_reader :game, :route, :splits

    def initialize(game, route, splits = [], currsplit = 0)
        @game = game
        @route = route
        @splits = (splits == nil ? [] : splits)
        @currsplit = (currsplit < 0 ? 0 : currsplit)
    end

    def starttime
        return nil if splits.length == 0
        splits.first.starttime
    end

    def endtime
        return nil if splits.length == 0
        splits.last.endtime
    end

    def started?
        return nil if splits.length == 0
        splits.first.started?
    end

    def done?
        return nil if splits.length == 0
        splits.last.done?
    end

    def running?
        started? && !done?
    end

end
