// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'snapshot.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetSnapshotCollection on Isar {
  IsarCollection<Snapshot> get snapshots => this.collection();
}

const SnapshotSchema = CollectionSchema(
  name: r'Snapshot',
  id: 5414437197324958553,
  properties: {
    r'biomasaKg': PropertySchema(
      id: 0,
      name: r'biomasaKg',
      type: IsarType.double,
    ),
    r'cantidadParcelas': PropertySchema(
      id: 1,
      name: r'cantidadParcelas',
      type: IsarType.long,
    ),
    r'fecha': PropertySchema(id: 2, name: r'fecha', type: IsarType.dateTime),
    r'notas': PropertySchema(id: 3, name: r'notas', type: IsarType.string),
    r'vicunasAlimentadas': PropertySchema(
      id: 4,
      name: r'vicunasAlimentadas',
      type: IsarType.long,
    ),
    r'zona': PropertySchema(id: 5, name: r'zona', type: IsarType.string),
  },
  estimateSize: _snapshotEstimateSize,
  serialize: _snapshotSerialize,
  deserialize: _snapshotDeserialize,
  deserializeProp: _snapshotDeserializeProp,
  idName: r'id',
  indexes: {
    r'zona': IndexSchema(
      id: 5549824550384503466,
      name: r'zona',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'zona',
          type: IndexType.hash,
          caseSensitive: true,
        ),
      ],
    ),
  },
  links: {},
  embeddedSchemas: {},
  getId: _snapshotGetId,
  getLinks: _snapshotGetLinks,
  attach: _snapshotAttach,
  version: '3.1.0+1',
);

int _snapshotEstimateSize(
  Snapshot object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.notas.length * 3;
  bytesCount += 3 + object.zona.length * 3;
  return bytesCount;
}

void _snapshotSerialize(
  Snapshot object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeDouble(offsets[0], object.biomasaKg);
  writer.writeLong(offsets[1], object.cantidadParcelas);
  writer.writeDateTime(offsets[2], object.fecha);
  writer.writeString(offsets[3], object.notas);
  writer.writeLong(offsets[4], object.vicunasAlimentadas);
  writer.writeString(offsets[5], object.zona);
}

Snapshot _snapshotDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = Snapshot(
    biomasaKg: reader.readDouble(offsets[0]),
    cantidadParcelas: reader.readLong(offsets[1]),
    fecha: reader.readDateTime(offsets[2]),
    notas: reader.readStringOrNull(offsets[3]) ?? '',
    vicunasAlimentadas: reader.readLong(offsets[4]),
    zona: reader.readString(offsets[5]),
  );
  object.id = id;
  return object;
}

P _snapshotDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readDouble(offset)) as P;
    case 1:
      return (reader.readLong(offset)) as P;
    case 2:
      return (reader.readDateTime(offset)) as P;
    case 3:
      return (reader.readStringOrNull(offset) ?? '') as P;
    case 4:
      return (reader.readLong(offset)) as P;
    case 5:
      return (reader.readString(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _snapshotGetId(Snapshot object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _snapshotGetLinks(Snapshot object) {
  return [];
}

void _snapshotAttach(IsarCollection<dynamic> col, Id id, Snapshot object) {
  object.id = id;
}

extension SnapshotQueryWhereSort on QueryBuilder<Snapshot, Snapshot, QWhere> {
  QueryBuilder<Snapshot, Snapshot, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension SnapshotQueryWhere on QueryBuilder<Snapshot, Snapshot, QWhereClause> {
  QueryBuilder<Snapshot, Snapshot, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(lower: id, upper: id));
    });
  }

  QueryBuilder<Snapshot, Snapshot, QAfterWhereClause> idNotEqualTo(Id id) {
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

  QueryBuilder<Snapshot, Snapshot, QAfterWhereClause> idGreaterThan(
    Id id, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<Snapshot, Snapshot, QAfterWhereClause> idLessThan(
    Id id, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<Snapshot, Snapshot, QAfterWhereClause> idBetween(
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

  QueryBuilder<Snapshot, Snapshot, QAfterWhereClause> zonaEqualTo(String zona) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.equalTo(indexName: r'zona', value: [zona]),
      );
    });
  }

  QueryBuilder<Snapshot, Snapshot, QAfterWhereClause> zonaNotEqualTo(
    String zona,
  ) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'zona',
                lower: [],
                upper: [zona],
                includeUpper: false,
              ),
            )
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'zona',
                lower: [zona],
                includeLower: false,
                upper: [],
              ),
            );
      } else {
        return query
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'zona',
                lower: [zona],
                includeLower: false,
                upper: [],
              ),
            )
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'zona',
                lower: [],
                upper: [zona],
                includeUpper: false,
              ),
            );
      }
    });
  }
}

extension SnapshotQueryFilter
    on QueryBuilder<Snapshot, Snapshot, QFilterCondition> {
  QueryBuilder<Snapshot, Snapshot, QAfterFilterCondition> biomasaKgEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'biomasaKg',
          value: value,
          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<Snapshot, Snapshot, QAfterFilterCondition> biomasaKgGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'biomasaKg',
          value: value,
          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<Snapshot, Snapshot, QAfterFilterCondition> biomasaKgLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'biomasaKg',
          value: value,
          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<Snapshot, Snapshot, QAfterFilterCondition> biomasaKgBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'biomasaKg',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<Snapshot, Snapshot, QAfterFilterCondition>
  cantidadParcelasEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'cantidadParcelas', value: value),
      );
    });
  }

  QueryBuilder<Snapshot, Snapshot, QAfterFilterCondition>
  cantidadParcelasGreaterThan(int value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'cantidadParcelas',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<Snapshot, Snapshot, QAfterFilterCondition>
  cantidadParcelasLessThan(int value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'cantidadParcelas',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<Snapshot, Snapshot, QAfterFilterCondition>
  cantidadParcelasBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'cantidadParcelas',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<Snapshot, Snapshot, QAfterFilterCondition> fechaEqualTo(
    DateTime value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'fecha', value: value),
      );
    });
  }

  QueryBuilder<Snapshot, Snapshot, QAfterFilterCondition> fechaGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'fecha',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<Snapshot, Snapshot, QAfterFilterCondition> fechaLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'fecha',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<Snapshot, Snapshot, QAfterFilterCondition> fechaBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'fecha',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<Snapshot, Snapshot, QAfterFilterCondition> idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'id', value: value),
      );
    });
  }

  QueryBuilder<Snapshot, Snapshot, QAfterFilterCondition> idGreaterThan(
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

  QueryBuilder<Snapshot, Snapshot, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<Snapshot, Snapshot, QAfterFilterCondition> idBetween(
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

  QueryBuilder<Snapshot, Snapshot, QAfterFilterCondition> notasEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'notas',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Snapshot, Snapshot, QAfterFilterCondition> notasGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'notas',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Snapshot, Snapshot, QAfterFilterCondition> notasLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'notas',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Snapshot, Snapshot, QAfterFilterCondition> notasBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'notas',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Snapshot, Snapshot, QAfterFilterCondition> notasStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'notas',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Snapshot, Snapshot, QAfterFilterCondition> notasEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'notas',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Snapshot, Snapshot, QAfterFilterCondition> notasContains(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'notas',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Snapshot, Snapshot, QAfterFilterCondition> notasMatches(
    String pattern, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'notas',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Snapshot, Snapshot, QAfterFilterCondition> notasIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'notas', value: ''),
      );
    });
  }

  QueryBuilder<Snapshot, Snapshot, QAfterFilterCondition> notasIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'notas', value: ''),
      );
    });
  }

  QueryBuilder<Snapshot, Snapshot, QAfterFilterCondition>
  vicunasAlimentadasEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'vicunasAlimentadas', value: value),
      );
    });
  }

  QueryBuilder<Snapshot, Snapshot, QAfterFilterCondition>
  vicunasAlimentadasGreaterThan(int value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'vicunasAlimentadas',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<Snapshot, Snapshot, QAfterFilterCondition>
  vicunasAlimentadasLessThan(int value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'vicunasAlimentadas',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<Snapshot, Snapshot, QAfterFilterCondition>
  vicunasAlimentadasBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'vicunasAlimentadas',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<Snapshot, Snapshot, QAfterFilterCondition> zonaEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'zona',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Snapshot, Snapshot, QAfterFilterCondition> zonaGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'zona',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Snapshot, Snapshot, QAfterFilterCondition> zonaLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'zona',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Snapshot, Snapshot, QAfterFilterCondition> zonaBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'zona',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Snapshot, Snapshot, QAfterFilterCondition> zonaStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'zona',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Snapshot, Snapshot, QAfterFilterCondition> zonaEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'zona',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Snapshot, Snapshot, QAfterFilterCondition> zonaContains(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'zona',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Snapshot, Snapshot, QAfterFilterCondition> zonaMatches(
    String pattern, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'zona',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Snapshot, Snapshot, QAfterFilterCondition> zonaIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'zona', value: ''),
      );
    });
  }

  QueryBuilder<Snapshot, Snapshot, QAfterFilterCondition> zonaIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'zona', value: ''),
      );
    });
  }
}

extension SnapshotQueryObject
    on QueryBuilder<Snapshot, Snapshot, QFilterCondition> {}

extension SnapshotQueryLinks
    on QueryBuilder<Snapshot, Snapshot, QFilterCondition> {}

extension SnapshotQuerySortBy on QueryBuilder<Snapshot, Snapshot, QSortBy> {
  QueryBuilder<Snapshot, Snapshot, QAfterSortBy> sortByBiomasaKg() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'biomasaKg', Sort.asc);
    });
  }

  QueryBuilder<Snapshot, Snapshot, QAfterSortBy> sortByBiomasaKgDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'biomasaKg', Sort.desc);
    });
  }

  QueryBuilder<Snapshot, Snapshot, QAfterSortBy> sortByCantidadParcelas() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cantidadParcelas', Sort.asc);
    });
  }

  QueryBuilder<Snapshot, Snapshot, QAfterSortBy> sortByCantidadParcelasDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cantidadParcelas', Sort.desc);
    });
  }

  QueryBuilder<Snapshot, Snapshot, QAfterSortBy> sortByFecha() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fecha', Sort.asc);
    });
  }

  QueryBuilder<Snapshot, Snapshot, QAfterSortBy> sortByFechaDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fecha', Sort.desc);
    });
  }

  QueryBuilder<Snapshot, Snapshot, QAfterSortBy> sortByNotas() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'notas', Sort.asc);
    });
  }

  QueryBuilder<Snapshot, Snapshot, QAfterSortBy> sortByNotasDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'notas', Sort.desc);
    });
  }

  QueryBuilder<Snapshot, Snapshot, QAfterSortBy> sortByVicunasAlimentadas() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'vicunasAlimentadas', Sort.asc);
    });
  }

  QueryBuilder<Snapshot, Snapshot, QAfterSortBy>
  sortByVicunasAlimentadasDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'vicunasAlimentadas', Sort.desc);
    });
  }

  QueryBuilder<Snapshot, Snapshot, QAfterSortBy> sortByZona() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'zona', Sort.asc);
    });
  }

  QueryBuilder<Snapshot, Snapshot, QAfterSortBy> sortByZonaDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'zona', Sort.desc);
    });
  }
}

extension SnapshotQuerySortThenBy
    on QueryBuilder<Snapshot, Snapshot, QSortThenBy> {
  QueryBuilder<Snapshot, Snapshot, QAfterSortBy> thenByBiomasaKg() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'biomasaKg', Sort.asc);
    });
  }

  QueryBuilder<Snapshot, Snapshot, QAfterSortBy> thenByBiomasaKgDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'biomasaKg', Sort.desc);
    });
  }

  QueryBuilder<Snapshot, Snapshot, QAfterSortBy> thenByCantidadParcelas() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cantidadParcelas', Sort.asc);
    });
  }

  QueryBuilder<Snapshot, Snapshot, QAfterSortBy> thenByCantidadParcelasDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cantidadParcelas', Sort.desc);
    });
  }

  QueryBuilder<Snapshot, Snapshot, QAfterSortBy> thenByFecha() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fecha', Sort.asc);
    });
  }

  QueryBuilder<Snapshot, Snapshot, QAfterSortBy> thenByFechaDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fecha', Sort.desc);
    });
  }

  QueryBuilder<Snapshot, Snapshot, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<Snapshot, Snapshot, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<Snapshot, Snapshot, QAfterSortBy> thenByNotas() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'notas', Sort.asc);
    });
  }

  QueryBuilder<Snapshot, Snapshot, QAfterSortBy> thenByNotasDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'notas', Sort.desc);
    });
  }

  QueryBuilder<Snapshot, Snapshot, QAfterSortBy> thenByVicunasAlimentadas() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'vicunasAlimentadas', Sort.asc);
    });
  }

  QueryBuilder<Snapshot, Snapshot, QAfterSortBy>
  thenByVicunasAlimentadasDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'vicunasAlimentadas', Sort.desc);
    });
  }

  QueryBuilder<Snapshot, Snapshot, QAfterSortBy> thenByZona() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'zona', Sort.asc);
    });
  }

  QueryBuilder<Snapshot, Snapshot, QAfterSortBy> thenByZonaDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'zona', Sort.desc);
    });
  }
}

extension SnapshotQueryWhereDistinct
    on QueryBuilder<Snapshot, Snapshot, QDistinct> {
  QueryBuilder<Snapshot, Snapshot, QDistinct> distinctByBiomasaKg() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'biomasaKg');
    });
  }

  QueryBuilder<Snapshot, Snapshot, QDistinct> distinctByCantidadParcelas() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'cantidadParcelas');
    });
  }

  QueryBuilder<Snapshot, Snapshot, QDistinct> distinctByFecha() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'fecha');
    });
  }

  QueryBuilder<Snapshot, Snapshot, QDistinct> distinctByNotas({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'notas', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Snapshot, Snapshot, QDistinct> distinctByVicunasAlimentadas() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'vicunasAlimentadas');
    });
  }

  QueryBuilder<Snapshot, Snapshot, QDistinct> distinctByZona({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'zona', caseSensitive: caseSensitive);
    });
  }
}

extension SnapshotQueryProperty
    on QueryBuilder<Snapshot, Snapshot, QQueryProperty> {
  QueryBuilder<Snapshot, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<Snapshot, double, QQueryOperations> biomasaKgProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'biomasaKg');
    });
  }

  QueryBuilder<Snapshot, int, QQueryOperations> cantidadParcelasProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'cantidadParcelas');
    });
  }

  QueryBuilder<Snapshot, DateTime, QQueryOperations> fechaProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'fecha');
    });
  }

  QueryBuilder<Snapshot, String, QQueryOperations> notasProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'notas');
    });
  }

  QueryBuilder<Snapshot, int, QQueryOperations> vicunasAlimentadasProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'vicunasAlimentadas');
    });
  }

  QueryBuilder<Snapshot, String, QQueryOperations> zonaProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'zona');
    });
  }
}
