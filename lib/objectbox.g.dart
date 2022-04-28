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

import 'Collections/DataModels/FoodCollectionItem.dart';
import 'Collections/DataModels/ObjectCollectionItem.dart';

export 'package:objectbox/objectbox.dart'; // so that callers only have to import this file

final _entities = <ModelEntity>[
  ModelEntity(
      id: const IdUid(1, 3542980577963244658),
      name: 'FoodCollectionItem',
      lastPropertyId: const IdUid(4, 1787125801602014634),
      flags: 0,
      properties: <ModelProperty>[
        ModelProperty(
            id: const IdUid(1, 2524104672097600464),
            name: 'id',
            type: 6,
            flags: 1),
        ModelProperty(
            id: const IdUid(2, 8708371851751136514),
            name: 'labelName',
            type: 9,
            flags: 2048,
            indexId: const IdUid(1, 6180763466594912312)),
        ModelProperty(
            id: const IdUid(3, 1646631461261128516),
            name: 'score',
            type: 6,
            flags: 0),
        ModelProperty(
            id: const IdUid(4, 1787125801602014634),
            name: 'imagePath',
            type: 9,
            flags: 0)
      ],
      relations: <ModelRelation>[],
      backlinks: <ModelBacklink>[]),
  ModelEntity(
      id: const IdUid(2, 3806899465833318696),
      name: 'ObjectCollectionItem',
      lastPropertyId: const IdUid(4, 5652466726390394345),
      flags: 0,
      properties: <ModelProperty>[
        ModelProperty(
            id: const IdUid(1, 4279140238520702892),
            name: 'id',
            type: 6,
            flags: 1),
        ModelProperty(
            id: const IdUid(2, 5786888275400164650),
            name: 'labelName',
            type: 9,
            flags: 2048,
            indexId: const IdUid(2, 517592347636989081)),
        ModelProperty(
            id: const IdUid(3, 3772690156558058165),
            name: 'score',
            type: 8,
            flags: 0),
        ModelProperty(
            id: const IdUid(4, 5652466726390394345),
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
      lastEntityId: const IdUid(2, 3806899465833318696),
      lastIndexId: const IdUid(2, 517592347636989081),
      lastRelationId: const IdUid(0, 0),
      lastSequenceId: const IdUid(0, 0),
      retiredEntityUids: const [],
      retiredIndexUids: const [],
      retiredPropertyUids: const [],
      retiredRelationUids: const [],
      modelVersion: 5,
      modelVersionParserMinimum: 5,
      version: 1);

  final bindings = <Type, EntityDefinition>{
    FoodCollectionItem: EntityDefinition<FoodCollectionItem>(
        model: _entities[0],
        toOneRelations: (FoodCollectionItem object) => [],
        toManyRelations: (FoodCollectionItem object) => {},
        getId: (FoodCollectionItem object) => object.id,
        setId: (FoodCollectionItem object, int id) {
          object.id = id;
        },
        objectToFB: (FoodCollectionItem object, fb.Builder fbb) {
          final labelNameOffset = fbb.writeString(object.labelName);
          final imagePathOffset = object.imagePath == null
              ? null
              : fbb.writeString(object.imagePath!);
          fbb.startTable(5);
          fbb.addInt64(0, object.id);
          fbb.addOffset(1, labelNameOffset);
          fbb.addInt64(2, object.score);
          fbb.addOffset(3, imagePathOffset);
          fbb.finish(fbb.endTable());
          return object.id;
        },
        objectFromFB: (Store store, ByteData fbData) {
          final buffer = fb.BufferContext(fbData);
          final rootOffset = buffer.derefObject(0);

          final object = FoodCollectionItem(
              id: const fb.Int64Reader().vTableGet(buffer, rootOffset, 4, 0),
              labelName: const fb.StringReader(asciiOptimization: true)
                  .vTableGet(buffer, rootOffset, 6, ''),
              score: const fb.Int64Reader().vTableGet(buffer, rootOffset, 8, 0),
              imagePath: const fb.StringReader(asciiOptimization: true)
                  .vTableGetNullable(buffer, rootOffset, 10));

          return object;
        }),
    ObjectCollectionItem: EntityDefinition<ObjectCollectionItem>(
        model: _entities[1],
        toOneRelations: (ObjectCollectionItem object) => [],
        toManyRelations: (ObjectCollectionItem object) => {},
        getId: (ObjectCollectionItem object) => object.id,
        setId: (ObjectCollectionItem object, int id) {
          object.id = id;
        },
        objectToFB: (ObjectCollectionItem object, fb.Builder fbb) {
          final labelNameOffset = fbb.writeString(object.labelName);
          final imagePathOffset = object.imagePath == null
              ? null
              : fbb.writeString(object.imagePath!);
          fbb.startTable(5);
          fbb.addInt64(0, object.id);
          fbb.addOffset(1, labelNameOffset);
          fbb.addFloat64(2, object.score);
          fbb.addOffset(3, imagePathOffset);
          fbb.finish(fbb.endTable());
          return object.id;
        },
        objectFromFB: (Store store, ByteData fbData) {
          final buffer = fb.BufferContext(fbData);
          final rootOffset = buffer.derefObject(0);

          final object = ObjectCollectionItem(
              id: const fb.Int64Reader().vTableGet(buffer, rootOffset, 4, 0),
              labelName: const fb.StringReader(asciiOptimization: true)
                  .vTableGet(buffer, rootOffset, 6, ''),
              score:
                  const fb.Float64Reader().vTableGet(buffer, rootOffset, 8, 0),
              imagePath: const fb.StringReader(asciiOptimization: true)
                  .vTableGetNullable(buffer, rootOffset, 10));

          return object;
        })
  };

  return ModelDefinition(model, bindings);
}

/// [FoodCollectionItem] entity fields to define ObjectBox queries.
class FoodCollectionItem_ {
  /// see [FoodCollectionItem.id]
  static final id =
      QueryIntegerProperty<FoodCollectionItem>(_entities[0].properties[0]);

  /// see [FoodCollectionItem.labelName]
  static final labelName =
      QueryStringProperty<FoodCollectionItem>(_entities[0].properties[1]);

  /// see [FoodCollectionItem.score]
  static final score =
      QueryIntegerProperty<FoodCollectionItem>(_entities[0].properties[2]);

  /// see [FoodCollectionItem.imagePath]
  static final imagePath =
      QueryStringProperty<FoodCollectionItem>(_entities[0].properties[3]);
}

/// [ObjectCollectionItem] entity fields to define ObjectBox queries.
class ObjectCollectionItem_ {
  /// see [ObjectCollectionItem.id]
  static final id =
      QueryIntegerProperty<ObjectCollectionItem>(_entities[1].properties[0]);

  /// see [ObjectCollectionItem.labelName]
  static final labelName =
      QueryStringProperty<ObjectCollectionItem>(_entities[1].properties[1]);

  /// see [ObjectCollectionItem.score]
  static final score =
      QueryDoubleProperty<ObjectCollectionItem>(_entities[1].properties[2]);

  /// see [ObjectCollectionItem.imagePath]
  static final imagePath =
      QueryStringProperty<ObjectCollectionItem>(_entities[1].properties[3]);
}
