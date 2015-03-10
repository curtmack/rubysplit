require 'curses'

class CursesHelper
    
    def self.write_attrlist(list)
        attrs_set = false
        list.each do |item|
            if item.is_a? Fixnum then
                Curses.attrset(item)
                attrs_set = true
            elsif item.is_a? String then
                Curses.addstr(item)
            end
        end
        if attrs_set then
            Curses.attrset(Curses::A_NORMAL)
        end
    end

end
