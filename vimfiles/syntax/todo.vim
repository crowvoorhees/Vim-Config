if exists("b:current_syntax")
  finish
endif

" keywords
syntax keyword todoKeywords EMAIL CALL FIX REVIEW DRAFT REVISE UPDATE VERIFY BUILD DEPLOY
highlight default link todoKeywords Todo

syntax case   ignore

" section titles
syntax match todoTitleInbox     "- Inbox"
syntax match todoTitleNow       "0 Now"
syntax match todoTitleToday     "1 Today"
syntax match todoTitleWeek      "2 Week"
syntax match todoTitleMonth     "3 Month"
syntax match todoTitleWait      "4 Waiting"
syntax match todoTitleMaybe     "5 Someday/Maybe"
syntax match todoTitleComplete  "6 Complete"
highlight default link todoTitleInbox     Identifier
highlight default link todoTitleNow       Identifier
highlight default link todoTitleToday     Identifier
highlight default link todoTitleWeek      Identifier
highlight default link todoTitleMonth     Identifier
highlight default link todoTitleWait      Identifier
highlight default link todoTitleMaybe     Identifier
highlight default link todoTitleComplete  Identifier

" section divider bars
syntax match todoBarInbox "-------------------------------------------------------------------------------]"
syntax match todoBarNow   "0------------------------------------------------------------------------------]"
syntax match todoBarToday "1------------------------------------------------------------------------------]"
syntax match todoBarWeek  "2------------------------------------------------------------------------------]"
syntax match todoBarMonth "3------------------------------------------------------------------------------]"
syntax match todoBarWait  "4------------------------------------------------------------------------------]"
syntax match todoBarMaybe "5------------------------------------------------------------------------------]"
highlight default link todoBarInbox Identifier
highlight default link todoBarNow   Identifier
highlight default link todoBarToday Identifier
highlight default link todoBarWeek  Identifier
highlight default link todoBarMonth Identifier
highlight default link todoBarWait  Identifier
highlight default link todoBarMaybe Identifier

" active tasks
syntax match todoTaskInbox  "^- \[ \]"
syntax match todoTaskNow    "^0 \[ \]"
syntax match todoTaskToday  "^1 \[ \]"
syntax match todoTaskWeek   "^2 \[ \]"
syntax match todoTaskMonth  "^3 \[ \]"
syntax match todoTaskWait   "^4 \[ \]"
syntax match todoTaskMaybe  "^5 \[ \]"
highlight default link todoTaskInbox  Identifier
highlight default link todoTaskNow    Identifier
highlight default link todoTaskToday  Identifier
highlight default link todoTaskWeek   Identifier
highlight default link todoTaskMonth  Identifier
highlight default link todoTaskWait   Identifier
highlight default link todoTaskMaybe  Identifier

" special cases
syntax region todoDone  start="\[x\]" end="$"
syntax region todoWho   start="#"     end='\>'  contains=todoKeywords
syntax region todoWhere start="@"     end='\>'  contains=todoKeywords
syntax region todoWhat  start="::"    end='::'  contains=todoKeywords
syntax region todoDate  start="!"     end="\>"  contains=todoKeywords
highlight default link todoDone   Comment
highlight default link todoWho    Constant
highlight default link todoWhere  String
highlight default link todoWhat   Special
highlight default link todoDate   Statement

let b:current_syntax = "todo"
