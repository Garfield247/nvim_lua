vim.filetype.add({
	filename = {
		["go.work"] = "gowork",
	},
	extension = {
		api = "api",
		gotmpl = "gotmpl",
		gowork = "gowork",
	},
	pattern = {
		[".*%.gotmpl"] = "gotmpl",
		[".*%.gql"] = "graphql",
	},
})
