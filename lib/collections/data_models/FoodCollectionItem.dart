import 'package:objectbox/objectbox.dart';


@Entity()
class FoodCollectionItem{
  // Annotate with @Id() if name isn't "id" (case insensitive).
  int id;
  @Index() String labelName;
  int score;
  String? imagePath;

  FoodCollectionItem({this.id=0, required this.labelName, required this.score, this.imagePath});

  @override
  String toString() {
    // TODO: implement toString
    return super.toString() + "id : $id, labelName : $labelName, score : $score, image : $imagePath";
  }
}