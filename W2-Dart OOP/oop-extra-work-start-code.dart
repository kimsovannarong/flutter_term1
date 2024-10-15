// Class Tree
class Tree {
  String type;
  double height;

  Tree(this.type, this.height);
}
// Class Window
class Window{
  String color;
  String position;
  int num_window;
  Window(this.color,this.position,this.num_window);
}
//Class roof
class Roof{
  String type; 
  int num_roof;
  Roof(this.type,this.num_roof);
}
//class door
class Door{
  int num_door;
  String position;
  
  Door(this.num_door,this.position);
}
// class stair
class Stair{
  int stair_index;
  List<Window> windows = [];
  List<Door> doors = [];
  Stair(this.stair_index);
}
// Class House
class House {
  String address;
  List<Tree> trees = [];  // by default empty
  List<Window> windows = [];
  List<Door> doors = [];
  List<Roof> roof = [];
  List<Stair> stairs=[];
  House(this.address);

  void addTree(Tree newTree){
    this.trees.add(newTree);
  }
  void addWindow(Window newwindow){
    this.windows.add(newwindow);
  }
  void addDoors(Door newdoor){
    this.doors.add(newdoor);
  }
  void addRoof(Roof newRoof){
    this.roof.add(newRoof);
  }
  void addStair(Stair newstair){
    this.stairs.add(newstair);
  }
}
void main(){
  Tree trees=Tree("Palm",2.5);
  Roof roofs=Roof("Triangle",2);
  Window windows=Window("Green","Left_side",1);
  Door doors=Door(1,"center");
  House myhouse1=House("Phnom Penh");
  Stair stair1=Stair(1);
  Stair stair2=Stair(0); 
  //print
  print("My house located in ${myhouse1.address} has ${trees.type } tree and its height is ${trees.height} meters, and a Roof of type   ${roofs.type} shape and it is  ${roofs.num_roof} roofs.");
  print("1st stair  has ${windows.num_window} Window with color ${windows.color} and position ${windows.position}.");
  print("2nd stair does not have a window, but the house has a Door with ${doors.num_door} door located at the ${doors.position}.");
}
