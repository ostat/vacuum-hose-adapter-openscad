//Replace multiple values in an array
function replace_Items(keyValueArray, arr) = !(len(keyValueArray)>0) ? arr :
  assert(is_list(arr), "replace_Items(keyValueArray, arr) - arr is not a list")
  assert(is_list(keyValueArray), "replace_Items(keyValueArray, arr) - keyValueArray is not a list")
  let(currentKeyValue = keyValueArray[0])
  assert(is_list(currentKeyValue), "replace_Items(keyValueArray, arr) - currentKeyValue is not a list")
  assert(is_num(currentKeyValue[0]), "replace_Items(keyValueArray, arr) - currentKeyValue[0] is not a number")
  let(keyValueArrayNext = remove_item(keyValueArray,0),
    updatedList = replace(arr, currentKeyValue[0],currentKeyValue[1])
) concat(replace_Items(keyValueArrayNext, updatedList));

//Replace a value in an array
function replace(list,position,value) =
  assert(is_list(list), "replace(list,position,value) - list is not a list")
  assert(is_num(position), "replace(list,position,value) - position is not a number")
  let (
    l1 = position > 0 ? partial(list,start=0,end=position-1) : [],
    l2 = position < len(list)-1 ? partial(list,start=position+1,end=len(list)-1) :[]
  ) concat(l1,[value],l2);

// takes part of an array
function partial(list,start,end) = [for (i = [start:end]) list[i]];

//Removes item from an array
function remove_item(list,position) = [for (i = [0:len(list)-1]) if (i != position) list[i]];