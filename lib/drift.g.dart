// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'drift.dart';

// ignore_for_file: type=lint
class $TarefasTable extends Tarefas with TableInfo<$TarefasTable, Tarefa> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TarefasTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _descricaoMeta =
      const VerificationMeta('descricao');
  @override
  late final GeneratedColumn<String> descricao = GeneratedColumn<String>(
      'descricao', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _concluidaMeta =
      const VerificationMeta('concluida');
  @override
  late final GeneratedColumn<bool> concluida = GeneratedColumn<bool>(
      'concluida', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("concluida" IN (0, 1))'));
  @override
  List<GeneratedColumn> get $columns => [id, descricao, concluida];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'tarefas';
  @override
  VerificationContext validateIntegrity(Insertable<Tarefa> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('descricao')) {
      context.handle(_descricaoMeta,
          descricao.isAcceptableOrUnknown(data['descricao']!, _descricaoMeta));
    } else if (isInserting) {
      context.missing(_descricaoMeta);
    }
    if (data.containsKey('concluida')) {
      context.handle(_concluidaMeta,
          concluida.isAcceptableOrUnknown(data['concluida']!, _concluidaMeta));
    } else if (isInserting) {
      context.missing(_concluidaMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Tarefa map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Tarefa(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      descricao: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}descricao'])!,
      concluida: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}concluida'])!,
    );
  }

  @override
  $TarefasTable createAlias(String alias) {
    return $TarefasTable(attachedDatabase, alias);
  }
}

class TarefasCompanion extends UpdateCompanion<Tarefa> {
  final Value<int> id;
  final Value<String> descricao;
  final Value<bool> concluida;
  const TarefasCompanion({
    this.id = const Value.absent(),
    this.descricao = const Value.absent(),
    this.concluida = const Value.absent(),
  });
  TarefasCompanion.insert({
    this.id = const Value.absent(),
    required String descricao,
    required bool concluida,
  })  : descricao = Value(descricao),
        concluida = Value(concluida);
  static Insertable<Tarefa> custom({
    Expression<int>? id,
    Expression<String>? descricao,
    Expression<bool>? concluida,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (descricao != null) 'descricao': descricao,
      if (concluida != null) 'concluida': concluida,
    });
  }

  TarefasCompanion copyWith(
      {Value<int>? id, Value<String>? descricao, Value<bool>? concluida}) {
    return TarefasCompanion(
      id: id ?? this.id,
      descricao: descricao ?? this.descricao,
      concluida: concluida ?? this.concluida,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (descricao.present) {
      map['descricao'] = Variable<String>(descricao.value);
    }
    if (concluida.present) {
      map['concluida'] = Variable<bool>(concluida.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TarefasCompanion(')
          ..write('id: $id, ')
          ..write('descricao: $descricao, ')
          ..write('concluida: $concluida')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  late final $TarefasTable tarefas = $TarefasTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [tarefas];
}
