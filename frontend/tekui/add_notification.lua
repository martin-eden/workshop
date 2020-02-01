local tui = require('tek.ui')

return
  function(obj, attr_name, handler)
    assert_table(obj)
    assert_string(attr_name)
    assert_function(handler)
    obj:addNotify(
      attr_name,
      tui.NOTIFY_ALWAYS,
      {
        tui.NOTIFY_SELF,
        tui.NOTIFY_FUNCTION,
        handler,
      }
    )
  end
