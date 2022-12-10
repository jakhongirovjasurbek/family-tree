import 'dart:io';
import 'package:family_tree/edge.dart';
import 'package:family_tree/edge_type.dart';
import 'package:family_tree/person.dart';
import 'package:family_tree/person_list.dart';
import 'package:family_tree/vertex.dart';

var me = Person(firstName: '', lastName: '', age: 0, isMale: false, bio: '');
var list = PersonList();

late Vertex<Person> meVertex;

void main(_) {
  bool isTerminated = false;

  while (me.firstName.isEmpty) {
    print('''
--------------------------------------------------------------------------------
          Welcome to the Family Tree Application
          Please, fill about yourself before starting the application
--------------------------------------------------------------------------------
          ''');
    me = addPerson();

    meVertex = list.createVertex(me);
    clear();
  }

  while (!isTerminated) {
    print('''
-----------------------------------------------
          1. Add Relation
          2. Remove Relation
          3. Show all people
          4. Show my family tree
          5. Show all relations
          6. Exit
-----------------------------------------------
          ''');

    String? input = stdin.readLineSync();
    if (input == '6') {
      isTerminated = true;
      break;
    }

    final operation = parseOperationOrder(input);

    switch (operation) {
      case 0:
        clear();
        print('Invalid operation, please try again');
        break;

      case 1:
        clear();
        final person = list.createVertex(addPerson());
        createRelation(person: person);

        break;

      case 3:
        clear();
        print('People in database:\n');
        for (var index = 0; index < list.vertices.length; index++) {
          print('${index + 1}.${list.vertices.toList()[index]}');
        }
        break;
      case 4:
        final edges = list.edges(meVertex);
        for (var index = 0; index < edges.length; index++) {
          print('${index + 1}.${edges.toList()[index]}');
        }
        break;
      case 5:
        print(list);
        break;
      default:
    }
  }

  // final graph = PersonList();
  // final me = graph.createVertex(
  //   const Person(
  //       firstName: 'Jasur',
  //       lastName: 'Jakhongirov',
  //       age: 23,
  //       isMale: true,
  //       bio: '23 y.o software engineer from Uzbekistan'),
  // );
  // final mother = graph.createVertex(
  //   const Person(
  //     firstName: 'Ummu Jasur',
  //     lastName: 'Khudashukurova',
  //     age: 47,
  //     isMale: false,
  //     bio: 'Doctor',
  //   ),
  // );
  // final father = graph.createVertex(
  //   const Person(
  //     firstName: 'Davron',
  //     lastName: 'Ismailov',
  //     age: 49,
  //     isMale: true,
  //     bio: 'Engineer',
  //   ),
  // );
  // final sister = graph.createVertex(
  //   const Person(
  //     firstName: 'Singlim',
  //     lastName: 'Jakhongirov',
  //     age: 49,
  //     isMale: false,
  //     bio: 'Student',
  //   ),
  // );
  // graph.addEdge(me, mother, weight: RelationshipType.mother);
  // graph.addEdge(me, father, weight: RelationshipType.father);
  // graph.addEdge(me, sister, weight: RelationshipType.sister);
  // graph.addEdge(mother, father, weight: RelationshipType.wife);
  // print(graph);
}

void clear() {
  if (Platform.isWindows) {
    print(Process.runSync("clear", [], runInShell: true).stdout);
  } else {
    print(Process.runSync("clear", [], runInShell: true).stdout);
  }
}

int? parseOperationOrder(String? operation) {
  if (operation == null || operation.isEmpty) {
    return 0;
  } else {
    try {
      final input = int.parse(operation);
      return input;
    } catch (e) {
      return 0;
    }
  }
}

Person addPerson() {
  var person =
      Person(firstName: '', lastName: '', age: 0, isMale: false, bio: '');
  print('Please, enter first name:');

  String? firstName = stdin.readLineSync();
  bool isFirstNameValid = false;
  while (!isFirstNameValid) {
    if (firstName == null || firstName.isEmpty) {
      clear();
      print('First name cannot be empty!');
      firstName = stdin.readLineSync();
      continue;
    }
    isFirstNameValid = true;
  }
  person = person.copyWith(firstName: firstName);
  print('Please, enter last name:');
  bool isLastNameValid = false;
  String? lastName = stdin.readLineSync();
  while (!isLastNameValid) {
    if (lastName == null || lastName.isEmpty) {
      clear();

      print('Last name cannot be empty!');
      lastName = stdin.readLineSync();
      continue;
    }
    isLastNameValid = true;
  }
  person = person.copyWith(lastName: lastName);

  print('Please, enter age:');

  String? inputAge = stdin.readLineSync();
  late int age;
  bool isAgeValid = false;
  while (!isAgeValid) {
    if (inputAge == null || inputAge.isEmpty) {
      clear();
      print('Invalid data entered');
      inputAge = stdin.readLineSync();
    } else {
      try {
        age = int.parse(inputAge);
        isAgeValid = true;
      } catch (e) {
        clear();
        continue;
      }
    }
  }

  person = person.copyWith(age: age);

  print('Is male? (y/n)');

  var input = stdin.readLineSync();
  late bool isMale;
  bool isGenderValid = false;

  while (!isGenderValid) {
    if (input == null || input.isEmpty) {
      clear();
      print('Gender is not valid!');
      input = stdin.readLineSync();
    }
    switch (input?.toLowerCase()) {
      case 'y':
        isMale = true;
        isGenderValid = true;
        break;
      case 'n':
        isMale = false;
        isGenderValid = true;
        break;
    }
  }

  person = person.copyWith(isMale: isMale);

  print('Please, write a description about this person (optional):');

  input = stdin.readLineSync();

  person = person.copyWith(bio: input);
  print('Person data has been added to database successfully: \n$person');
  return person;
}

void createRelation({required Vertex<Person> person}) {
  late RelationshipType relationshipType;
  clear();
  print('''
        Choose relation type:
            1. Grandfather
            2. Grandmother
            3. Father
            4. Mother
            5. Brother
            6. Sister
            7. Husband
            8. Wife
            9. Uncle
        ''');

  var input = stdin.readLineSync();

  var isRelationValid = false;
  while (!isRelationValid) {
    if (input != null && input.isNotEmpty) {
      switch (input) {
        case '1':
          relationshipType = RelationshipType.grandFather;
          isRelationValid = true;
          break;
        case '2':
          relationshipType = RelationshipType.grandMother;
          isRelationValid = true;

          break;
        case '3':
          relationshipType = RelationshipType.father;
          isRelationValid = true;

          break;
        case '4':
          relationshipType = RelationshipType.mother;
          isRelationValid = true;

          break;
        case '5':
          relationshipType = RelationshipType.brother;
          isRelationValid = true;

          break;
        case '6':
          relationshipType = RelationshipType.sister;
          isRelationValid = true;

          break;
        case '7':
          relationshipType = RelationshipType.husband;
          isRelationValid = true;

          break;
        case '8':
          relationshipType = RelationshipType.wife;
          isRelationValid = true;
          break;
        case '9':
          relationshipType = RelationshipType.uncle;
          isRelationValid = true;
          break;
        default:
      }
    } else {
      clear();
      print('Invalid input');
      input = stdin.readLineSync();
    }
  }

  list.addEdge(
    meVertex,
    person,
    edgeType: EdgeType.directed,
    weight: relationshipType,
  );

  list.addEdge(
    person,
    meVertex,
    edgeType: EdgeType.directed,
    weight: getProperRelationAgainst(relationshipType),
  );

  print('Relation has been added.');
}
