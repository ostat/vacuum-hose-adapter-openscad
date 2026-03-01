module highlight_conditional(enable=false){
  if(enable)
    #children();
  else
    children();
}

module color_conditional(color, enable=true, c, alpha = 1){
  color = is_undef(color) ? c : color;
  if(!enable || is_undef(color) || !is_string(color) || (is_string(color) && len(color) == 0)){
    children();
  } else {
    color(color, alpha)
    children();
  }
}

module exclusive_conditional(enable=true){
  if(enable)
    !children();
  else
    children();
}

module render_conditional(enable=true){
  if(enable)
    render()
      children();
  else
    union()
      children();
}

module hull_conditional(enabled = true)
{
  if(enabled){
    hull(){
      children();
    }
  }
  else{
    union(){
      children();
    }
  }
}