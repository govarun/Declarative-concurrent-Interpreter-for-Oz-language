
\insert 'Unify.oz'
declare
proc {Adjoin E X NE}
   local P in
      P = {AddKeyToSAS}
      {AdjoinAt E X P NE}
   end
end

fun {IsBool X E}
   case X of nil then false
   [] ident(X) then
      case {ReturnRoot E.X} of nil then false
	 [] equivalence(Y) then suspend
	 [] literal(L) then case L of true then true [] false then false else {Raise 'Not a bool'} false end
      else {Raise 'Not a bool value'} false
      end
   else false
   end
end

fun {MatchPattern X Pattern E}
   case X of nil then nil
   [] ident(Y) then case {ReturnRoot E.Y} of nil then nil
		    [] equivalence(T) then {Raise 'Equivalent Classes'} false
		    [] record|name|features then case Pattern of nil then nil
						 [] record|name2|features2 then if name == name2 then
										   if features == features2 then true
										   else false
										   end
										else false
										end
						 else {Raise 'Invalid Pattern'} false
						 end
		    else {Raise 'Not a record'} false
		    end
   else {Raise 'Invalid Value'} false
   end
end


fun {Interpreter Stack}
   {Browse Stack}
{PrintAll 1}
   local NE in
      case Stack
      of nil then nil
      [] pair(s:X e:E)|T then
	 case X 
	 of nil then {Interpreter T}
	 [] [nop]|TT then {Interpreter pair(s:TT e:E)|T}
	 [] [var ident(I) S]|TT then {Adjoin E I NE} {Interpreter pair(s:[S] e:NE)|pair(s:TT e:E)|T}
	 [] [bind ident(I) ident(J)]|TT then {Unify ident(I) ident(J) E} {Interpreter pair(s:TT e:E)|T}
	 [] [bind ident(I) V]|TT then {Unify ident(I) V E} {Interpreter pair(s:TT e:E)|T}
	 [] [conditional ident(X) S1 S2]|TT then
	    case {IsBool ident(X) E} of suspend then [Stack]
	    [] true then {Interpreter pair(s:[S1] e:E)|pair(s:TT e:E)|T}
	    else {Interpreter pair(s:[S2] e:E)|pair(s:TT e:E)|T}
	    end
	 [] [match ident(X) P S1 S2]|TT then
	    if {MatchPattern X P E} then {Interpreter pair(s:[S1] e:E)|pair(s:TT e:E)|T} else {Interpreter pair(s:[S2] e:E)|pair(s:TT e:E)|T} end
	 [] [thred(S)]|TT then {Browse 'Hello World'} [[pair(s:S e:E)] pair(s:TT e:E)|T]
	    
	 [] H|nil then {Interpreter pair(s:H e:E)|T}
	    
	 else
	    {Raise 'Exception in SemanticStack'} false
	 end
      else
	 {Raise 'Exception in Stack'} false
      end
   end
end

declare
fun {Appendi Xs Ys}
   case Xs of nil then Ys
   [] H|T then H|{Appendi T Ys}
   end
end


declare
proc {Interpreter2 Stack}
   case Stack
   of nil then skip
   [] [empty]|T then {Interpreter2 T}
   [] H|T then {Browse 'Kuch Toh hua hae'} {Interpreter2 {Appendi T {Interpreter H}}}
   end
end


X=[[bind ident(x) ident(y)] [bind ident(x) ident(z)] [nop]]
Z=
[[var ident(x) [nop]] [var ident(x) [nop]]]
Y=
[[var ident(x)
  [var ident(y)
    [var ident(z)
     [[bind ident(x) [record literal(a) [[literal(b) ident(x1)]]] ] [conditional ident(x) [nop] [nop]] [nop]]
    ]
  ]
 ]]

T=[[var ident(x) [var ident(y) [ [conditional ident(x) [bind ident(y) literal(1)] [bind ident(y) literal(2)]   ]]]]]


K=[[bind ident(x) 3]]

U = [[ var ident(x) [ bind ident(x) [record literal(rec) [literal(a) ident(x1)] [literal(b) ident(x2)] [literal(c) ident(x3)]  ]  ]]]
J = [[var ident(x)
      [var ident(y)
       [[
	 [thred(
	     [[conditional ident(x)
	       [bind ident(y) literal(1)]
	       [bind ident(y) literal(2)] ]])]
	 [bind ident(x) literal(false)]
	]]
      ]]]


Te = [[ var ident(s1)
	[ var ident(s2)
	  [ var ident(a)
	    [
	     [bind ident(a) literal(10)]
	     [thred(
		 [
		  [ var ident(b)
		    [
		     [bind ident(b) ident(a)]
		     [
		      [conditional ident(s1)
		       [nop]
		       [ [nop] [nop] ]
		      ]
		     ]
		    ]
		  ]
		 ])
	     ]
	     [thred(
		 [
		  [var ident(c)
		   [
		    [bind ident(c) ident(a)]
		    
		     [conditional ident(s2)
		      [nop]
		      [ [nop] [nop] ]
		     ]
		    
		    [bind ident(s1) literal(true)]
		   ]
		  ]
		 ])
	     ]
	     [var ident(a)
	      [
	       [bind ident(a) literal(100)]
	       [thred(
		   [
		    [var ident(d)
		     [[bind ident(d) ident(a)]
		     [bind ident(s2) literal(false)]
		    ]]
		   ])
	       ]
	      ]
	     ]
	    ]
	  ]
	]
      ]
     ]

	    



		 
		    
	     


Stack= [[pair(s:Te e:'!')]]
{Interpreter2 Stack}
