class MyDuration {
  final double _milliseconds; 
  MyDuration.Fromhour(double hour) : _milliseconds = hour * 3600000;// convert from hour to milli second
  MyDuration.ms(double value):_milliseconds=value;
  MyDuration.Fromsecond(double second) : _milliseconds = second*1000;// from second to milli
  MyDuration.Fromminute(double minute) : _milliseconds = minute * 60000;// from minute to milli
  // compare methotd
  bool operator >(MyDuration other) {
     if (_milliseconds > other._milliseconds) {
      return true;
    }else{
       return false;
     }  
  }
  // addition method
  MyDuration operator +(MyDuration other) {
    return MyDuration.ms(this._milliseconds + other._milliseconds);
  }
  // substraction method
  MyDuration operator -(MyDuration other) {
     if (_milliseconds < other._milliseconds) {
      throw Exception("Smaller number can not be done  substraction operation");
    }else{
       return MyDuration.ms(this._milliseconds - other._milliseconds);
     }
  }

  // Display the duration in a readable format
  @override
  String toString() {
    int seconds = (_milliseconds / 1000).round();
    int minutes = (seconds / 60).floor();
    seconds = seconds % 60;
    int hours = (minutes / 60).floor();
    minutes = minutes % 60;
    return '$hours hours, $minutes minutes, $seconds seconds';
  }
}

void main() {
  MyDuration duration1 = MyDuration.Fromhour(3); // 3 hours
  MyDuration duration2 = MyDuration.Fromminute(45); // 45 minutes
  print(duration1 + duration2); // 3 hours, 45 minutes, 0 seconds
  print(duration1>duration2); //true
  try {
    print(duration2 - duration1); // This will throw an exception
  } catch (e) {
    print(e); 
  }
}