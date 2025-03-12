module("luci.controller.romupdate", package.seeall)

function index()
    -- 配置页面：编辑 /etc/config/romupdate
    entry({"admin", "system", "romupdate", "config"}, cbi("romupdate"), translate("系统更新配置"), 40)
    -- 更新页面：显示版本信息和更新按钮
    entry({"admin", "system", "romupdate"}, template("romupdate"), translate("系统更新"), 50)
    -- API：启动系统更新
    entry({"admin", "system", "romupdate", "start"}, call("action_start_update")).leaf = true
end

-- 启动系统更新：根据配置选择对应的更新脚本进行调用
function action_start_update()
    local action = luci.http.formvalue("action")
    if action == "update" then
        local uci = require "luci.model.uci".cursor()
        local mode = uci:get("romupdate", "general", "update_mode") or "keep"
        local script
        if mode == "nokeep" then
            script = uci:get("romupdate", "general", "update_script_nokeep") or "bash /usr/share/Lenyu-no-auto.sh"
        else
            script = uci:get("romupdate", "general", "update_script_keep") or "bash /usr/share/Lenyu-auto.sh"
        end
        -- 使用 nohup 后台运行更新脚本，并将日志重定向到 /tmp/romupdate.log（避免页面刷新）
        os.execute("nohup " .. script .. " > /tmp/romupdate.log 2>&1 &")
        luci.http.write("OK")
    else
        luci.http.status(400, "Bad Request")
    end
end
