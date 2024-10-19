class Distance{
  final double distance;
  Distance.cms(int distance):distance_ms = distance/100;
  Distance.ms(int distance): distance_ms = distance;
  Distance.kms(int distance): distance_ms = distance*1000;
  double get cms{
    return distance_ms * 100;
  }
    double get ms{
    return distance_ms;
  }
    double get kms{
    return distance_ms /1000;
  }
  Distance operator+( Distance other){
     return Distance.ms(this.distance_ms + other.distance_ms); 
  }
}
void main() {
  Distance d1=Distance.kms(3.4);
  Distance d2=Distance.ms(1000);
  print((d1+d2).kms);
}
