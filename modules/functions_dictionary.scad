include <functions_array.scad>

function DictGet(list, key, alert=false) =
  let(matchResults = search([key],list,1),
    matchIndex = is_list(matchResults) && len(matchResults)==1 && is_num(matchResults[0]) ? matchResults[0]: undef,
    alertMessage = str("count not find key in list key:'", key, "' matchResults:'", matchResults, "' matchIndex:'", matchIndex),
    matchValue = is_num(matchIndex) ? list[matchIndex] : undef,
    x = !alert && is_undef(matchValue) ? echo(alertMessage) : 1)
    assert(!alert || !is_undef(matchValue), alertMessage)
      matchValue[1];

function DictSetRange(list, keyValueArray) = !(len(keyValueArray)>0) ? list :
  assert(is_list(list), str("DictSetRange(keyValueArray, arr) - arr is not a list. list:",list))
  assert(is_list(keyValueArray), str("DictSetRange(keyValueArray, arr) - keyValueArray is not a list. keyValueArray:", keyValueArray))
  let(currentKeyValue = keyValueArray[0])
  assert(is_list(currentKeyValue), str("DictSetRange(keyValueArray, arr) - currentKeyValue is not a list. currentKeyValue:",currentKeyValue))
  assert(len(currentKeyValue)==2, str("DictSetRange(keyValueArray, arr) - currentKeyValue is not length of 2. currentKeyValue:",currentKeyValue))
  assert(is_string(currentKeyValue[0]), str("DictSetRange(keyValueArray, arr) - currentKeyValue[0] is not a string, currentKeyValue:",currentKeyValue))
  let(keyValueArrayNext = remove_item(keyValueArray,0),
    updatedList = DictSet(list, currentKeyValue)
  ) concat(DictSetRange(updatedList, keyValueArrayNext));

function DictSet(list, keyValue) =
  assert(is_list(list), str("DictSet(keyValueArray, arr) - arr is not a list list:", list))
  assert(is_list(keyValue), str("DictSet(keyValueArray, arr) - keyValueArray is not a list. keyValue:",keyValue))
  assert(len(keyValue)==2, str("DictSet(keyValueArray, arr) - keyValueArray is not a list. keyValue:",keyValue))
  let(matchResults = search([keyValue[0]],list,1),
    matchIndex = is_list(matchResults) && len(matchResults)==1 && is_num(matchResults[0]) ? matchResults[0] : undef)
  assert(!is_undef(matchIndex), str("count not find key in list, key:'", keyValue[0], "'", DictToString(list)))
    replace(list, matchIndex, keyValue);

module DictDisplay(list, name = ""){
  echo(DictToString(list=list,name=name));
}
function DictToString(list, name = "") =
  let(infoText=[for(i=[0:len(list)-1])str(list[i][0],"=",list[i][1])])
  str("🟧", name, concatstringarray(infoText));

function concatstringarray(in, out="",pos=0, sep="\r\n  ") = pos>=len(in)?out:
  concatstringarray(in=in,out=str(out,sep,in[pos]),pos=pos +1);

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