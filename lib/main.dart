import 'package:flutter/material.dart';
import 'models/animal.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final List<Animal> animals = [
    Animal('Tôm', 'assets/images/1.jpg'),
    Animal('Cua', 'assets/images/2.png'),
    Animal('Nai', 'assets/images/nai.jpg'),
    Animal('Rắn', 'assets/images/ran.jpg'),
    Animal('Cá', 'assets/images/ca.jpg'),
    Animal('Gà', 'assets/images/ga.jpg'),
  ];

  late Animal selectedAnimal;

  void changeDiceFace(Animal animal) {
    setState(() {
      selectedAnimal = animal;
    });
  }

  @override
  void initState() {
    super.initState();
    selectedAnimal = animals.isNotEmpty ? animals[0] : Animal('', '');
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Choose animal'),
        ),
        body: Column(
          children: <Widget>[
            ShowListAnimal(animals, selectedAnimal, changeDiceFace),
            Expanded(
              child: Image.asset(
                selectedAnimal.urlImage,
                height: double.infinity,
                width: double.infinity,
              ),
            )
          ],
        ),
      ),
    );
  }
}

class ShowListAnimal extends StatefulWidget {
  final List<Animal> animals;
  final Animal selectedAnimal;
  final Function(Animal) selectAnimalFC;

  const ShowListAnimal(this.animals, this.selectedAnimal, this.selectAnimalFC, {super.key});

  @override
  _ShowListAnimalState createState() => _ShowListAnimalState();
}

class _ShowListAnimalState extends State<ShowListAnimal> {
  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 3,
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      children: widget.animals.map((animal) {
        bool isSelected = animal == widget.selectedAnimal;
        return InkWell(
          onTap: () {
            if (!isSelected) {
              widget.selectAnimalFC(animal);
            }
          },
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
              side: BorderSide(
                color: isSelected ? Colors.red : Colors.transparent,
                width: isSelected ? 2.0 : 0.0,
              ),
            ),
            elevation: 2,
            child: Column(
              children: <Widget>[
                ClipRRect(
                  borderRadius: BorderRadius.circular(10.0),
                  child: Image.asset(
                    animal.urlImage,
                    height: 100,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  animal.name,
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }
}
