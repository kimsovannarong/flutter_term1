class Distance {
  final double distanceMs; 

  Distance.cms(double distance) : distanceMs = distance / 100;
  Distance.ms(double distance) : distanceMs = distance;
  Distance.kms(double distance) : distanceMs = distance * 1000;

  double get cms {
    return distanceMs * 100;
  } 
  double get ms {
    return distanceMs * 100;
  } 
  double get kms {
    return distanceMs /1000;
  } 

  // Operator overloading for adding two Distance objects
  Distance operator +(Distance other) {
    return Distance.ms(this.distanceMs + other.distanceMs);
  }
}

void main() {
  Distance d1 = Distance.kms(3.4); 
  Distance d2 = Distance.ms(1000); 
  print((d1 + d2).kms); 
}
