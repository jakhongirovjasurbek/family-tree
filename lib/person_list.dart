import 'package:family_tree/edge_type.dart';
import 'package:family_tree/person.dart';
import 'package:family_tree/vertex.dart';

import 'edge.dart';
import 'graph.dart';

class PersonList implements Graph<Person> {
  final Map<Vertex<Person>, List<Edge<Person>>> _connections = {};
  var _nextIndex = 0;
  @override
  Iterable<Vertex<Person>> get vertices => _connections.keys;
  @override
  void addEdge(
    Vertex<Person> source,
    Vertex<Person> destination, {
    EdgeType edgeType = EdgeType.undirected,
    RelationshipType? weight,
  }) {
    _connections[source]?.add(
      Edge(source, destination, weight),
    );

    if (edgeType == EdgeType.undirected) {
      _connections[destination]?.add(
        Edge(destination, source, weight),
      );
    }
  }

  @override
  Vertex<Person> createVertex(Person data) {
    final vertex = Vertex<Person>(
      index: _nextIndex,
      data: data,
    );
    _nextIndex++;

    _connections[vertex] = [];
    return vertex;
  }

  @override
  List<Edge<Person>> edges(Vertex<Person> source) {
    return _connections[source] ?? [];
  }

  @override
  RelationshipType? weight(
    Vertex<Person> source,
    Vertex<Person> destination,
  ) {
    final match = edges(source).where((edge) {
      return edge.destination == destination;
    });
    if (match.isEmpty) return null;
    return match.first.weight;
  }

  @override
  String toString() {
    final result = StringBuffer();

    _connections.forEach((vertex, edges) {
      final destinations = edges.map((edge) {
        // return '${edge.destination.data.firstName}, relation: ${edge.weight}';
        return '''${edge.destination.data}
              Relation: ${relationTypeToString(edge.weight)}
               ''';
      }).join(', ');

      result.writeln('${vertex.data.firstName} --> $destinations ');
    });
    return result.toString();
  }
}

String relationTypeToString(RelationshipType? type) {
  String string = '';

  switch (type) {
    case RelationshipType.grandFather:
      string = 'Grandfather';
      break;
    case RelationshipType.grandMother:
      string = 'Grandmother';
      break;
    case RelationshipType.father:
      string = 'Father';
      break;
    case RelationshipType.mother:
      string = 'Mother';
      break;
    case RelationshipType.brother:
      string = 'Brother';
      break;
    case RelationshipType.sister:
      string = 'Sister';
      break;
    case RelationshipType.husband:
      string = 'Husband';
      break;
    case RelationshipType.wife:
      string = 'Wife';
      break;
    case RelationshipType.uncle:
      string = 'Uncle';
      break;
    case RelationshipType.grandChild:
      string = 'Grandchild';
      break;
    case RelationshipType.child:
      string = 'Child';
      break;
    case RelationshipType.grandParent:
      string = 'Grandparent';
      break;
    case RelationshipType.me:
      string = 'Me';
      break;
    case RelationshipType.parent:
      string = 'Parent';
      break;
    case RelationshipType.unknown:
      string = 'Far relationship';
      break;
    default:
  }

  return string;
}
