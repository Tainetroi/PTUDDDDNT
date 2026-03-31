void main() {
  // 1. Khai báo biến
  var name = 'Srinivas';
  int age = 20;
  double height = 5.9;
  bool isAdult = age > 18 ? true : false;

  // 2. In giá trị
  print('Name: $name');
  print('Age: $age');
  print('Height: $height');

  // 3. Câu lệnh điều kiện
  if (isAdult) {
    print('$name is an adult.');
  } else {
    print('$name is not an adult.');
  }

  // 4. Gọi hàm
  greet(name);

  // 5. Vòng lặp For
  for (int i = 1; i <= 5; i++) {
    print('Loop iteration $i');
    if (i == 3) break;
  }

  // 6. Danh sách (Array/List)
  List<String> friends = ['Bhanu', 'Amar', 'Amulya', 'Kiran', 'Sandeep'];
  for (String friend in friends) {
    print('Hello, $friend!');
  }

  // 7. Hướng đối tượng (OOP)
  Person person = Person(name, age, height);
  person.introduce();

  // 8. Xử lý ngoại lệ
  try {
    int result = 10 ~/ 0; // Chia nguyên cho 0
    print('Result: $result');
  } catch (e) {
    print('An error occurred: $e');
  }
}

// Định nghĩa hàm
void greet(String name) {
  print('Welcome to SDC, $name!');
}

// Định nghĩa lớp
class Person {
  String name;
  int age;
  double height;
  bool isAdult;

  // Constructor
  Person(this.name, this.age, this.height) : isAdult = age > 18;

  void introduce() {
    print(
      'My name is $name, I am $age years old and my height is $height feet.',
    );
  }
}
