
void main(){
  print("I am a mobile developer");
  var name = "Jeric Karganilla";
  print("Hello $name");
  const place = "SFC";
  final color = "mlue";
  //type annotation
  String vegetable = "ngamage";

  int? age;

  print(age);

  List<double> grades = [89.6, 90.2];
  grades.addAll([99, 89, 50]);
  List<double> grades2 = [100,105, 99];
  List<double> grades3 = [...grades, ...grades2];
  
  grades.forEach((grade) => print(grade));
    print("Grades 3 are:");

  grades2.forEach((grade) => (){
    print(grade);
  });

  for(int i = 0; i < grades3.length; i++){
    print(grades3[i]);
  }


}