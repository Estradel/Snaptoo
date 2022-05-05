// GENERATED CODE - DO NOT MODIFY BY HAND
// This code was generated by ObjectBox. To update it run the generator again:
// With a Flutter package, run `flutter pub run build_runner build`.
// With a Dart package, run `dart run build_runner build`.
// See also https://docs.objectbox.io/getting-started#generate-objectbox-code

// ignore_for_file: camel_case_types

import 'dart:typed_data';

import 'package:flat_buffers/flat_buffers.dart' as fb;
import 'package:objectbox/internal.dart'; // generated code can access "internal" functionality
import 'package:objectbox/objectbox.dart';
import 'package:objectbox_flutter_libs/objectbox_flutter_libs.dart';

import 'collections/data_models/CollectionItem.dart';

export 'package:objectbox/objectbox.dart'; // so that callers only have to import this file

final _entities = <ModelEntity>[
  ModelEntity(
      id: const IdUid(3, 8341119842047109188),
      name: 'CollectionItem',
      lastPropertyId: const IdUid(5, 335724486214129801),
      flags: 0,
      properties: <ModelProperty>[
        ModelProperty(
            id: const IdUid(1, 6929915993761183136),
            name: 'id',
            type: 6,
            flags: 1),
        ModelProperty(
            id: const IdUid(2, 797614560904065804),
            name: 'labelName',
            type: 9,
            flags: 2048,
            indexId: const IdUid(3, 1300776308416467287)),
        ModelProperty(
            id: const IdUid(3, 4669194193586940192),
            name: 'category',
            type: 9,
            flags: 2048,
            indexId: const IdUid(4, 8812758979872091088)),
        ModelProperty(
            id: const IdUid(4, 3776341041189923167),
            name: 'score',
            type: 8,
            flags: 0),
        ModelProperty(
            id: const IdUid(5, 335724486214129801),
            name: 'imagePath',
            type: 9,
            flags: 0)
      ],
      relations: <ModelRelation>[],
      backlinks: <ModelBacklink>[])
];

/// Open an ObjectBox store with the model declared in this file.
Future<Store> openStore(
        {String? directory,
        int? maxDBSizeInKB,
        int? fileMode,
        int? maxReaders,
        bool queriesCaseSensitiveDefault = true,
        String? macosApplicationGroup}) async =>
    Store(getObjectBoxModel(),
        directory: directory ?? (await defaultStoreDirectory()).path,
        maxDBSizeInKB: maxDBSizeInKB,
        fileMode: fileMode,
        maxReaders: maxReaders,
        queriesCaseSensitiveDefault: queriesCaseSensitiveDefault,
        macosApplicationGroup: macosApplicationGroup);

/// ObjectBox model definition, pass it to [Store] - Store(getObjectBoxModel())
ModelDefinition getObjectBoxModel() {
  final model = ModelInfo(
      entities: _entities,
      lastEntityId: const IdUid(3, 8341119842047109188),
      lastIndexId: const IdUid(4, 8812758979872091088),
      lastRelationId: const IdUid(0, 0),
      lastSequenceId: const IdUid(0, 0),
      retiredEntityUids: const [3542980577963244658, 3806899465833318696],
      retiredIndexUids: const [],
      retiredPropertyUids: const [
        2524104672097600464,
        8708371851751136514,
        1646631461261128516,
        1787125801602014634,
        4279140238520702892,
        5786888275400164650,
        3772690156558058165,
        5652466726390394345
      ],
      retiredRelationUids: const [],
      modelVersion: 5,
      modelVersionParserMinimum: 5,
      version: 1);

  final bindings = <Type, EntityDefinition>{
    CollectionItem: EntityDefinition<CollectionItem>(
        model: _entities[0],
        toOneRelations: (CollectionItem object) => [],
        toManyRelations: (CollectionItem object) => {},
        getId: (CollectionItem object) => object.id,
        setId: (CollectionItem object, int id) {
          object.id = id;
        },
        objectToFB: (CollectionItem object, fb.Builder fbb) {
          final labelNameOffset = fbb.writeString(object.labelName);
          final categoryOffset = fbb.writeString(object.category);
          final imagePathOffset = object.imagePath == null
              ? null
              : fbb.writeString(object.imagePath!);
          fbb.startTable(6);
          fbb.addInt64(0, object.id);
          fbb.addOffset(1, labelNameOffset);
          fbb.addOffset(2, categoryOffset);
          fbb.addFloat64(3, object.score);
          fbb.addOffset(4, imagePathOffset);
          fbb.finish(fbb.endTable());
          return object.id;
        },
        objectFromFB: (Store store, ByteData fbData) {
          final buffer = fb.BufferContext(fbData);
          final rootOffset = buffer.derefObject(0);

          final object = CollectionItem(
              id: const fb.Int64Reader().vTableGet(buffer, rootOffset, 4, 0),
              labelName: const fb.StringReader(asciiOptimization: true)
                  .vTableGet(buffer, rootOffset, 6, ''),
              category: const fb.StringReader(asciiOptimization: true)
                  .vTableGet(buffer, rootOffset, 8, ''),
              score:
                  const fb.Float64Reader().vTableGet(buffer, rootOffset, 10, 0),
              imagePath: const fb.StringReader(asciiOptimization: true)
                  .vTableGetNullable(buffer, rootOffset, 12));

          return object;
        })
  };

  return ModelDefinition(model, bindings);
}

/// [CollectionItem] entity fields to define ObjectBox queries.
class CollectionItem_ {
  /// see [CollectionItem.id]
  static final id =
      QueryIntegerProperty<CollectionItem>(_entities[0].properties[0]);

  /// see [CollectionItem.labelName]
  static final labelName =
      QueryStringProperty<CollectionItem>(_entities[0].properties[1]);

  /// see [CollectionItem.category]
  static final category =
      QueryStringProperty<CollectionItem>(_entities[0].properties[2]);

  /// see [CollectionItem.score]
  static final score =
      QueryDoubleProperty<CollectionItem>(_entities[0].properties[3]);

  /// see [CollectionItem.imagePath]
  static final imagePath =
      QueryStringProperty<CollectionItem>(_entities[0].properties[4]);
}
