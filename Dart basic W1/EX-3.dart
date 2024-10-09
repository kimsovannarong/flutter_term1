void main() {
 List<int> scores=[45, 78, 62, 49, 85,
                   33, 90, 50] ;
 int num=0; 
  for(int i=0;i<scores.length;i++){
    if(scores[i]>=50){
      print('Student of ${scores[i]} has passed');
      num+=1;
    }
  }
  print("${num} has passed"  );
}