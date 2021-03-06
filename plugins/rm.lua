local function history(extra, suc, result)
  for i=1, #result do
    delete_msg(result[i].id, ok_cb, false)
  end
  if tonumber(extra.con) == #result then
    send_msg(extra.chatid, '✅ "'..#result..'" پیام اخیر سوپر گروه حذف شد', ok_cb, false)
  else
    send_msg(extra.chatid, '✅ تعداد پیام مورد نظر شما پاک شد', ok_cb, false)
  end
end
local function run(msg, matches)
  if matches[1] == 'm' and is_momod(msg) then
    if msg.to.type == 'channel' then
      if tonumber(matches[2]) > 100 or tonumber(matches[2]) < 1 then
        return "⛔️ تعداد بیشتر از 1 و کمتر از 100 مجاز است"
      end
      get_history(msg.to.peer_id, matches[2] + 1 , history , {chatid = msg.to.peer_id, con = matches[2]})
    else
      return "⛔️ پاک کردن پیام تنها در سوپرگروه امکان پذیر است."
    end
  else
    return "⛔️ استفاده فقط برای اونر مجاز است."
  end
end

return {
    patterns = {
        '^[Rr](m) (%d*)$'
    },
    run = run
}