class Distance{
  final double distance;
  Distance(this.distance);
  Distance operator+( Distance other){
     return Distance(this.distance + other.distance); 
  }
}
void main() {
  Distance d1=Distance(1);
  Distance d2=Distance(2);
  Distance d3=d1+d2;
  print(d3.distance);
}
