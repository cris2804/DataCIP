// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'configuracion.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetConfiguracionCollection on Isar {
  IsarCollection<Configuracion> get configuracions => this.collection();
}

const ConfiguracionSchema = CollectionSchema(
  name: r'Configuracion',
  id: 5910711714536764601,
  properties: {
    r'challhuaniJson': PropertySchema(
      id: 0,
      name: r'challhuaniJson',
      type: IsarType.string,
    ),
    r'pin': PropertySchema(id: 1, name: r'pin', type: IsarType.string),
    r'tambokarkaJson': PropertySchema(
      id: 2,
      name: r'tambokarkaJson',
      type: IsarType.string,
    ),
  },
  estimateSize: _configuracionEstimateSize,
  serialize: _configuracionSerialize,
  deserialize: _configuracionDeserialize,
  deserializeProp: _configuracionDeserializeProp,
  idName: r'isarId',
  indexes: {},
  links: {},
  embeddedSchemas: {},
  getId: _configuracionGetId,
  getLinks: _configuracionGetLinks,
  attach: _configuracionAttach,
  version: '3.1.0+1',
);

int _configuracionEstimateSize(
  Configuracion object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.challhuaniJson.length * 3;
  bytesCount += 3 + object.pin.length * 3;
  bytesCount += 3 + object.tambokarkaJson.length * 3;
  return bytesCount;
}

void _configuracionSerialize(
  Configuracion object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.challhuaniJson);
  writer.writeString(offsets[1], object.pin);
  writer.writeString(offsets[2], object.tambokarkaJson);
}

Configuracion _configuracionDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = Configuracion(
    challhuaniJson: reader.readString(offsets[0]),
    pin: reader.readStringOrNull(offsets[1]) ?? '1234',
    tambokarkaJson: reader.readString(offsets[2]),
  );
  object.isarId = id;
  return object;
}

P _configuracionDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readString(offset)) as P;
    case 1:
      return (reader.readStringOrNull(offset) ?? '1234') as P;
    case 2:
      return (reader.readString(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _configuracionGetId(Configuracion object) {
  return object.isarId;
}

List<IsarLinkBase<dynamic>> _configuracionGetLinks(Configuracion object) {
  return [];
}

void _configuracionAttach(
  IsarCollection<dynamic> col,
  Id id,
  Configuracion object,
) {
  object.isarId = id;
}

extension ConfiguracionQueryWhereSort
    on QueryBuilder<Configuracion, Configuracion, QWhere> {
  QueryBuilder<Configuracion, Configuracion, QAfterWhere> anyIsarId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension ConfiguracionQueryWhere
    on QueryBuilder<Configuracion, Configuracion, QWhereClause> {
  QueryBuilder<Configuracion, Configuracion, QAfterWhereClause> isarIdEqualTo(
    Id isarId,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.between(lower: isarId, upper: isarId),
      );
    });
  }

  QueryBuilder<Configuracion, Configuracion, QAfterWhereClause>
  isarIdNotEqualTo(Id isarId) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: isarId, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: isarId, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: isarId, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: isarId, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<Configuracion, Configuracion, QAfterWhereClause>
  isarIdGreaterThan(Id isarId, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: isarId, includeLower: include),
      );
    });
  }

  QueryBuilder<Configuracion, Configuracion, QAfterWhereClause> isarIdLessThan(
    Id isarId, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: isarId, includeUpper: include),
      );
    });
  }

  QueryBuilder<Configuracion, Configuracion, QAfterWhereClause> isarIdBetween(
    Id lowerIsarId,
    Id upperIsarId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.between(
          lower: lowerIsarId,
          includeLower: includeLower,
          upper: upperIsarId,
          includeUpper: includeUpper,
        ),
      );
    });
  }
}

extension ConfiguracionQueryFilter
    on QueryBuilder<Configuracion, Configuracion, QFilterCondition> {
  QueryBuilder<Configuracion, Configuracion, QAfterFilterCondition>
  challhuaniJsonEqualTo(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'challhuaniJson',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Configuracion, Configuracion, QAfterFilterCondition>
  challhuaniJsonGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'challhuaniJson',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Configuracion, Configuracion, QAfterFilterCondition>
  challhuaniJsonLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'challhuaniJson',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Configuracion, Configuracion, QAfterFilterCondition>
  challhuaniJsonBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'challhuaniJson',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Configuracion, Configuracion, QAfterFilterCondition>
  challhuaniJsonStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'challhuaniJson',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Configuracion, Configuracion, QAfterFilterCondition>
  challhuaniJsonEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'challhuaniJson',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Configuracion, Configuracion, QAfterFilterCondition>
  challhuaniJsonContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'challhuaniJson',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Configuracion, Configuracion, QAfterFilterCondition>
  challhuaniJsonMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'challhuaniJson',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Configuracion, Configuracion, QAfterFilterCondition>
  challhuaniJsonIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'challhuaniJson', value: ''),
      );
    });
  }

  QueryBuilder<Configuracion, Configuracion, QAfterFilterCondition>
  challhuaniJsonIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'challhuaniJson', value: ''),
      );
    });
  }

  QueryBuilder<Configuracion, Configuracion, QAfterFilterCondition>
  isarIdEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'isarId', value: value),
      );
    });
  }

  QueryBuilder<Configuracion, Configuracion, QAfterFilterCondition>
  isarIdGreaterThan(Id value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'isarId',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<Configuracion, Configuracion, QAfterFilterCondition>
  isarIdLessThan(Id value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'isarId',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<Configuracion, Configuracion, QAfterFilterCondition>
  isarIdBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'isarId',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<Configuracion, Configuracion, QAfterFilterCondition> pinEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'pin',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Configuracion, Configuracion, QAfterFilterCondition>
  pinGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'pin',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Configuracion, Configuracion, QAfterFilterCondition> pinLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'pin',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Configuracion, Configuracion, QAfterFilterCondition> pinBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'pin',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Configuracion, Configuracion, QAfterFilterCondition>
  pinStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'pin',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Configuracion, Configuracion, QAfterFilterCondition> pinEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'pin',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Configuracion, Configuracion, QAfterFilterCondition> pinContains(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'pin',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Configuracion, Configuracion, QAfterFilterCondition> pinMatches(
    String pattern, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'pin',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Configuracion, Configuracion, QAfterFilterCondition>
  pinIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'pin', value: ''),
      );
    });
  }

  QueryBuilder<Configuracion, Configuracion, QAfterFilterCondition>
  pinIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'pin', value: ''),
      );
    });
  }

  QueryBuilder<Configuracion, Configuracion, QAfterFilterCondition>
  tambokarkaJsonEqualTo(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'tambokarkaJson',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Configuracion, Configuracion, QAfterFilterCondition>
  tambokarkaJsonGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'tambokarkaJson',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Configuracion, Configuracion, QAfterFilterCondition>
  tambokarkaJsonLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'tambokarkaJson',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Configuracion, Configuracion, QAfterFilterCondition>
  tambokarkaJsonBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'tambokarkaJson',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Configuracion, Configuracion, QAfterFilterCondition>
  tambokarkaJsonStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'tambokarkaJson',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Configuracion, Configuracion, QAfterFilterCondition>
  tambokarkaJsonEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'tambokarkaJson',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Configuracion, Configuracion, QAfterFilterCondition>
  tambokarkaJsonContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'tambokarkaJson',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Configuracion, Configuracion, QAfterFilterCondition>
  tambokarkaJsonMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'tambokarkaJson',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Configuracion, Configuracion, QAfterFilterCondition>
  tambokarkaJsonIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'tambokarkaJson', value: ''),
      );
    });
  }

  QueryBuilder<Configuracion, Configuracion, QAfterFilterCondition>
  tambokarkaJsonIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'tambokarkaJson', value: ''),
      );
    });
  }
}

extension ConfiguracionQueryObject
    on QueryBuilder<Configuracion, Configuracion, QFilterCondition> {}

extension ConfiguracionQueryLinks
    on QueryBuilder<Configuracion, Configuracion, QFilterCondition> {}

extension ConfiguracionQuerySortBy
    on QueryBuilder<Configuracion, Configuracion, QSortBy> {
  QueryBuilder<Configuracion, Configuracion, QAfterSortBy>
  sortByChallhuaniJson() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'challhuaniJson', Sort.asc);
    });
  }

  QueryBuilder<Configuracion, Configuracion, QAfterSortBy>
  sortByChallhuaniJsonDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'challhuaniJson', Sort.desc);
    });
  }

  QueryBuilder<Configuracion, Configuracion, QAfterSortBy> sortByPin() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'pin', Sort.asc);
    });
  }

  QueryBuilder<Configuracion, Configuracion, QAfterSortBy> sortByPinDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'pin', Sort.desc);
    });
  }

  QueryBuilder<Configuracion, Configuracion, QAfterSortBy>
  sortByTambokarkaJson() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tambokarkaJson', Sort.asc);
    });
  }

  QueryBuilder<Configuracion, Configuracion, QAfterSortBy>
  sortByTambokarkaJsonDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tambokarkaJson', Sort.desc);
    });
  }
}

extension ConfiguracionQuerySortThenBy
    on QueryBuilder<Configuracion, Configuracion, QSortThenBy> {
  QueryBuilder<Configuracion, Configuracion, QAfterSortBy>
  thenByChallhuaniJson() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'challhuaniJson', Sort.asc);
    });
  }

  QueryBuilder<Configuracion, Configuracion, QAfterSortBy>
  thenByChallhuaniJsonDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'challhuaniJson', Sort.desc);
    });
  }

  QueryBuilder<Configuracion, Configuracion, QAfterSortBy> thenByIsarId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isarId', Sort.asc);
    });
  }

  QueryBuilder<Configuracion, Configuracion, QAfterSortBy> thenByIsarIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isarId', Sort.desc);
    });
  }

  QueryBuilder<Configuracion, Configuracion, QAfterSortBy> thenByPin() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'pin', Sort.asc);
    });
  }

  QueryBuilder<Configuracion, Configuracion, QAfterSortBy> thenByPinDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'pin', Sort.desc);
    });
  }

  QueryBuilder<Configuracion, Configuracion, QAfterSortBy>
  thenByTambokarkaJson() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tambokarkaJson', Sort.asc);
    });
  }

  QueryBuilder<Configuracion, Configuracion, QAfterSortBy>
  thenByTambokarkaJsonDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tambokarkaJson', Sort.desc);
    });
  }
}

extension ConfiguracionQueryWhereDistinct
    on QueryBuilder<Configuracion, Configuracion, QDistinct> {
  QueryBuilder<Configuracion, Configuracion, QDistinct>
  distinctByChallhuaniJson({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(
        r'challhuaniJson',
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<Configuracion, Configuracion, QDistinct> distinctByPin({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'pin', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Configuracion, Configuracion, QDistinct>
  distinctByTambokarkaJson({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(
        r'tambokarkaJson',
        caseSensitive: caseSensitive,
      );
    });
  }
}

extension ConfiguracionQueryProperty
    on QueryBuilder<Configuracion, Configuracion, QQueryProperty> {
  QueryBuilder<Configuracion, int, QQueryOperations> isarIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isarId');
    });
  }

  QueryBuilder<Configuracion, String, QQueryOperations>
  challhuaniJsonProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'challhuaniJson');
    });
  }

  QueryBuilder<Configuracion, String, QQueryOperations> pinProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'pin');
    });
  }

  QueryBuilder<Configuracion, String, QQueryOperations>
  tambokarkaJsonProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'tambokarkaJson');
    });
  }
}
