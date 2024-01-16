enum SortType {
  position(0),
  nameAscending(5),
  nameDescending(6),
  priceAscending(10),
  priceDescending(11),
  soldOut(0);

  final int value;
  const SortType(this.value);
}
