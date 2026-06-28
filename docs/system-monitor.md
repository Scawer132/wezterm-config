# System Monitor — 设计笔记

在 WezTerm 右侧状态栏增加 Windows 主机 CPU/GPU/RAM 实时占用显示。

## 状态：计划中（暂未实现）

## 方案

### 架构

```
utils/sysmon.lua (后台采集)
  ├── wezterm.time.call_after() 每 3s 循环
  │   ├── 一次 powershell.exe 调用采集 CPU% + RAM%
  │   └── nvidia-smi 采集 GPU%
  └── 对外开放 get_stats() → { cpu, gpu, ram }

events/right-status.lua (UI 渲染)
  ├── 新增 6 个 segments: cpu_icon, cpu_text, gpu_icon, gpu_text, ram_icon, ram_text
  └── update-status 回调中从 sysmon.get_stats() 读取缓存
```

### 数据采集

- **CPU**：`powershell.exe "Get-CimInstance Win32_Processor | Select-Object -ExpandProperty LoadPercentage"`
- **RAM**：与 CPU 同一次 powershell 调用完成
- **GPU**：`nvidia-smi --query-gpu=utilization.gpu --format=csv,noheader`（NVIDIA 专用）

### 性能预算

- 采集间隔：3 秒（后台循环）
- 单次采集耗时：~200-300ms（powershell 进程创建 + nvidia-smi）
- 等效 CPU 占用：约 2%（4 核参考）
- UI 刷新：保持 1 秒间隔，只读缓存

### 关键约束

1. **不可**在 `update-status` 回调中直接 spawn 进程（会阻塞 UI 线程）
2. 后台采集与 UI 渲染必须解耦（缓存模式）
3. 需验证 WSL2 下 nvidia-smi 是否可用（备选走 powershell WMI）

## 如果将来要改

- 背景色/图标可参考 `right-status.lua` 现有 battery 片段风格
- 采集频率可在 `sysmon.lua` 顶部常量调整
