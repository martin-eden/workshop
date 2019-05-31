local toggle_digital_reporting = request('toggle_digital_reporting')

return
  function(self, port_index)
    toggle_digital_reporting(self, port_index, 1)
  end
