
function CircleLayout() {

  this.layout     = new Function ("CircleLayout_layout(this);");
  this.modifyNode = new Function(""); // can be overridden
}


function CircleLayout_layout(layout) {

  var list = document.getElementById('layout');
  
  console.log(list);

  var nodelist = list.getElementsByTagNameNS('http://knoxa.github.io/svg/marker', 'layout');
  if (nodelist.length == 0) return;

  var steps = nodelist.length;
  var angle = 360 / steps;
  
  for (i = 0; i < steps; i++ ) {
 
    var node = nodelist.item(i).parentNode;
    node.setAttribute('transform', 'rotate(' + angle*i + '), translate(500), rotate(' + -angle*i + ')');

    layout.modifyNode(node, layout);
  }

}


