class Split
    attr_reader :name, :starttime, :endtime, :besttime

    def initialize(name, starttime, endtime, besttime=0)
        @name = name
        @starttime = starttime
        @endtime = endtime
        @besttime = besttime
    end

    def -(other)
        time - other.time
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

    def done?
        !endtime.nil?
    end

    def started?
        !starttime.nil?
    end

    def improved?
        time < besttime
    end

    def gold
        Split.new(name, nil, nil, time)
    end
end
