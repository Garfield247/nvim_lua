vim.env.PYENV_VERSION = vim.fn.system("pyenv version"):match("(%S+)%s+%(.-%)")
vim.g.python3_host_prog = vim.fn.trim(vim.fn.system("pyenv which python3"))
require("garfield.core")
require("garfield.lazy")
