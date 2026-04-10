vim.filetype.add({
	filename = {
		["go.work"] = "gowork",
	},
	extension = {
		api = "api",
	},
	pattern = {
		[".*%.gotmpl"] = "gotmpl",
		[".*%.gql"] = "graphql",
	},
})
