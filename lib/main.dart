import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MyAppState(),
      child: MaterialApp(
        title: '我的第一个flutter应用',
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.lightBlueAccent),
        ),
        home: MyHomePage(),
      ),
    );
  }
}

class MyAppState extends ChangeNotifier {
  var current = WordPair.random();
  var history = <WordPair>[]; // 历史记录

  // 用于在 HistoryListView 中显示历史记录
  GlobalKey? historyListKey;

  void getNext() {
    history.insert(0, current);
    var animatedList = historyListKey?.currentState as AnimatedListState?;
    animatedList?.insertItem(0);
    current = WordPair.random();
    notifyListeners();
  }

  var favorites = <WordPair>[];

  // 切换是否收藏该单词
  void toggleFavorite([WordPair? pair]) {
    pair = pair ?? current;
    if (favorites.contains(pair)) {
      favorites.remove(pair);
    } else {
      favorites.add(pair);
    }
    notifyListeners();
  }

  // 删除单词
  void removeFavorite(WordPair pair) {
    favorites.remove(pair);
    notifyListeners();
  }
}

// ...

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    Widget page;
    switch (selectedIndex) {
      case 0:
        page = GeneratorPage();
        break;
      case 1:
        page = FavoritesPage();
        break;
      case 2:
        page = LearnWidget();
        break;
      case 3:
        page = LearnLayout();
        break;
      case 4:
        page = LearnListView();
        break;
      case 5:
        page = LearnStack();
        break;
      case 6:
        page = LearnMediaQuery();
        break;
      default:
        throw UnimplementedError('no widget for $selectedIndex');
    }

    return LayoutBuilder(builder: (context, constraints) {
      return Scaffold(
        body: Row(
          children: [
            SafeArea(
              child: NavigationRail(
                extended: constraints.maxWidth >= 600,
                destinations: [
                  NavigationRailDestination(
                    icon: Icon(Icons.home),
                    label: Text('Home'),
                  ),
                  NavigationRailDestination(
                    icon: Icon(Icons.favorite),
                    label: Text('Favorites'),
                  ),
                  NavigationRailDestination(
                    icon: Icon(Icons.book),
                    label: Text('LearnWidget'),
                  ),
                  NavigationRailDestination(
                    icon: Icon(Icons.room),
                    label: Text('layout'),
                  ),
                  NavigationRailDestination(
                    icon: Icon(Icons.list),
                    label: Text('ListView'),
                  ),
                  NavigationRailDestination(
                    icon: Icon(Icons.stacked_bar_chart),
                    label: Text('Stack'),
                  ),
                  NavigationRailDestination(
                    icon: Icon(Icons.devices_outlined),
                    label: Text('MediaQuery'),
                  ),
                ],
                selectedIndex: selectedIndex,
                onDestinationSelected: (value) {
                  setState(() {
                    selectedIndex = value;
                  });
                },
              ),
            ),
            Expanded(
              child: Container(
                color: Theme.of(context).colorScheme.primaryContainer,
                child: page,
              ),
            ),
          ],
        ),
      );
    });
  }
}

// 获取当前屏幕信息
class LearnMediaQuery extends StatelessWidget {
  const LearnMediaQuery({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('屏幕宽度:'),
            const SizedBox(width: 10),
            Text(
              MediaQuery.of(context).size.width.toString(),
              style: TextStyle(fontSize: 20, color: Colors.green),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('屏幕高度:'),
            const SizedBox(width: 10),
            Text(
              MediaQuery.of(context).size.height.toString(),
              style: TextStyle(fontSize: 20, color: Colors.green),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('屏幕方向:'),
            const SizedBox(width: 10),
            Text(
              MediaQuery.of(context).orientation == Orientation.portrait
                  ? '竖屏'
                  : '横屏',
              style: TextStyle(fontSize: 20, color: Colors.green),
            ),
          ],
        ),
      ],
    );
  }
}

// 元素定位相关布局
class LearnStack extends StatelessWidget {
  const LearnStack({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          width: 200,
          height: 200,
          color: Colors.red,
        ),
        Positioned(
          top: 20,
          left: 20,
          child: Container(
            width: 100,
            height: 100,
            color: Colors.green,
          ),
        ),
        Positioned(
          top: 20,
          left: 20,
          child: Container(
            width: 50,
            height: 50,
            color: Colors.blue,
          ),
        ),
      ],
    );
  }
}

// 长列表
class LearnListView extends StatelessWidget {
  const LearnListView({
    super.key,
  });

  final List<ToDo> items = const [
    ToDo('学习Flutter', true),
    ToDo('学习Dart', false),
    ToDo('学习Provider', true),
    ToDo('学习State Management', false),
    ToDo('学习ListView', true),
    ToDo('学习Layout', false),
    ToDo('学习Layout', false),
    ToDo('学习Layout', false),
    ToDo('学习Layout', false),
    ToDo('学习Layout', false),
    ToDo('学习Layout', false),
    ToDo('学习Layout', false),
    ToDo('学习Layout', false),
    ToDo('学习Layout', false),
    ToDo('学习Layout', false),
    ToDo('学习Layout', false),
    ToDo('学习Layout', false),
    ToDo('学习Layout', false),
    ToDo('学习Layout', false),
    ToDo('学习Layout', false),
  ];
  @override
  Widget build(BuildContext context) {
    // ListView当列表项数量未知或非常多（或无限）时，通常会使用
    // return ListView(
    //   children: const [
    //     TestColumn(),
    //     TestColumn(),
    //     TestColumn(),
    //     TestColumn(),
    //     TestColumn(),
    //     TestColumn()
    //   ],
    // );
    // 最好使用ListView.builder构造函数。构建器构造函数只会构建当前屏幕上可见的子项。
    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (context, index) {
        var item = items[index];
        return Container(
          color: index % 2 == 0 ? Colors.green[100] : Colors.red[100],
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(item.title),
              Text(item.completed ? '✅' : '❌'),
            ],
          ),
        );
      },
    );
  }
}

class ToDo {
  final String title;
  final bool completed;

  const ToDo(
    this.title,
    this.completed,
  );
}

// 行 列 相关布局
class LearnLayout extends StatelessWidget {
  const LearnLayout({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        // 可以使用 Expanded 包裹。修复行过宽导致渲染框无法容纳的问题
        Expanded(
          child: TestColumn(),
        ),
        Expanded(
          // 弹性系数设置为 2
          flex: 2,
          child: TestColumn(),
        ),
        Expanded(
          child: TestColumn(),
        ),
      ],
    );
  }
}

class TestColumn extends StatelessWidget {
  const TestColumn({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 100,
          height: 100,
          color: Colors.red,
        ),
        Text('')
      ],
    );
  }
}

// 初识widget
class LearnWidget extends StatelessWidget {
  const LearnWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: const Text('My Home Page')),
      ),
      body: Center(
        child: Builder(
          builder: (context) {
            return Column(
              children: [
                const Text('Hello, World!'),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    print('Click!');
                  },
                  child: const Text('A button'),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class GeneratorPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    var pair = appState.current;

    IconData icon;
    if (appState.favorites.contains(pair)) {
      icon = Icons.favorite;
    } else {
      icon = Icons.favorite_border;
    }

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            flex: 3,
            child: HistoryListView(),
          ),
          SizedBox(height: 10),
          BigCard(pair: pair),
          SizedBox(height: 10),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              ElevatedButton.icon(
                onPressed: () {
                  appState.toggleFavorite();
                },
                icon: Icon(icon),
                label: Text('Like'),
              ),
              SizedBox(width: 10),
              ElevatedButton(
                onPressed: () {
                  appState.getNext();
                },
                child: Text('Next'),
              ),
            ],
          ),
          Spacer(flex: 2),
        ],
      ),
    );
  }
}

class HistoryListView extends StatefulWidget {
  @override
  State<HistoryListView> createState() => _HistoryListViewState();
}

// 历史记录单词的组件
class _HistoryListViewState extends State<HistoryListView> {
  final _key = GlobalKey();
  // 线性过渡
  static const _maskingGradient = LinearGradient(
    colors: [
      Colors.transparent,
      Colors.black,
    ],
    stops: [0.0, 0.5],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  @override
  Widget build(BuildContext context) {
    final appState = context.watch<MyAppState>();
    appState.historyListKey = _key;

    return ShaderMask(
        shaderCallback: (bounds) => _maskingGradient.createShader(bounds),
        blendMode: BlendMode.dstIn,
        child: AnimatedList(
          key: _key,
          reverse: true,
          padding: EdgeInsets.only(top: 100),
          initialItemCount: appState.history.length,
          itemBuilder: (context, index, animation) {
            final pair = appState.history[index];
            return SizeTransition(
              sizeFactor: animation,
              child: Center(
                child: TextButton.icon(
                    onPressed: () {
                      appState.toggleFavorite(pair);
                    },
                    icon: appState.favorites.contains(pair)
                        ? Icon(Icons.favorite, size: 12)
                        : SizedBox(),
                    label: Text(
                      pair.asLowerCase,
                      semanticsLabel: pair.asPascalCase,
                    )),
              ),
            );
          },
        ));
  }
}

// ...

class BigCard extends StatelessWidget {
  const BigCard({
    super.key,
    required this.pair,
  });

  final WordPair pair;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final style = theme.textTheme.displayMedium!.copyWith(
      color: theme.colorScheme.onPrimary,
    );
    return Card(
      color: theme.colorScheme.primary,
      child: Padding(
        padding: const EdgeInsets.all(20),
        // 调整单词盒子的样式和过渡
        // child: Text(pair.asLowerCase,
        //     style: style, semanticsLabel: "${pair.first} ${pair.second}"),
        child: AnimatedSize(
            duration: Duration(milliseconds: 200),
            child: MergeSemantics(
              child: Wrap(
                children: [
                  Text(
                    pair.first,
                    style: style.copyWith(fontWeight: FontWeight.w200),
                  ),
                  Text(
                    pair.second,
                    style: style.copyWith(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            )),
      ),
    );
  }
}

// 收藏页面
class FavoritesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    var theme = Theme.of(context);
    if (appState.favorites.isEmpty) {
      return Center(
        child: Text('No favorites yet.'),
      );
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(30),
          child: Text('You have '
              '${appState.favorites.length} favorites:'),
        ),
        Expanded(
          // grid 布局
          child: GridView(
            gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 400, childAspectRatio: 400 / 80),
            children: [
              for (var pair in appState.favorites)
                ListTile(
                  leading: IconButton(
                    icon: Icon(Icons.delete_outline, semanticLabel: 'Delete'),
                    color: theme.colorScheme.primary,
                    onPressed: () {
                      appState.removeFavorite(pair);
                    },
                  ),
                  title:
                      Text(pair.asLowerCase, semanticsLabel: pair.asPascalCase),
                ),
            ],
          ),
        ),
      ],
    );
    // return ListView(
    //   children: [
    //     Padding(
    //       padding: const EdgeInsets.all(20),
    //       child: Text('You have '
    //           '${appState.favorites.length} favorites:'),
    //     ),
    //     for (var pair in appState.favorites)
    //       ListTile(
    //         leading: Icon(Icons.favorite),
    //         title: Text(pair.asLowerCase),
    //       ),
    //   ],
    // );
  }
}
