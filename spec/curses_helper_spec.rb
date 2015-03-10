require 'rspec'
require 'curses_helper'
require 'curses'

describe CursesHelper do
    describe "::write_attrlist" do
        it "writes the string to the window" do
            str = "Test string"
            expect(Curses).to receive(:addstr).with(str)
            CursesHelper.write_attrlist([str])
        end
        it "changes attributes when provided" do
            str = "Test string"
            attrs = Curses::COLOR_RED | Curses::A_BOLD
            expect(Curses).to receive(:attrset).with(attrs).ordered
            expect(Curses).to receive(:addstr).with(str).ordered
            expect(Curses).to receive(:attrset).with(Curses::A_NORMAL).ordered

            CursesHelper.write_attrlist([attrs, str])
        end
    end
end
