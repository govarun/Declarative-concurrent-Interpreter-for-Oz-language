declare SAS C
SAS = {Dictionary.new}
{NewCell 0 ?C}

fun {AddKeyToSAS}
  C:=@C+1
  {Dictionary.put SAS @C equivalence(@C)}
  @C
end

fun {ReturnRoot Key}
  local Value in
    {Dictionary.get SAS Key Value}
    case Value
    of equivalence(X) then if X==Key then equivalence(Key) else {ReturnRoot X} end
    else Value
    end
  end
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
    of equivalence(X) then case B
                            of equivalence(Y) then {Dictionary.put SAS X equivalence(Y)}
                            else {Dictionary.put SAS X B}
                            end
    else
      case B
      of equivalence(Y) then {Dictionary.put SAS Y A}
      else if A==B then skip else {Browse 'Error'} end
      end
    end 
  end
end

proc {BindValueToKeyInSAS Key Val}
  local A in
    A = {ReturnRoot Key}
    case A
    of equivalence(X) then {Dictionary.put SAS X Val}
    else if A==Val then skip else {Browse 'Error in BindValue'} end
    end 
  end
end
