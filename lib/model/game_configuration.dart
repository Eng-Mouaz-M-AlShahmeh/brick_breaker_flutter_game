/* Developed by Eng Mouaz M AlShahmeh */
class BrickConfiguration {
  int row;
  int column;
  List<dynamic> matrix;
  double widthGap;
  double heightGap;
  int brickBrokenHits;
  double brickWidth;
  double brickHeight;

  BrickConfiguration(
      {required this.row,
      required this.column,
      required this.matrix,
      required this.widthGap,
      required this.heightGap,
      required this.brickBrokenHits,
      required this.brickHeight,
      required this.brickWidth});
}
