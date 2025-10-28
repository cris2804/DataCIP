// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'parcela.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetParcelaCollection on Isar {
  IsarCollection<Parcela> get parcelas => this.collection();
}

const ParcelaSchema = CollectionSchema(
  name: r'Parcela',
  id: -4954991822615339008,
  properties: {
    r'estado': PropertySchema(id: 0, name: r'estado', type: IsarType.string),
    r'fechaEstado': PropertySchema(
      id: 1,
      name: r'fechaEstado',
      type: IsarType.dateTime,
    ),
    r'fotos': PropertySchema(id: 2, name: r'fotos', type: IsarType.stringList),
    r'geojsonFeature': PropertySchema(
      id: 3,
      name: r'geojsonFeature',
      type: IsarType.string,
    ),
    r'observaciones': PropertySchema(
      id: 4,
      name: r'observaciones',
      type: IsarType.string,
    ),
    r'parcelaId': PropertySchema(
      id: 5,
      name: r'parcelaId',
      type: IsarType.string,
    ),
  },
  estimateSize: _parcelaEstimateSize,
  serialize: _parcelaSerialize,
  deserialize: _parcelaDeserialize,
  deserializeProp: _parcelaDeserializeProp,
  idName: r'id',
  indexes: {
    r'parcelaId': IndexSchema(
      id: 9102569624310591488,
      name: r'parcelaId',
      unique: true,
      replace: true,
      properties: [
        IndexPropertySchema(
          name: r'parcelaId',
          type: IndexType.hash,
          caseSensitive: true,
        ),
      ],
    ),
  },
  links: {},
  embeddedSchemas: {},
  getId: _parcelaGetId,
  getLinks: _parcelaGetLinks,
  attach: _parcelaAttach,
  version: '3.1.0+1',
);

int _parcelaEstimateSize(
  Parcela object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.estado.length * 3;
  bytesCount += 3 + object.fotos.length * 3;
  {
    for (var i = 0; i < object.fotos.length; i++) {
      final value = object.fotos[i];
      bytesCount += value.length * 3;
    }
  }
  bytesCount += 3 + object.geojsonFeature.length * 3;
  bytesCount += 3 + object.observaciones.length * 3;
  bytesCount += 3 + object.parcelaId.length * 3;
  return bytesCount;
}

void _parcelaSerialize(
  Parcela object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.estado);
  writer.writeDateTime(offsets[1], object.fechaEstado);
  writer.writeStringList(offsets[2], object.fotos);
  writer.writeString(offsets[3], object.geojsonFeature);
  writer.writeString(offsets[4], object.observaciones);
  writer.writeString(offsets[5], object.parcelaId);
}

Parcela _parcelaDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = Parcela(
    estado: reader.readString(offsets[0]),
    fechaEstado: reader.readDateTime(offsets[1]),
    fotos: reader.readStringList(offsets[2]) ?? const [],
    geojsonFeature: reader.readStringOrNull(offsets[3]) ?? '',
    observaciones: reader.readStringOrNull(offsets[4]) ?? '',
    parcelaId: reader.readString(offsets[5]),
  );
  object.id = id;
  return object;
}

P _parcelaDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readString(offset)) as P;
    case 1:
      return (reader.readDateTime(offset)) as P;
    case 2:
      return (reader.readStringList(offset) ?? const []) as P;
    case 3:
      return (reader.readStringOrNull(offset) ?? '') as P;
    case 4:
      return (reader.readStringOrNull(offset) ?? '') as P;
    case 5:
      return (reader.readString(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _parcelaGetId(Parcela object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _parcelaGetLinks(Parcela object) {
  return [];
}

void _parcelaAttach(IsarCollection<dynamic> col, Id id, Parcela object) {
  object.id = id;
}

extension ParcelaByIndex on IsarCollection<Parcela> {
  Future<Parcela?> getByParcelaId(String parcelaId) {
    return getByIndex(r'parcelaId', [parcelaId]);
  }

  Parcela? getByParcelaIdSync(String parcelaId) {
    return getByIndexSync(r'parcelaId', [parcelaId]);
  }

  Future<bool> deleteByParcelaId(String parcelaId) {
    return deleteByIndex(r'parcelaId', [parcelaId]);
  }

  bool deleteByParcelaIdSync(String parcelaId) {
    return deleteByIndexSync(r'parcelaId', [parcelaId]);
  }

  Future<List<Parcela?>> getAllByParcelaId(List<String> parcelaIdValues) {
    final values = parcelaIdValues.map((e) => [e]).toList();
    return getAllByIndex(r'parcelaId', values);
  }

  List<Parcela?> getAllByParcelaIdSync(List<String> parcelaIdValues) {
    final values = parcelaIdValues.map((e) => [e]).toList();
    return getAllByIndexSync(r'parcelaId', values);
  }

  Future<int> deleteAllByParcelaId(List<String> parcelaIdValues) {
    final values = parcelaIdValues.map((e) => [e]).toList();
    return deleteAllByIndex(r'parcelaId', values);
  }

  int deleteAllByParcelaIdSync(List<String> parcelaIdValues) {
    final values = parcelaIdValues.map((e) => [e]).toList();
    return deleteAllByIndexSync(r'parcelaId', values);
  }

  Future<Id> putByParcelaId(Parcela object) {
    return putByIndex(r'parcelaId', object);
  }

  Id putByParcelaIdSync(Parcela object, {bool saveLinks = true}) {
    return putByIndexSync(r'parcelaId', object, saveLinks: saveLinks);
  }

  Future<List<Id>> putAllByParcelaId(List<Parcela> objects) {
    return putAllByIndex(r'parcelaId', objects);
  }

  List<Id> putAllByParcelaIdSync(
    List<Parcela> objects, {
    bool saveLinks = true,
  }) {
    return putAllByIndexSync(r'parcelaId', objects, saveLinks: saveLinks);
  }
}

extension ParcelaQueryWhereSort on QueryBuilder<Parcela, Parcela, QWhere> {
  QueryBuilder<Parcela, Parcela, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension ParcelaQueryWhere on QueryBuilder<Parcela, Parcela, QWhereClause> {
  QueryBuilder<Parcela, Parcela, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(lower: id, upper: id));
    });
  }

  QueryBuilder<Parcela, Parcela, QAfterWhereClause> idNotEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<Parcela, Parcela, QAfterWhereClause> idGreaterThan(
    Id id, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<Parcela, Parcela, QAfterWhereClause> idLessThan(
    Id id, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<Parcela, Parcela, QAfterWhereClause> idBetween(
    Id lowerId,
    Id upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.between(
          lower: lowerId,
          includeLower: includeLower,
          upper: upperId,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<Parcela, Parcela, QAfterWhereClause> parcelaIdEqualTo(
    String parcelaId,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.equalTo(indexName: r'parcelaId', value: [parcelaId]),
      );
    });
  }

  QueryBuilder<Parcela, Parcela, QAfterWhereClause> parcelaIdNotEqualTo(
    String parcelaId,
  ) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'parcelaId',
                lower: [],
                upper: [parcelaId],
                includeUpper: false,
              ),
            )
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'parcelaId',
                lower: [parcelaId],
                includeLower: false,
                upper: [],
              ),
            );
      } else {
        return query
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'parcelaId',
                lower: [parcelaId],
                includeLower: false,
                upper: [],
              ),
            )
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'parcelaId',
                lower: [],
                upper: [parcelaId],
                includeUpper: false,
              ),
            );
      }
    });
  }
}

extension ParcelaQueryFilter
    on QueryBuilder<Parcela, Parcela, QFilterCondition> {
  QueryBuilder<Parcela, Parcela, QAfterFilterCondition> estadoEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'estado',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Parcela, Parcela, QAfterFilterCondition> estadoGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'estado',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Parcela, Parcela, QAfterFilterCondition> estadoLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'estado',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Parcela, Parcela, QAfterFilterCondition> estadoBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'estado',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Parcela, Parcela, QAfterFilterCondition> estadoStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'estado',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Parcela, Parcela, QAfterFilterCondition> estadoEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'estado',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Parcela, Parcela, QAfterFilterCondition> estadoContains(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'estado',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Parcela, Parcela, QAfterFilterCondition> estadoMatches(
    String pattern, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'estado',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Parcela, Parcela, QAfterFilterCondition> estadoIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'estado', value: ''),
      );
    });
  }

  QueryBuilder<Parcela, Parcela, QAfterFilterCondition> estadoIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'estado', value: ''),
      );
    });
  }

  QueryBuilder<Parcela, Parcela, QAfterFilterCondition> fechaEstadoEqualTo(
    DateTime value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'fechaEstado', value: value),
      );
    });
  }

  QueryBuilder<Parcela, Parcela, QAfterFilterCondition> fechaEstadoGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'fechaEstado',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<Parcela, Parcela, QAfterFilterCondition> fechaEstadoLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'fechaEstado',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<Parcela, Parcela, QAfterFilterCondition> fechaEstadoBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'fechaEstado',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<Parcela, Parcela, QAfterFilterCondition> fotosElementEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'fotos',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Parcela, Parcela, QAfterFilterCondition> fotosElementGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'fotos',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Parcela, Parcela, QAfterFilterCondition> fotosElementLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'fotos',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Parcela, Parcela, QAfterFilterCondition> fotosElementBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'fotos',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Parcela, Parcela, QAfterFilterCondition> fotosElementStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'fotos',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Parcela, Parcela, QAfterFilterCondition> fotosElementEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'fotos',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Parcela, Parcela, QAfterFilterCondition> fotosElementContains(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'fotos',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Parcela, Parcela, QAfterFilterCondition> fotosElementMatches(
    String pattern, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'fotos',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Parcela, Parcela, QAfterFilterCondition> fotosElementIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'fotos', value: ''),
      );
    });
  }

  QueryBuilder<Parcela, Parcela, QAfterFilterCondition>
  fotosElementIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'fotos', value: ''),
      );
    });
  }

  QueryBuilder<Parcela, Parcela, QAfterFilterCondition> fotosLengthEqualTo(
    int length,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(r'fotos', length, true, length, true);
    });
  }

  QueryBuilder<Parcela, Parcela, QAfterFilterCondition> fotosIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(r'fotos', 0, true, 0, true);
    });
  }

  QueryBuilder<Parcela, Parcela, QAfterFilterCondition> fotosIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(r'fotos', 0, false, 999999, true);
    });
  }

  QueryBuilder<Parcela, Parcela, QAfterFilterCondition> fotosLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(r'fotos', 0, true, length, include);
    });
  }

  QueryBuilder<Parcela, Parcela, QAfterFilterCondition> fotosLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(r'fotos', length, include, 999999, true);
    });
  }

  QueryBuilder<Parcela, Parcela, QAfterFilterCondition> fotosLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'fotos',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<Parcela, Parcela, QAfterFilterCondition> geojsonFeatureEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'geojsonFeature',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Parcela, Parcela, QAfterFilterCondition>
  geojsonFeatureGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'geojsonFeature',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Parcela, Parcela, QAfterFilterCondition> geojsonFeatureLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'geojsonFeature',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Parcela, Parcela, QAfterFilterCondition> geojsonFeatureBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'geojsonFeature',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Parcela, Parcela, QAfterFilterCondition>
  geojsonFeatureStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'geojsonFeature',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Parcela, Parcela, QAfterFilterCondition> geojsonFeatureEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'geojsonFeature',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Parcela, Parcela, QAfterFilterCondition> geojsonFeatureContains(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'geojsonFeature',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Parcela, Parcela, QAfterFilterCondition> geojsonFeatureMatches(
    String pattern, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'geojsonFeature',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Parcela, Parcela, QAfterFilterCondition>
  geojsonFeatureIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'geojsonFeature', value: ''),
      );
    });
  }

  QueryBuilder<Parcela, Parcela, QAfterFilterCondition>
  geojsonFeatureIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'geojsonFeature', value: ''),
      );
    });
  }

  QueryBuilder<Parcela, Parcela, QAfterFilterCondition> idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'id', value: value),
      );
    });
  }

  QueryBuilder<Parcela, Parcela, QAfterFilterCondition> idGreaterThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'id',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<Parcela, Parcela, QAfterFilterCondition> idLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'id',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<Parcela, Parcela, QAfterFilterCondition> idBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'id',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<Parcela, Parcela, QAfterFilterCondition> observacionesEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'observaciones',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Parcela, Parcela, QAfterFilterCondition>
  observacionesGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'observaciones',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Parcela, Parcela, QAfterFilterCondition> observacionesLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'observaciones',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Parcela, Parcela, QAfterFilterCondition> observacionesBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'observaciones',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Parcela, Parcela, QAfterFilterCondition> observacionesStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'observaciones',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Parcela, Parcela, QAfterFilterCondition> observacionesEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'observaciones',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Parcela, Parcela, QAfterFilterCondition> observacionesContains(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'observaciones',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Parcela, Parcela, QAfterFilterCondition> observacionesMatches(
    String pattern, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'observaciones',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Parcela, Parcela, QAfterFilterCondition> observacionesIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'observaciones', value: ''),
      );
    });
  }

  QueryBuilder<Parcela, Parcela, QAfterFilterCondition>
  observacionesIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'observaciones', value: ''),
      );
    });
  }

  QueryBuilder<Parcela, Parcela, QAfterFilterCondition> parcelaIdEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'parcelaId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Parcela, Parcela, QAfterFilterCondition> parcelaIdGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'parcelaId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Parcela, Parcela, QAfterFilterCondition> parcelaIdLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'parcelaId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Parcela, Parcela, QAfterFilterCondition> parcelaIdBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'parcelaId',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Parcela, Parcela, QAfterFilterCondition> parcelaIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'parcelaId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Parcela, Parcela, QAfterFilterCondition> parcelaIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'parcelaId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Parcela, Parcela, QAfterFilterCondition> parcelaIdContains(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'parcelaId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Parcela, Parcela, QAfterFilterCondition> parcelaIdMatches(
    String pattern, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'parcelaId',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Parcela, Parcela, QAfterFilterCondition> parcelaIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'parcelaId', value: ''),
      );
    });
  }

  QueryBuilder<Parcela, Parcela, QAfterFilterCondition> parcelaIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'parcelaId', value: ''),
      );
    });
  }
}

extension ParcelaQueryObject
    on QueryBuilder<Parcela, Parcela, QFilterCondition> {}

extension ParcelaQueryLinks
    on QueryBuilder<Parcela, Parcela, QFilterCondition> {}

extension ParcelaQuerySortBy on QueryBuilder<Parcela, Parcela, QSortBy> {
  QueryBuilder<Parcela, Parcela, QAfterSortBy> sortByEstado() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'estado', Sort.asc);
    });
  }

  QueryBuilder<Parcela, Parcela, QAfterSortBy> sortByEstadoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'estado', Sort.desc);
    });
  }

  QueryBuilder<Parcela, Parcela, QAfterSortBy> sortByFechaEstado() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fechaEstado', Sort.asc);
    });
  }

  QueryBuilder<Parcela, Parcela, QAfterSortBy> sortByFechaEstadoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fechaEstado', Sort.desc);
    });
  }

  QueryBuilder<Parcela, Parcela, QAfterSortBy> sortByGeojsonFeature() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'geojsonFeature', Sort.asc);
    });
  }

  QueryBuilder<Parcela, Parcela, QAfterSortBy> sortByGeojsonFeatureDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'geojsonFeature', Sort.desc);
    });
  }

  QueryBuilder<Parcela, Parcela, QAfterSortBy> sortByObservaciones() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'observaciones', Sort.asc);
    });
  }

  QueryBuilder<Parcela, Parcela, QAfterSortBy> sortByObservacionesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'observaciones', Sort.desc);
    });
  }

  QueryBuilder<Parcela, Parcela, QAfterSortBy> sortByParcelaId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'parcelaId', Sort.asc);
    });
  }

  QueryBuilder<Parcela, Parcela, QAfterSortBy> sortByParcelaIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'parcelaId', Sort.desc);
    });
  }
}

extension ParcelaQuerySortThenBy
    on QueryBuilder<Parcela, Parcela, QSortThenBy> {
  QueryBuilder<Parcela, Parcela, QAfterSortBy> thenByEstado() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'estado', Sort.asc);
    });
  }

  QueryBuilder<Parcela, Parcela, QAfterSortBy> thenByEstadoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'estado', Sort.desc);
    });
  }

  QueryBuilder<Parcela, Parcela, QAfterSortBy> thenByFechaEstado() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fechaEstado', Sort.asc);
    });
  }

  QueryBuilder<Parcela, Parcela, QAfterSortBy> thenByFechaEstadoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fechaEstado', Sort.desc);
    });
  }

  QueryBuilder<Parcela, Parcela, QAfterSortBy> thenByGeojsonFeature() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'geojsonFeature', Sort.asc);
    });
  }

  QueryBuilder<Parcela, Parcela, QAfterSortBy> thenByGeojsonFeatureDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'geojsonFeature', Sort.desc);
    });
  }

  QueryBuilder<Parcela, Parcela, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<Parcela, Parcela, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<Parcela, Parcela, QAfterSortBy> thenByObservaciones() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'observaciones', Sort.asc);
    });
  }

  QueryBuilder<Parcela, Parcela, QAfterSortBy> thenByObservacionesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'observaciones', Sort.desc);
    });
  }

  QueryBuilder<Parcela, Parcela, QAfterSortBy> thenByParcelaId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'parcelaId', Sort.asc);
    });
  }

  QueryBuilder<Parcela, Parcela, QAfterSortBy> thenByParcelaIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'parcelaId', Sort.desc);
    });
  }
}

extension ParcelaQueryWhereDistinct
    on QueryBuilder<Parcela, Parcela, QDistinct> {
  QueryBuilder<Parcela, Parcela, QDistinct> distinctByEstado({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'estado', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Parcela, Parcela, QDistinct> distinctByFechaEstado() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'fechaEstado');
    });
  }

  QueryBuilder<Parcela, Parcela, QDistinct> distinctByFotos() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'fotos');
    });
  }

  QueryBuilder<Parcela, Parcela, QDistinct> distinctByGeojsonFeature({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(
        r'geojsonFeature',
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<Parcela, Parcela, QDistinct> distinctByObservaciones({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(
        r'observaciones',
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<Parcela, Parcela, QDistinct> distinctByParcelaId({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'parcelaId', caseSensitive: caseSensitive);
    });
  }
}

extension ParcelaQueryProperty
    on QueryBuilder<Parcela, Parcela, QQueryProperty> {
  QueryBuilder<Parcela, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<Parcela, String, QQueryOperations> estadoProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'estado');
    });
  }

  QueryBuilder<Parcela, DateTime, QQueryOperations> fechaEstadoProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'fechaEstado');
    });
  }

  QueryBuilder<Parcela, List<String>, QQueryOperations> fotosProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'fotos');
    });
  }

  QueryBuilder<Parcela, String, QQueryOperations> geojsonFeatureProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'geojsonFeature');
    });
  }

  QueryBuilder<Parcela, String, QQueryOperations> observacionesProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'observaciones');
    });
  }

  QueryBuilder<Parcela, String, QQueryOperations> parcelaIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'parcelaId');
    });
  }
}
