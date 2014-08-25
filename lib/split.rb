class Split
    attr_reader :name, :starttime, :endtime

    def initialize(name, starttime, endtime)
        @name = name
        @starttime = starttime
        @endtime = endtime
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
end
