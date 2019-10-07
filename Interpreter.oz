\insert '/Users/varungoyal/GitRepos/Oz-Interpreter/Unify.oz'
declare
proc {Adjoin E X NE}
   local P in
      P = {AddKeyToSAS}
      {AdjoinAt E X P NE}
   end
end

declare
fun {IfTrue Y E}
   case Y
   of nil then false
   [] ident(X) then
      local TempX in
	 TempX = {RetrieveFromSAS E.X}
	 case TempX
	 of nil then false
	 [] literal(L) then L == true
	 [] equivalence(ParentX) then
	    local RootX in
	       RootX = {ReturnRoot ParentX}
	       case RootX
	       of literal(L) then L == true
	       else false
	       end
	    end
	 end
      end
   else false
   end
end

		  
	    
	 
      



proc {Interpreter Stack}
   {Browse Stack}
   local NE in
      case Stack
      of nil then skip
      [] pair(s:X e:E)|T then
	 case X 
	 of nil then {Interpreter T}
	 [] [nop]|TT then {Interpreter pair(s:TT e:E)|T}
	 [] [var ident(I) S]|TT then {Adjoin E I NE} {Interpreter pair(s:[S] e:NE)|pair(s:TT e:E)|T} {Browse 'Yes'}
	 [] [bind ident(I) ident(J)]|TT then {Unify ident(I) ident(J) E} {Interpreter pair(s:TT e:E)|T}
	 [] [bind ident(I) V]|TT then {Unify ident(I) V E} {Interpreter pair(s:TT e:E)|T}

	 [] [conditional ident(I) S1 S2]|TT then
	    if {IfTrue ident(I) X} then
	       {Browse true} 
	       {Interpreter pair(s:S1 e:E)|pair(s:TT e:E)|T}
	    else
	       {Browse false}
	       {Interpreter pair(s:S2 e:E)|pair(s:TT e:E)|T}
	    end
	    
	    
	 [] H|nil then {Interpreter [pair(s:H e:E)]}
	    
	 else
	    {Browse 'Exception in SemanticStack'}
	 end
      else
	 {Browse 'Exception in Stack'}
      end
   end
end

X=[[bind ident(x) ident(y)] [bind ident(x) ident(z)] [nop]]
Z=
[[var ident(x) [nop]] [var ident(x) [nop]]]
Y=
[[var ident(x)
  [var ident(y)
  ]
  [bind ident(x) true]
   [conditional ident(x) s1 s2]
 ]]
K=[[nop] [nop]]

Stack= [pair(s:Y e:'!')]
{Interpreter Stack}
