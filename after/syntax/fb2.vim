" see for examples:
" <https://github.com/neovim/neovim/blob/master/runtime/syntax/xml.vim>
" <https://github.com/neovim/neovim/blob/master/runtime/syntax/lsp_markdown.vim>

" Conceal HTML entities.
syntax match htmlEnNbsp	"&nbsp;"	conceal cchar= 
syntax match htmlEnLt	"&lt;"		conceal cchar=<
syntax match htmlEnGt	"&gt;"		conceal cchar=>
syntax match htmlEnAmp	"&amp;"		conceal cchar=&
syntax match htmlEnQuot	"&quot;"	conceal cchar="

" The default highlighting.
hi def link htmlEnNbsp	Type
hi def link htmlEnLt		Type
hi def link htmlEnGt		Type
hi def link htmlEnAmp	Type
hi def link htmlEnQuot	Type

" HTML styles
syn cluster xmlTop		contains=@Spell,xmlTag,xmlEndTag
",htmlTag,htmlEndTag
syn cluster htmlEntity	contains=htmlEnNbsp,htmlEnLt,htmlEnGt,htmlEnAmp,htmlEnQuot

" tags
" syn region  htmlEndTag	start=+</+	   end=+>+ contains=htmlTagN,htmlTagError
" syn region  htmlTag		start=+<[^/]+   end=+>+ fold contains=htmlTagN,htmlString,htmlArg,htmlValue,htmlTagError,htmlEvent,htmlCssDefinition,@htmlPreproc,@htmlArgCluster
" syn match   htmlTagN	contained +<\s*[-a-zA-Z0-9]\++hs=s+1 contains=htmlTagName,htmlSpecialTagName,@htmlTagNameCluster
" syn match   htmlTagN	contained +</\s*[-a-zA-Z0-9]\++hs=s+2 contains=htmlTagName,htmlSpecialTagName,@htmlTagNameCluster
syn match   htmlTagName	contained "\<\%(b\|i\|u\|s\|em\|del\|strike\|strong\|title\|p\)\>"

syn region htmlTitle	start="<title\>" end="</title\_s*>"me=s-1 contains=@xmlTop

syn region htmlStrike	matchgroup=htmlStrikeDelimiter		start="<del>"		end="</del>"	contained contains=@xmlTop concealends
syn region htmlStrike	matchgroup=htmlStrikeDelimiter		start="<s>"			end="</s>"		contained contains=@xmlTop concealends
syn region htmlStrike	matchgroup=htmlStrikeDelimiter		start="<strike>"	end="</strike>" contained contains=@xmlTop concealends

syn region htmlBold		matchgroup=htmlBoldDelimiter		start="<b>"			end="</b>"		contained contains=@xmlTop concealends
syn region htmlBold		matchgroup=htmlBoldDelimiter		start="<strong>"	end="</strong>" contained contains=@xmlTop concealends

syn region htmlItalic	matchgroup=htmlItalicDelimiter		start="<i>"			end="</i>"		contained contains=@xmlTop concealends
syn region htmlItalic	matchgroup=htmlItalicDelimiter		start="<em>"		end="</em>"		contained contains=@xmlTop concealends

syn region htmlUnderline matchgroup=htmlUnderlineDelimiter	start="<u>"			end="</u>"		contained contains=@xmlTop concealends

syntax match htmlParDelimiter		"<p\@="	conceal cchar=⇰ 
syntax match htmlParDelimiterEnd	"/\@<=p>"	conceal cchar=⏎
syn region htmlPar		matchgroup=htmlParDelimiter			start="<\@<=p>"
		\				matchgroup=htmlParDelimiterEnd		end="</p\@="		contains=@xmlTop,@htmlEntity,htmlStrike,htmlBold,htmlItalic,htmlUnderline concealends

" syn region htmlStrike	start="<del\>"	end="</del\_s*>"me=s-1	contains=@xmlTop
" syn region htmlStrike	start="<s\>"	end="</s\_s*>"me=s-1	contains=@xmlTop
" syn region htmlStrike	start="<strike\>"	end="</strike\_s*>"me=s-1 contains=@xmlTop

" syn region htmlBold		start="<b\>"	end="</b\_s*>"me=s-1	contains=@xmlTop
" syn region htmlBold		start="<strong\>"	end="</strong\_s*>"me=s-1 contains=@xmlTop

" syn region htmlItalic	start="<i\>"	end="</i\_s*>"me=s-1	contains=@xmlTop
" syn region htmlItalic	start="<em\>"	end="</em\_s*>"me=s-1	contains=@xmlTop

" syn region htmlUnderline start="<u\>"	end="</u\_s*>"me=s-1	contains=@xmlTop


" The default highlighting.
" hi def link htmlTag				Function
" hi def link htmlEndTag			Identifier
hi def link htmlTagName				htmlStatement

hi def link htmlStrikeDelimiter			htmlStatement
hi def link htmlBoldDelimiter			htmlStatement
hi def link htmlItalicDelimiter			htmlStatement
hi def link htmlUnderlineDelimiter		htmlStatement
hi def link htmlParDelimiter			htmlStatement
hi def link htmlParDelimiterEnd			htmlStatement

hi def link htmlTitle			Title
hi def link htmlStatement		Statement

hi def htmlBold			term=bold		cterm=bold		gui=bold
hi def htmlUnderline	term=underline	cterm=underline	gui=underline
hi def htmlItalic		term=italic		cterm=italic	gui=italic
hi def htmlStrike		term=strikethrough cterm=strikethrough gui=strikethrough
" vim: ts=4
