enum OrderStatus {
  Pending(1),
  InTheWay(2),
  Canceled(3),
  Delivered(4),
  Approved(5),
  ReadyToShip(6),
  Submitted(7),
  Reorder(8),
  CreateBySales(10);

  final int value;
  const OrderStatus(this.value);
}
