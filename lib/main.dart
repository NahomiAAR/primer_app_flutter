import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MyAppState(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const MyHomePage(title: 'Flutter Demo Home Page'),
      ),
    );
  }
}

class MyAppState extends ChangeNotifier {
  var current = WordPair.random();
  var favoritos = <WordPair>[];

  void cambiarPalabras() {
    current = WordPair.random();
    notifyListeners();
  }

  void toggleFavoritos() {
    if (favoritos.contains(current)) {
      favoritos.remove(current);
    } else {
      favoritos.add(current);
    }
    notifyListeners();
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    var idea = appState.current;
    IconData icon;
    if (appState.favoritos.contains(idea)) {
      icon = Icons.favorite;
    } else {
      icon = Icons.favorite_outline;
    }

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            BigCard(idea: appState.current),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton.icon(
                    onPressed: () {
                      appState.toggleFavoritos();
                    },
                    icon: Icon(icon),
                    label: Text("Me gusta")),
                SizedBox(
                  width: 10,
                ),
                ElevatedButton(
                    onPressed: () {
                      appState.cambiarPalabras();
                    },
                    child: Text("Cambiar Palabras")),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class BigCard extends StatelessWidget {
  final WordPair idea;
  const BigCard({super.key, required this.idea});

  @override
  Widget build(BuildContext context) {
    final tema = Theme.of(context);
    final textStyle = tema.textTheme.displayMedium!.copyWith(
      color: tema.colorScheme.onPrimary,
    );

    return Card(
      color: tema.colorScheme.primary,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Text(
          idea.asLowerCase,
          style: textStyle,
          semanticsLabel: "${idea.first} ${idea.second}",
        ),
      ),
    );
  }
}
