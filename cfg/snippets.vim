" Luansip mapping
imap <silent><expr> <Tab> luasnip#expand_or_jumpable() ? '<Plug>luasnip-expand-or-jump' : '<Tab>' 
inoremap <silent> <S-Tab> <cmd>lua require'luasnip'.jump(-1)<Cr>

snoremap <silent> <Tab> <cmd>lua require('luasnip').jump(1)<Cr>
snoremap <silent> <S-Tab> <cmd>lua require('luasnip').jump(-1)<Cr>

lua << EOF
-- Mapping for expanding choice nodes
vim.api.nvim_set_keymap("i", "<C-E>", "<Plug>luasnip-next-choice", {})  
vim.api.nvim_set_keymap("s", "<C-E>", "<Plug>luasnip-next-choice", {})

-- Lua snippets defined in ~155
-- Friendly snippets loaded here:
require("luasnip/loaders/from_vscode").load({ paths = { "~/.vim/bundle/friendly-snippets" } })

local types = require("luasnip.util.types")

-- Dots to show the nodes
require'luasnip'.config.setup({
        updateevents = 'TextChangedI',
	ext_opts = {
		[types.choiceNode] = {
			active = {
				virt_text = {{"●?", "GruvboxOrange"}}
			}
		},
		[types.insertNode] = {
			active = {
				virt_text = {{"●", "GruvboxBlue"}}
			}
		}
	},
})

local ls = require("luasnip")
-- some shorthands...
local s = ls.snippet
local sn = ls.snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node
local d = ls.dynamic_node
local r = ls.restore_node
local l = require("luasnip.extras").lambda
local rep = require("luasnip.extras").rep
local p = require("luasnip.extras").partial
local m = require("luasnip.extras").match
local n = require("luasnip.extras").nonempty
local dl = require("luasnip.extras").dynamic_lambda
local fmt = require("luasnip.extras.fmt").fmt
local fmta = require("luasnip.extras.fmt").fmta
local types = require("luasnip.util.types")
local conds = require("luasnip.extras.expand_conditions")

-- If you're reading this file for the first time, best skip to around line 190
-- where the actual snippet-definitions start.

-- Every unspecified option will be set to the default.

-- args is a table, where 1 is the text in Placeholder 1, 2 the text in
-- placeholder 2,...
local function copy(args)
	return args[1]
end

-- 'recursive' dynamic snippet. Expands to some text followed by itself.
local rec_ls
rec_ls = function()
	return sn(nil, {
		c(1, {
			-- important!! Having the sn(...) as the first choice will cause infinite recursion.
			t({""}),
			-- The same dynamicNode as in the snippet (also note: self reference).
			sn(nil, {t({"", "\t\\item "}), i(1), d(2, rec_ls, {})}),
		}),
	});
end
local rec_lst
rec_lst = function()
	return sn(nil, {
		c(1, {
			-- important!! Having the sn(...) as the first choice will cause infinite recursion.
			t({""}),
			-- The same dynamicNode as in the snippet (also note: self reference).
			sn(nil, {t({"\", \""}), i(1), d(2, rec_lst, {})}),
		}),
	});
end

-- complicated function for dynamicNode.
local function jdocsnip(args, _, old_state)
	-- !!! old_state is used to preserve user-input here. DON'T DO IT THAT WAY!
	-- Using a restoreNode instead is much easier.
	-- View this only as an example on how old_state functions.
	local nodes = {
		t({ "/**", " * " }),
		i(1, "A short Description"),
		t({ "", "" }),
	}

	-- These will be merged with the snippet; that way, should the snippet be updated,
	-- some user input eg. text can be referred to in the new snippet.
	local param_nodes = {}

	if old_state then
		nodes[2] = i(1, old_state.descr:get_text())
	end
	param_nodes.descr = nodes[2]

	-- At least one param.
	if string.find(args[2][1], ", ") then
		vim.list_extend(nodes, { t({ " * ", "" }) })
	end

	local insert = 2
	for indx, arg in ipairs(vim.split(args[2][1], ", ", true)) do
		-- Get actual name parameter.
		arg = vim.split(arg, " ", true)[2]
		if arg then
			local inode
			-- if there was some text in this parameter, use it as static_text for this new snippet.
			if old_state and old_state[arg] then
				inode = i(insert, old_state["arg" .. arg]:get_text())
			else
				inode = i(insert)
			end
			vim.list_extend(
				nodes,
				{ t({ " * @param " .. arg .. " " }), inode, t({ "", "" }) }
			)
			param_nodes["arg" .. arg] = inode

			insert = insert + 1
		end
	end

	if args[1][1] ~= "void" then
		local inode
		if old_state and old_state.ret then
			inode = i(insert, old_state.ret:get_text())
		else
			inode = i(insert)
		end

		vim.list_extend(
			nodes,
			{ t({ " * ", " * @return " }), inode, t({ "", "" }) }
		)
		param_nodes.ret = inode
		insert = insert + 1
	end

	if vim.tbl_count(args[3]) ~= 1 then
		local exc = string.gsub(args[3][2], " throws ", "")
		local ins
		if old_state and old_state.ex then
			ins = i(insert, old_state.ex:get_text())
		else
			ins = i(insert)
		end
		vim.list_extend(
			nodes,
			{ t({ " * ", " * @throws " .. exc .. " " }), ins, t({ "", "" }) }
		)
		param_nodes.ex = ins
		insert = insert + 1
	end

	vim.list_extend(nodes, { t({ " */" }) })

	local snip = sn(nil, nodes)
	-- Error on attempting overwrite.
	snip.old_state = param_nodes
	return snip
end

-- Make sure to not pass an invalid command, as io.popen() may write over nvim-text.
local function bash(_, _, command)
	local file = io.popen(command, "r")
	local res = {}
	for line in file:lines() do
		table.insert(res, line)
	end
	return res
end

-- Returns a snippet_node wrapped around an insert_node whose initial
-- text value is set to the current date in the desired format.
local date_input = function(args, state, fmt)
	local fmt = fmt or "%Y-%m-%d"
	return sn(nil, i(1, os.date(fmt)))
end

ls.snippets = {
	-- When trying to expand a snippet, luasnip first searches the tables for
	-- each filetype specified in 'filetype' followed by 'all'.
	-- If ie. the filetype is 'lua.c'
	--     - luasnip.lua
	--     - luasnip.c
	--     - luasnip.all
	-- are searched in that order.
        cpp = {
            s("vector", {
                t("std::vector<"),
                i(1, "type"),
                t("> "),
                i(2, "var"),
                t(" "),
                i(3),
                i(0),
            }),
            s("list", {
                t("std::list<"),
                i(1, "type"),
                t("> "),
                i(2, "var"),
                t(" "),
                i(3),
                i(0),
            }),
            s("map", {
                t("std::map<"),
                i(1, "k_type"),
                t(", "),
                i(2, "v_type"),
                t("> "),
                i(3, "var"),
                t(" "),
                i(4),
                i(0),
            }),
            s("stack", {
                t("std::stack<"),
                i(1, "type"),
                t("> "),
                i(2, "var"),
                t(" "),
                i(3),
                i(0),
            }),
            s("queue", {
                t("std::queue<"),
                i(1, "type"),
                t("> "),
                i(2, "var"),
                t(" "),
                i(3),
                i(0),
            }),
            s("iter", {
                t("for("),
                i(1, "std::vector"),
                t("<"),
                i(2, "type"),
                t(">::"),
                i(3, "const_iterator"),
                t(" "),
                i(4, "i"),
                t(" = "),
                i(5, "container"),
                t(".begin(); "),
                f(copy, 4),
                t(" != "),
                f(copy, 5),
                t("end(); ++"),
                f(copy, 4),
                t({")","{", "\t"}),
                i(6),
                t({"","}"}),
                i(0),
            }),
            s("itera", {
                t("for(auto "),
                i(1, "i"),
                t(" = "),
                i(2, "container"),
                t(".begin(); "),
                f(copy, 1),
                t(" != "),
                f(copy, 2),
                t(".end(); ++"),
                f(copy, 1),
                t({")","{","\t"}),
                t("std::cout <<"),
                f(copy, 1),
                t("<< std::endl"),
                t({"","}"}),
                i(0),
            }),
        },
        python = {
            s("lst", {
                    t("var = [\""), i(1), d(2, rec_lst, {}), t("\"]"), i(0)
            }),
            s("from", {
                t("from "), i(1), t(" import "), i(2), i(0),
                }),
            s("is", {
                t("isinstance("), i(1, "variable"), t(", "), i(2, "type"), t(")"), i(0),
                }),
            s("ifis", {
                t("if isinstance("), i(1, "variable"), t(", "), i(2, "type"), t({"):",""}),
                t("\t"), i(3, "pass"),
                t({""}), i(0),
                }),
            s("i", {
                i(1, "variable"),
                t("["),
                i(2),
                t("]"),
                i(0),
                }),
            s("id'", {
                i(1, "variable"),
                t("['"),
                i(2),
                t("']"),
                i(0),
                }),
            s("id\"", {
                i(1, "variable"),
                t("[\""),
                i(2),
                t("\"]"),
                i(0),
                }),
            -- [${1} for ${2} in ${3:${VISUAL}}]${0}
            s("lcp", {
                t("["),
                i(1),
                t(" for "),
                i(2),
                t(" in "),
                i(3, "var"),
                t("]"),
                i(0),
                }),
            -- {${1} for ${2} in ${3:${VISUAL}}}${0}
            s("scp", {
                t("{"),
                i(1),
                t(" for "),
                i(2),
                t(" in "),
                i(3, "var"),
                t("}"),
                i(0),
                }),
            -- {${1} : {2} for ${3} in ${4:${VISUAL}}}${0}
            s("dcp", {
                t("{"),
                i(1),
                t(" : "),
                i(2),
                t(" for "),
                i(3),
                t(" in "),
                i(4, "var"),
                t("}"),
                i(0),
                }),
            -- self.
            s("s", {
                t("self."),
                i(1, "var"),
                i(0),
                }),
            -- self.attribute = attribute
            s("sa", {
                t("self."),
                f(copy, 1),
                t(" = "),
                i(1, "var"),
                i(0),
                }),
            -- return {1}
            s("re", {
                t("return "),
                i(1),
                i(0),
                }),
            -- return {1}
            s("deft", {
                t("def "),
                i(1, "func\n"),
                t("("),
                i(2, "var"),
                t(": "),
                i(3, "type"),
                t(") -> "),
                i(4, "rtype"),
                t(":"),
                i(0),
                }),

},
}

-- autotriggered snippets have to be defined in a separate table, luasnip.autosnippets.
ls.autosnippets = {
	all = {
		s("autotrigger", {
			t("autosnippet"),
		}),
	},
}

EOF
