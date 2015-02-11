class Split
    attr_reader :name, :starttime, :endtime, :skipped

    def initialize(name, starttime, endtime, skipped = false)
        @name = name
        @starttime = starttime
        @endtime = endtime
        @skipped = skipped
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

    def running?
        (started? && !done?)
    end
    
    def start(now)
        raise ArgumentError, 'Split already started!' if started?
        Split.new(name, now, nil)
    end

    def stop(now)
        raise ArgumentError, 'Split not yet started!' unless started?
        raise ArgumentError, 'Split already stopped!' if done?
        raise ArgumentError, 'Split was started after stop time!' if (now < @starttime)
        Split.new(name, starttime, now)
    end

    def skip
        raise ArgumentError, "Can't skip split if it's not running!" unless running?
        Split.new(name, nil, nil, true)
    end
end
