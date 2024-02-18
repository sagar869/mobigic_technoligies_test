import 'package:flutter/material.dart';

class AlphabetsSearchsPage extends StatefulWidget {
  final int m;
  final int n;

  const AlphabetsSearchsPage({super.key, required this.m, required this.n});

  @override
  State<AlphabetsSearchsPage> createState() => _AlphabetsSearchsPageState();
}

class _AlphabetsSearchsPageState extends State<AlphabetsSearchsPage> {
  late List<List<String>> grid = [];
  String searchResult = "";
  bool isWordFound = false;
  late List<List<bool>> highlightGrid;

  @override
  void initState() {
    super.initState();
    highlightGrid =
        List.generate(widget.m, (i) => List.generate(widget.n, (j) => false));
    grid.addAll(List.generate(
        widget.m,
        (i) => List.generate(widget.n,
            (j) => String.fromCharCode('A'.codeUnitAt(0) + i * widget.n + j))));
  }

  void search(String query) {
    setState(() {
      highlightGrid =
          List.generate(widget.m, (i) => List.generate(widget.n, (j) => false));
      isWordFound = false;
      searchResult = "";
    });

    for (int i = 0; i < widget.m; i++) {
      for (int j = 0; j < widget.n; j++) {
        if (grid[i][j].toLowerCase() == query[0].toLowerCase()) {
          // Check horizontally
          if (_checkWord(query, grid, i, j, 0, 1)) {
            _highlightWord(query, grid, i, j, 0, 1);
            isWordFound = true;
            searchResult = "Found word horizontally";
            break;
          }

          // Check vertically
          if (_checkWord(query, grid, i, j, 1, 0)) {
            _highlightWord(query, grid, i, j, 1, 0);
            isWordFound = true;
            searchResult = "Found word vertically";
            break;
          }

          // Check diagonally
          if (_checkWord(query, grid, i, j, 1, 1)) {
            _highlightWord(query, grid, i, j, 1, 1);
            isWordFound = true;
            searchResult = "Found word diagonally";
            break;
          }
        }
      }
    }
    if (!isWordFound) {
      searchResult = "Word not found";
    }
  }

  bool _checkWord(
      String word, List<List<String>> grid, int x, int y, int dx, int dy) {
    for (int i = 1; i < word.length; i++) {
      int newX = x + i * dx;
      int newY = y + i * dy;
      if (newX < 0 ||
          newX >= widget.m ||
          newY < 0 ||
          newY >= widget.n ||
          grid[newX][newY].toLowerCase() != word[i].toLowerCase()) {
        return false;
      }
    }
    return true;
  }

  void _highlightWord(
      String word, List<List<String>> grid, int x, int y, int dx, int dy) {
    debugPrint("match found: [$x, $y]");
    for (int i = 0; i < word.length; i++) {
      highlightGrid[x + i * dx][y + i * dy] = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search the Alphbets'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              onChanged: (query) {
                search(query);
              },
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
                hintText: 'Enter text to search',
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              width: double.infinity,
              child: Text(
                searchResult,
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const Text("Click on Grid View text to change that text"),
            Expanded(
              child: highlightGrid.isEmpty
                  ? const Center(child: CircularProgressIndicator())
                  : GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: widget.n,
                      ),
                      itemCount: widget.m * widget.n,
                      itemBuilder: (context, index) {
                        int rowIndex = index ~/ widget.n;
                        int colIndex = index % widget.n;
                        return Container(
                          decoration: BoxDecoration(
                            border: Border.all(),
                            color: highlightGrid[rowIndex][colIndex]
                                ? Colors.yellow
                                : Colors.white,
                          ),
                          child: Center(
                            child: TextField(
                              onChanged: (s) {
                                grid[rowIndex][colIndex] = s;
                              },
                              decoration: InputDecoration(
                                alignLabelWithHint: true,
                                border: InputBorder.none,
                                hintText: grid[rowIndex][colIndex],
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
