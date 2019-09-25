\insert 'Unify.oz'
declare
proc {Adjoin E X NewE}
   local T in
      T = {AddKeyToSAS}
      {AdjoinAt E X T NewE}
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
	 [] [nop]|TT then {Browse [nop]} {Interpreter pair(s:TT e:E)|T}
	 [] [var ident(I) S]|TT then {Browse E} {Adjoin E I NE} {Browse NE} {Interpreter pair(s:[S] e:NE)|pair(s:TT e:E)|T}
	 [] [bind ident(I) ident(J)]|TT then {Unify I J E} {Interpreter pair(s:TT e:E)|T}
	 [] H|nil then {Interpreter [pair(s:H e:E)]}
	    
	 else
	    {Browse 1}
	 end
      else
	 {Browse 2}
      end
   end
end

X=[[bind ident(x) ident(y)] [bind ident(x) ident(z)] [nop]]
Z=
[[var ident(x) [nop]] [var ident(x) [nop]]]
Y=
[[var ident(x)
  [var ident(y)
    [var ident(z)
     [[bind ident(x) ident(y)] [bind ident(x) ident(z)] [nop]]
    ]
  ]
 ]]
K=[[nop] [nop]]

Stack= [pair(s:Y e:'#')]
{Browse SAS}
{Interpreter Stack}
{PrintAll 1}