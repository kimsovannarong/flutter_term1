void main() {
  // Map of pizza prices
  const pizzaPrices = {
    'margherita': 5.5,
    'pepperoni': 7.5,
    'vegetarian': 6.5,
  };

  // Example order
  const order = ['margherita', 'pepperoni', 'pineapple'];
  double total=0;
  var notfound;
  for (var entry in pizzaPrices.entries){
    for(int i=0;i<order.length;i++){
      if(entry.key==order[i]){
         total+= entry.value;
      }if(entry.key!=order[i]){
        notfound=order[i];
      }
    }
  }
  print("Total is ${total}");
  print(" ${notfound} pizza is not found");
}
