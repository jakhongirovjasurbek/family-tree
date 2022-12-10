// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:family_tree/person_list.dart';

import 'vertex.dart';

class Edge<T> {
  const Edge(
    this.source,
    this.destination, [
    this.weight,
  ]);
  final Vertex<T> source;
  final Vertex<T> destination;
  final RelationshipType? weight;

  @override
  // String toString() => 'Connection: $source --> $destination, weight: $weight';
  String toString() => "${relationTypeToString(weight)}'s info: $destination";
}

enum RelationshipType {
  grandFather,
  grandMother,
  grandParent,
  father,
  mother,
  brother,
  sister,
  uncle,
  husband,
  wife,
  child,
  grandChild,
  me,
  unknown,
  parent,
}

RelationshipType? getProperRelationAgainst(RelationshipType relationship) {
  if (relationship == RelationshipType.grandFather ||
      relationship == RelationshipType.grandMother) {
    return RelationshipType.grandChild;
  } else if (relationship == RelationshipType.mother ||
      relationship == RelationshipType.father) {
    return RelationshipType.child;
  } else if (relationship == RelationshipType.sister) {
    return RelationshipType.brother;
  } else if (relationship == RelationshipType.brother) {
    return RelationshipType.sister;
  } else if (relationship == RelationshipType.husband) {
    return RelationshipType.wife;
  } else if (relationship == RelationshipType.wife) {
    return RelationshipType.husband;
  } else if (relationship == RelationshipType.child) {
    return RelationshipType.parent;
  } else if (relationship == RelationshipType.grandChild) {
    return RelationshipType.grandParent;
  } else {
    return RelationshipType.unknown;
  }
}
