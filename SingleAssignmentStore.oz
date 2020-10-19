declare SAS
SAS = {Dictionary.new}
<<<<<<< HEAD

declare C
{NewCell 0 ?C}
=======

declare C
{NewCell 0 ?C}

fun {ReturnRoot Key} % Handle nil
   case Key
   of nil then nil
   else   
      local Value in
	 {Dictionary.get SAS Key Value}
	 case Value
	 of equivalence(X) then
	    if X==Key then
	       equivalence(Key)
	    else {ReturnRoot X}
	    end
	 else Value
	 end
      end
   end
end
>>>>>>> 0bb256dbf044aa06323c7158eded895ebd28735a


fun {AddKeyToSAS}
   C:=@C+1
   {Dictionary.put SAS @C equivalence(@C)}
   @C
end


fun {AddKeyToSAS}
  C:=@C+1
  {Dictionary.put SAS @C equivalence(@C)}
  @C
end

fun {RetrieveFromSAS Key}
  % {Browse {Dictionary.get SAS Key ?}}
   {Dictionary.get SAS Key ?}
end

proc {BindRefToKeyInSAS Key RefKey}
  local A B in
    A={ReturnRoot Key}
    B={ReturnRoot RefKey}
     case A
     of equivalence(X)
     then case B    
	 of equivalence(Y) then {Dictionary.put SAS X equivalence(Y)}
	 else {Dictionary.put SAS X B}
	 end
     else
	case B
	of equivalence(Y) then {Dictionary.put SAS Y A}
	else
	   if A==B then skip
	   else {Browse 'Error'} end
	   
	end
     end
  end
end


proc {BindValueToKeyInSAS Key Val}
  local A in
    A = {ReturnRoot Key}
    case A
    of equivalence(X) then {Dictionary.put SAS X Val}
    else
       if A==Val then skip
       else {Browse 'Error in BindValue'} end
       
       
    end
  end
end

proc {PrintAll Current}
  if Current == 1 then {Browse 'Printing Single Assigment Store:'} end
  if Current > @C then {Browse 'Done Printing Single Assigment Store'} else {Browse {Dictionary.get SAS Current ?}} {PrintAll Current+1} end
end