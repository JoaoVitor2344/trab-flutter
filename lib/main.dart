import 'package:flutter/material.dart';
import 'package:drift/drift.dart' hide Column;
import 'drift.dart';

void main() {
  runApp(const ListaDeTarefasApp());
}

class ListaDeTarefasApp extends StatelessWidget {
  const ListaDeTarefasApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lista de Tarefas App',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const TelaInicial(),
    );
  }
}

class TelaInicial extends StatelessWidget {
  const TelaInicial({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('tela inicial'),
        ),
        body: Center(
          child: ElevatedButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const ListaDeTarefasScreen(),
              ));
            },
            child: const Text('Iniciar uma lista de tarefas'),
          ),
        ));
  }
}

class ListaDeTarefasScreen extends StatefulWidget {
  const ListaDeTarefasScreen({super.key});

  @override
  ListaDeTarefasScreenState createState() => ListaDeTarefasScreenState();
}

class ListaDeTarefasScreenState extends State<ListaDeTarefasScreen> {
  final List<Tarefa> _tarefas = [];
  final TextEditingController _controller = TextEditingController();
  final database = AppDatabase();

  @override
  void initState() {
    super.initState();
    _carregarTarefas();
  }

  Future<void> _carregarTarefas() async {
    await database.pegarTodasTarefas().then((tarefas) {
      setState(
        () {
          _tarefas.clear();
          _tarefas.addAll(tarefas);
        },
      );
    });
  }

  Future<void> _adicionarTarefa(String descricao) async {
    final novaTarefa = TarefasCompanion.insert(
      descricao: descricao,
      concluida: false,
    );

    await database.inserirTarefa(novaTarefa).then((_) => _carregarTarefas());
    _controller.clear();
  }

  Future<void> _removerTarefa(Tarefa tarefa) async {
    await database
        .deletarTarefa(
          TarefasCompanion(
            id: Value(tarefa.id),
            descricao: Value(tarefa.descricao),
            concluida: Value(tarefa.concluida),
          ),
        )
        .then((_) => _carregarTarefas());
  }

  Future<void> _atualizarTarefa(Tarefa tarefa) async {
    final tarefaAlterada = TarefasCompanion(
      id: Value(tarefa.id),
      descricao: Value(tarefa.descricao),
      concluida: Value(tarefa.concluida),
    );
    await database
        .atualizarTarefa(tarefaAlterada)
        .then((_) => _carregarTarefas());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Lista de Tarefas')),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _tarefas.length,
              itemBuilder: (context, index) {
                return ListTile(
                    title: Text(_tarefas[index].descricao),
                    leading: Checkbox(
                      value: _tarefas[index].concluida,
                      onChanged: (bool? newValue) {
                        setState(() {
                          _tarefas[index].concluida = newValue ?? false;
                          _atualizarTarefa(_tarefas[index]);
                        });
                      },
                    ),
                    trailing: IconButton(
                        onPressed: () {
                          _removerTarefa(_tarefas[index]);
                        },
                        icon: const Icon(Icons.delete)));
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    onSubmitted: (descricao) {
                      _adicionarTarefa(descricao);
                    },
                    decoration: const InputDecoration(
                      hintText: 'Adicionar Tarefa',
                    ),
                  ),
                ),
                ElevatedButton(
                  child: const Text('Adicionar'),
                  onPressed: () {
                    if (_controller.text.isNotEmpty) {
                      _adicionarTarefa(_controller.text);
                    }
                  },
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    database.close();
    super.dispose();
  }
}
