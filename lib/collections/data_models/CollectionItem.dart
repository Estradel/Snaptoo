import 'package:objectbox/objectbox.dart';

@Entity()
class CollectionItem {
  // Annotate with @Id() if name isn't "id" (case insensitive).
  int id;

  @Index()
  @Unique(onConflict: ConflictStrategy.replace)
  String labelName;

  String category;

  double score;

  String? imagePath;

  CollectionItem({this.id = 0, required this.labelName, required this.category, required this.score, this.imagePath});

  @override
  String toString() {
    // TODO: implement toString
    return super.toString() +
        "id : $id, labelName : $labelName, category: $category, score : $score, image : $imagePath";
  }
}
