local toggle_analog_reporting = request('toggle_analog_reporting')

return
  function(self, analog_pin)
    toggle_analog_reporting(self, analog_pin, 0)
  end
