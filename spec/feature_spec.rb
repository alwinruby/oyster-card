require 'oystercard'

card = Oystercard.new
station1 = "Southwark"
station2 = "Angel"
card.top_up(10)
card.touch_in(station1)
card.touch_out(station2)
p card.journey_history
