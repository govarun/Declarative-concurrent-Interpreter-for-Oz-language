declare Store
Store = {Dictionary.new}

declare C
{NewCell 0 ?C}

fun {AddKeyToSAS}
  %{Browse 'AddKeyToSAS'}
  C:=@C+1
  {Dictionary.put Store @C equivalence(@C)}
  @C
end

fun {RetrieveFromSAS Key}
  %{Browse 'RetrieveFromSAS'}
  {Dictionary.get Store Key ?} 
end

proc {BindValueToKeyInSAS Key Val}
  %{Browse 'BindValueToKeyInSAS'}
  local Value in
    {Dictionary.get Store Key Value}
    case Value
    of equivalence(X) then {Dictionary.put Store Key Val}
    else {Exception.'raise' alreadyAssigned(Key Val {Dictionary.get Store Key ?})}
    end 
  end
end

proc {BindRefToKeyInSAS Key RefKey}
  %{Browse 'BindRefToKeyInSAS'}
  local Value in
    {Dictionary.get Store Key Value}
    case Value
    of equivalence(X) then {Dictionary.put Store Key reference(RefKey)}
    else {Exception.'raise' alreadyAssigned2(Key {Dictionary.get Store Key ?})}
    end 
  end
end

% Helper functions not part of the assgnment

proc {PrintAll Current}
  if Current == 1 then {Browse 'Printing Single Assigment Store:'} end
  if Current > @C then {Browse 'Done Printing Single Assigment Store'} else {Browse {Dictionary.get Store Current ?}} {PrintAll Current+1} end
end