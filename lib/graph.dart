import 'package:family_tree/vertex.dart';

import 'edge.dart';
import 'edge_type.dart';

abstract class Graph<E> {
  Iterable<Vertex<E>> get vertices;
  Vertex<E> createVertex(E data);
  void addEdge(
    Vertex<E> source,
    Vertex<E> destination, {
    EdgeType edgeType,
    RelationshipType? weight,
  });
  List<Edge<E>> edges(Vertex<E> source);
  RelationshipType? weight(
    Vertex<E> source,
    Vertex<E> destination,
  );
}
