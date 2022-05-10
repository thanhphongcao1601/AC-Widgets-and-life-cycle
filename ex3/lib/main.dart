import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

enum Gender { duc, cai, khac }

abstract class Animal {
  String? name;
  int? age;
  Gender? gender;

  Animal();

  Animal.ani({required this.name, required this.age, required this.gender});

  void eat();

  void changeGender(Gender newGender) {
    gender = newGender;
    print(gender);
  }

  //factory constructor
  factory Animal.createAnimal(String type) {
    if (type == "dog") {
      return Dog(name: 'dog-' + getDate("full"), age: 10, gender: Gender.khac);
    } else {
      return Cat(name: 'cat-' + getDate("full"), age: 10, gender: Gender.khac);
    }
  }
}

getDate(String dmy) {
  DateTime dateToday = DateTime.now();
  var date = dateToday.toString().substring(0, 10);
  var year = date.substring(0, 4);
  var month = date.substring(5, 7);
  var day = date.substring(8, 10);

  switch (dmy) {
    case 'day':
      return day;
    case 'year':
      return year;
    case 'month':
      return month;
    case 'full':
      return date;
  }
  return '0';
//     print(date); // 2021-06-24
}

class Dog extends Animal {
  Dog({required String name, required int age, required Gender gender})
      : super.ani(name: name, age: age, gender: gender);

  @override
  void eat() {
    // TODO: implement eat
    print("dog eat very nhieu");
  }
}

mixin Walkable {
  void walk() {
    print('walk');
  }

  void run() {
    print('run');
  }

  void both() {
    print('walk and run');
  }
}

class Flyable {
  void fly() {
    print('fly');
  }
}

// 1 class chi duoc 'extends' 1 class, nhung co the implements tu nhieu class
// 'implements' phai override lai cac functions, properties

// 'with' (Mixins) khong can thiet phai override
// class mixin khong the su dung 'extends', chi duoc dung 'emplements' hoac 'with'
// Gioi han cac class su dung bang 'mixin on'
class Cat extends Animal with Walkable implements Flyable {
  Cat({required String name, required int age, required Gender gender})
      : super.ani(name: name, age: age, gender: gender);

  @override
  void eat() {
    print('eat');
  }

  @override
  void fly() {
    print('fly');
  }

  Cat.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    age = json['age'];
    switch (json['gender']) {
      case "Duc":
        gender = Gender.duc;
        break;
      case "Cai":
        gender = Gender.cai;
        break;
      case "Khac":
        gender = Gender.khac;
        break;
    }
  }

  //Encode
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['name'] = name;
    data['age'] = age;
    switch (gender) {
      case Gender.khac:
        data['gender'] = "Khac";
        break;
      case Gender.cai:
        data['gender'] = "Cai";
        break;
      case Gender.duc:
        data['gender'] = "Duc";
        break;
    }
    return data;
  }
}

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Thanh Phong Shop'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  int _total = 0;
  String _listBuy = "";

  @override
  Widget build(BuildContext context) {
    var cat1 = Cat(name: 'Tom', age: 5, gender: Gender.cai);
    var cat2 = Cat(name: 'Meo Meo', age: 12, gender: Gender.duc);
    var cat3 = Cat(name: 'Meo Con', age: 7, gender: Gender.cai);
    var cat4 = Cat(name: 'Tieu Ho', age: 15, gender: Gender.khac);
    var cat5 = Cat(name: 'Big Cat', age: 33, gender: Gender.duc);

    var cat6 = Cat(name: 'Meo Con', age: 7, gender: Gender.cai);
    var cat7 = Cat(name: 'Tieu Ho', age: 15, gender: Gender.khac);
    var cat8 = Cat(name: 'Big Cat', age: 33, gender: Gender.duc);

    List<Cat> cats = [];
    cats.add(cat1);
    cats.add(cat2);
    cats.add(cat3);
    cats.add(cat4);
    cats.add(cat5);

    cats.add(cat6);
    cats.add(cat7);

    cats.add(cat3);
    cats.add(cat4);
    cats.add(cat5);
    //cats.add(cat8);

    return Scaffold(
        // appBar: AppBar(
        //   title: Text(widget.title),
        // ),
        body: SafeArea(
      child: Column(
        children: [
          const SizedBox(
            height: 10,
          ),
          Container(
            child: const Text(
              "MENU",
              style: const TextStyle(
                  fontSize: 24, fontWeight: FontWeight.bold, color: Colors.red),
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height / 6 * 3,
            child: GridView.builder(
              //shrinkWrap: true,
              scrollDirection: Axis.vertical,
              padding: const EdgeInsets.all(10),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10.0,
                mainAxisSpacing: 5.0,
                childAspectRatio: 3 / 2, //chieu rong : chieu cao
              ),
              itemCount: cats.length,
              itemBuilder: (context, index) {
                return Material(
                  borderRadius: BorderRadius.circular(100),
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        _counter += 1;
                        _total += cats[index].age! * 2 * 1000;
                        _listBuy = _listBuy +
                            "1 x " +
                            cats[index].name.toString() +
                            "\n";
                      });
                      print("Da them ${cats[index].toJson()} vao gio hang");
                    },
                    child: Ink(
                      child: Column(
                        children: [
                          Align(
                              alignment: Alignment.topLeft,
                              child: Container(
                                alignment: Alignment.center,
                                height: 30,
                                width: 30,
                                child: Text("${index + 1}"),
                                margin: const EdgeInsets.fromLTRB(10, 10, 0, 0),
                                decoration: BoxDecoration(
                                    color: Colors.black12,
                                    borderRadius: BorderRadius.circular(100)),
                              )),
                          Text(
                            "${cats[index].name}",
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text("${cats[index].age} months"),
                          const SizedBox(
                            height: 10,
                          ),
                          Container(
                              alignment: Alignment.bottomRight,
                              child: Text("${cats[index].age! * 2 * 1000} VND"),
                              margin: const EdgeInsets.only(right: 10)),
                        ],
                      ),
                      decoration: cats[index].gender == Gender.duc
                          ? BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              gradient: const LinearGradient(
                                begin: Alignment.topRight,
                                end: Alignment.bottomLeft,
                                colors: [
                                  Colors.blue,
                                  Colors.white,
                                ],
                              ))
                          : cats[index].gender == Gender.khac
                              ? BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  gradient: const LinearGradient(
                                    begin: Alignment.topRight,
                                    end: Alignment.bottomLeft,
                                    colors: [
                                      Colors.red,
                                      Colors.white,
                                    ],
                                  ))
                              : BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  gradient: const LinearGradient(
                                    begin: Alignment.topRight,
                                    end: Alignment.bottomLeft,
                                    colors: [
                                      Colors.yellow,
                                      Colors.white,
                                    ],
                                  )),
                    ),
                  ),
                );
              },
            ),
          ),
          Container(
            decoration: BoxDecoration(
              border: Border.symmetric(horizontal: BorderSide(width: 1))
            ),
            padding: EdgeInsets.all(5),
            child: Row(
              children: [
                const Align(
                  alignment: Alignment.bottomCenter,
                  child: Text(
                    "Shopping Cart",
                    style: TextStyle(fontSize: 16),
                  ),
                ),
                Expanded(child: SizedBox()),
                InkWell(
                    onTap: () {
                      setState(() {
                        _total = 0;
                        _counter = 0;
                        _listBuy = "";
                      });
                    },
                    child: Icon(
                      Icons.autorenew_outlined,
                      size: 30,
                    ),
                ),
                SizedBox(width: 5,)
              ],
            ),
          ),
          Expanded(
              child: Container(
            padding: const EdgeInsets.all(5),
            child: ListView(
              children: [
                Text(
                  _listBuy,
                  style: const TextStyle(fontStyle: FontStyle.italic),
                )
              ],
            ),
          )),
          Container(
            decoration: const BoxDecoration(
                border: Border(
              top: BorderSide(
                color: Colors.black,
                width: 1.0,
              ),
            )),
            child: Row(
              children: [
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                    child: ElevatedButton(
                        onPressed: () {}, child: const Text("Buy now"))),
                const SizedBox(
                  width: 10,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    Row(children: [
                      const SizedBox(
                        width: 20,
                      ),
                      const Text("Quantity: ", style: TextStyle(fontSize: 14)),
                      Text("${_counter}",
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold))
                    ]),
                    Row(
                      children: [
                        const SizedBox(
                          width: 20,
                        ),
                        const Text("Total: ", style: TextStyle(fontSize: 16)),
                        Text("${_total} VND",
                            style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.red)),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    )
                  ],
                ),
                SizedBox(
                  width: 10,
                )
              ],
            ),
          ),
        ],
      ),
    ));
  }
}
