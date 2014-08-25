class Numeric
    def time_disp
        rem = self

        hours = (rem / 3600).floor
        rem -= (hours * 3600)

        minutes = (rem / 60).floor
        rem -= (minutes * 60)

        seconds = rem.floor
        rem -= seconds

        hundredths = (rem * 100).round

        if (hours > 0)
            return "%2d:%02d:%02d" % [hours, minutes, seconds]
        else
            return "%2d:%02d.%02d" % [minutes, seconds, hundredths]
        end
    end
end
