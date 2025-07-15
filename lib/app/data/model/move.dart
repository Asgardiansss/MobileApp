class MoveData {
  final String moveType;
  final String label;
  final String description;
  final List<String> steps;

  MoveData({
    required this.moveType,
    required this.label,
    required this.description,
    this.steps = const [],
  });
}
