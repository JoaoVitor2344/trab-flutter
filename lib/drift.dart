import 'package:drift/drift.dart';
import 'package:drift/wasm.dart';

part 'drift.g.dart';

@UseRowClass(Tarefa)
class Tarefas extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get descricao => text()();
  BoolColumn get concluida => boolean()();
}

class Tarefa {
  final int id;
  final String descricao;
  bool concluida;

  Tarefa({required this.id, required this.descricao, required this.concluida});
}

@DriftDatabase(tables: [Tarefas])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  Future<List<Tarefa>> pegarTodasTarefas() => select(tarefas).get();
  Future<int> inserirTarefa(TarefasCompanion tarefa) =>
      into(tarefas).insert(tarefa);
  Future atualizarTarefa(TarefasCompanion tarefa) =>
      update(tarefas).replace(tarefa);
  Future deletarTarefa(TarefasCompanion tarefa) =>
      delete(tarefas).delete(tarefa);
}

DatabaseConnection _openConnection() {
  return DatabaseConnection.delayed(Future(() async {
    final db = await WasmDatabase.open(
      databaseName: 'lista_tarefas',
      sqlite3Uri: Uri.parse('sqlite3.wasm'),
      driftWorkerUri: Uri.parse('drift_worker.dart.js'),
    );

    if (db.missingFeatures.isNotEmpty) {
      print('error - missing features');
    }

    return db.resolvedExecutor;
  }));
}
