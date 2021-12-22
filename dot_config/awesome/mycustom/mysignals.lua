local awful = require('awful')

client.connect_signal("unmanage", function(c)
    local t = c.first_tag or awful.screen.focused().selected_tag
    -- Check if tag is empty of clients
    for _, cl in ipairs(t:clients()) do
      if cl ~= c then
        return
      end
    end

    -- Go to previously accessed tag and check if there are any clients, else
    -- proceed with the `for` loop which checks each tag for open clients from
    -- the beginning. We do this because if we execute the `for` loop
    -- immediately, it will check from the beginning and return the first tag
    -- with open clients, thus potentially skipping the previously accessed tag
    -- if it has any open clients still. This is just a personal preference.
    awful.tag.history.restore(mouse.screen)
    t1 = awful.screen.focused().selected_tag
    if #t1:clients() > 0 then
      t1:view_only()
      return
    else
      -- Check to see the first tag that has active clients to switch to (we do this by
      -- checking if length of table tag:clients() is not nil.
      -- Reverse tag history again to avoid switching between empty tags
      awful.tag.history.restore(mouse.screen)
      for _, t in ipairs(awful.screen.focused().tags) do
        if #t:clients() > 0 then
          t:view_only()
          return
        end
      end
    end
end)
