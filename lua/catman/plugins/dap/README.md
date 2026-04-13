# DAP 调试使用教程

## 依赖安装

首次使用需要通过 Mason 安装调试后端：

```
:MasonInstall debugpy delve
```

- `debugpy` — Python 调试后端
- `delve` — Go 调试后端（`dlv`）

---

## 快捷键

| 按键         | 说明                                   |
| ------------ | -------------------------------------- |
| `<Leader>dc` | 继续 / 启动调试                        |
| `<Leader>db` | 切换断点                               |
| `<Leader>dB` | 设置条件断点                           |
| `<Leader>dn` | 单步跳过（step over）                  |
| `<Leader>di` | 单步进入（step into）                  |
| `<Leader>do` | 单步跳出（step out）                   |
| `<Leader>dq` | 终止调试                               |
| `<Leader>dl` | 重新运行上次的调试配置                 |
| `<Leader>dr` | 切换 REPL                              |
| `<Leader>dt` | 切换 DAP UI 面板                       |
| `<Leader>de` | 求值光标下的表达式（支持可视模式选中） |

---

## Go 调试

### 启动调试

光标放在任意 `.go` 文件，按 `<Leader>dc` 会弹出配置选择菜单：

| 配置           | 说明                                         |
| -------------- | -------------------------------------------- |
| Debug 当前文件 | 调试光标所在的单个 `.go` 文件                |
| Debug 当前包   | 调试当前文件所在的整个包                     |
| Debug 测试文件 | 以测试模式运行当前文件（`go test`）          |
| Attach 进程    | 附加到已运行的 Go 进程（会弹出进程选择列表） |

### 典型流程

```
1. 在目标行按 <Leader>db 打断点
2. 按 <Leader>dc 选择调试配置并启动
3. 程序暂停在断点后：
   - <Leader>dn  跳过当前行
   - <Leader>di  进入函数内部
   - <Leader>do  跳出当前函数
   - <Leader>de  查看变量值
4. 按 <Leader>dq 结束调试
```

### 调试测试函数

光标放在某个 `TestXxx` 函数内，直接用 `nvim-dap-go` 提供的命令：

```
:DapGoDebugTest
```

---

## Python 调试

### 启动调试

光标放在任意 `.py` 文件，按 `<Leader>dc` 弹出配置选择菜单：

| 配置            | 说明                            |
| --------------- | ------------------------------- |
| Debug 当前文件  | 直接运行当前 `.py` 文件         |
| Debug 带参数    | 启动时手动输入命令行参数        |
| Attach 远程进程 | 附加到已启动 debugpy 的远程进程 |

### 远程 Attach

在目标 Python 程序里加入：

```python
import debugpy
debugpy.listen(("0.0.0.0", 5678))
debugpy.wait_for_client()  # 可选，阻塞等待调试器连接
```

然后在 Neovim 里选择 `Attach 远程进程`，输入 host 和 port 即可连接。

### justMyCode

配置里 `justMyCode = false`，调试时可以用 `<Leader>di` 进入第三方库内部。
如果只想调试自己的代码，把它改为 `true`。

---

## DAP UI 面板说明

调试启动后 UI 自动打开，分为左侧和底部两个区域：

**左侧面板**

| 面板        | 说明                          |
| ----------- | ----------------------------- |
| Scopes      | 当前作用域内的所有变量及其值  |
| Breakpoints | 所有断点列表，可在此启用/禁用 |
| Stacks      | 调用堆栈，点击可跳转到对应帧  |
| Watches     | 自定义监视表达式              |

**底部面板**

| 面板    | 说明                         |
| ------- | ---------------------------- |
| REPL    | 交互式求值，可直接输入表达式 |
| Console | 程序的标准输出               |

在 UI 面板内按 `?` 可查看该面板支持的所有操作。

---

## 行内变量值

调试暂停时，`nvim-dap-virtual-text` 会在代码行尾以注释形式显示变量的当前值，无需切换到 Scopes 面板即可快速查看。

---

## 条件断点

按 `<Leader>dB` 后输入条件表达式，只有条件为真时程序才会在该断点暂停。

**Go 示例：**

```
i > 10
```

**Python 示例：**

```
len(data) == 0
```
