local platform = require('utils.platform')

---@type Config
local options = {
   default_prog = {},
   launch_menu = {},
}

if platform.is_win then
   -- Nushell 作为默认 shell。
   options.default_prog = { 'nu' }
   options.default_cwd = 'C:\\Users\\lenovo'
   options.launch_menu = {
      -- MSYS2 UCRT64 + zsh：env.exe 只向 zsh 进程注入这组变量，全局 PATH 不动；
      -- MSYS2_PATH_TYPE=inherit 让 /etc/profile 保留 Windows PATH（scoop/winget 装的工具继续可用）。
      {
         label = 'Zsh (MSYS2)',
         args = {
            'C:/msys64/usr/bin/env.exe',
            'MSYSTEM=UCRT64',
            'MSYS2_PATH_TYPE=inherit',
            'CHERE_INVOKING=1',
            '/usr/bin/zsh',
            '-l',
         },
      },
      { label = 'Nushell', args = { 'nu' } },
      { label = 'PowerShell Core', args = { 'pwsh', '-NoLogo' } },
      { label = 'PowerShell Desktop', args = { 'powershell' } },
      { label = 'Command Prompt', args = { 'cmd' } },
      {
         label = 'Git Bash',
         args = { 'D:\\Tools\\Git\\bin\\bash.exe' },
      },
   }
elseif platform.is_mac then
   options.default_prog = { '/opt/homebrew/bin/fish', '-l' }
   options.launch_menu = {
      { label = 'Bash', args = { 'bash', '-l' } },
      { label = 'Fish', args = { '/opt/homebrew/bin/fish', '-l' } },
      { label = 'Nushell', args = { '/opt/homebrew/bin/nu', '-l' } },
      { label = 'Zsh', args = { 'zsh', '-l' } },
   }
elseif platform.is_linux then
   options.default_prog = { 'fish', '-l' }
   options.launch_menu = {
      { label = 'Bash', args = { 'bash', '-l' } },
      { label = 'Fish', args = { 'fish', '-l' } },
      { label = 'Zsh', args = { 'zsh', '-l' } },
   }
end

return options
