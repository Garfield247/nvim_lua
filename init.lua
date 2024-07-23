vim.env.PYENV_VERSION = vim.fn.system("pyenv version"):match("(%S+)%s+%(.-%)")
vim.g.python3_host_prog = "/Users/catman/.pyenv/shims/"
require("catman.core")
require("catman.lazy")
