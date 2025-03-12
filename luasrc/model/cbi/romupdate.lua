local m, s, o

m = Map("romupdate", translate("系统更新配置"), translate("配置系统自动更新相关参数"))

s = m:section(TypedSection, "general", translate("通用设置"))
s.anonymous = true

-- 单选列表：选择更新脚本模式
o = s:option(ListValue, "update_mode", translate("更新脚本模式"), translate("选择默认的更新脚本类型"))
o:value("keep", translate("保留配置更新脚本路径"))
o:value("nokeep", translate("不保留配置更新脚本路径"))

o = s:option(Value, "update_script_keep", translate("保留配置更新脚本路径"), translate("指定保留配置更新的脚本路径"))
o.placeholder = "/usr/share/Lenyu-auto.sh"

o = s:option(Value, "update_script_nokeep", translate("不保留配置更新脚本路径"), translate("指定不保留配置更新的脚本路径"))
o.placeholder = "/usr/share/Lenyu-no-auto.sh"

o = s:option(DummyValue, "_return", translate("返回系统更新页面"), translate("点击返回到系统更新页面"))
o.rawhtml = true
o.cfgvalue = function()
    return '<a href="' .. luci.dispatcher.build_url("admin/system/romupdate") .. '">' .. translate("返回系统更新页面") .. '</a>'
end

return m
