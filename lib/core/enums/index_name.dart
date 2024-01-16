abstract class IndexName {
  final int index;
  final String name;

  const IndexName(this.index, this.name);

  @override
  String toString() => '{$index: $name}';
}
