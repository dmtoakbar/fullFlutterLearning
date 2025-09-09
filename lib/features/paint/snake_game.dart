import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';


class SnakeGamePage extends StatefulWidget {
  const SnakeGamePage({super.key});
  @override
  State<SnakeGamePage> createState() => _SnakeGamePageState();
}

enum Direction { up, down, left, right }

class _SnakeGamePageState extends State<SnakeGamePage> {
  /// Grid size (portrait-friendly). Adjust to taste.
  static const int rows = 24;
  static const int cols = 16;

  final Random _rng = Random();
  late List<Point<int>> _snake;
  late Direction _dir;
  late Point<int> _food;

  bool _running = false;
  bool _gameOver = false;
  int _score = 0;
  int _speedMs = 160; // lower = faster
  Timer? _loop;

  @override
  void initState() {
    super.initState();
    _reset();
  }

  @override
  void dispose() {
    _loop?.cancel();
    super.dispose();
  }

  void _reset() {
    final start = Point<int>(cols ~/ 2, rows ~/ 2);
    _snake = [start, Point(start.x - 1, start.y), Point(start.x - 2, start.y)];
    _dir = Direction.right;
    _food = _randomFreeCell();
    _running = false;
    _gameOver = false;
    _score = 0;
    _speedMs = 160;
    _loop?.cancel();
    setState(() {});
  }

  void _start() {
    if (_running) return;
    _running = true;
    _loop = Timer.periodic(Duration(milliseconds: _speedMs), (_) => _tick());
    setState(() {});
  }

  void _pause() {
    _running = false;
    _loop?.cancel();
    setState(() {});
  }

  void _restart() {
    _reset();
    _start();
  }

  void _tick() {
    if (_gameOver) return;

    final head = _snake.first;
    final next = _nextPoint(head, _dir);

    // Wall collision
    if (next.x < 0 || next.x >= cols || next.y < 0 || next.y >= rows) {
      _endGame();
      return;
    }

    // Self collision
    if (_snake.contains(next)) {
      _endGame();
      return;
    }

    // Move
    _snake.insert(0, next);

    // Eat?
    if (next == _food) {
      _score += 10;
      // speed up a bit every few points
      if (_score % 40 == 0 && _speedMs > 70) {
        _speedMs -= 10;
        _loop?.cancel();
        _loop = Timer.periodic(Duration(milliseconds: _speedMs), (_) => _tick());
      }
      _food = _randomFreeCell();
    } else {
      _snake.removeLast();
    }

    setState(() {});
  }

  void _endGame() {
    _gameOver = true;
    _running = false;
    _loop?.cancel();
    setState(() {});
  }

  Point<int> _nextPoint(Point<int> p, Direction d) {
    switch (d) {
      case Direction.up:
        return Point(p.x, p.y - 1);
      case Direction.down:
        return Point(p.x, p.y + 1);
      case Direction.left:
        return Point(p.x - 1, p.y);
      case Direction.right:
        return Point(p.x + 1, p.y);
    }
  }

  Point<int> _randomFreeCell() {
    late Point<int> cell;
    do {
      cell = Point(_rng.nextInt(cols), _rng.nextInt(rows));
    } while (_snake.contains(cell));
    return cell;
  }

  void _changeDirection(Direction d) {
    // Disallow 180° turns
    final isOpposite =
        (_dir == Direction.up && d == Direction.down) ||
            (_dir == Direction.down && d == Direction.up) ||
            (_dir == Direction.left && d == Direction.right) ||
            (_dir == Direction.right && d == Direction.left);
    if (!isOpposite) {
      _dir = d;
      setState(() {});
    }
  }

  // Basic swipe detection
  Offset? _startDrag;
  void _onPanStart(DragStartDetails d) => _startDrag = d.localPosition;
  void _onPanEnd(DragEndDetails d) => _startDrag = null;
  void _onPanUpdate(DragUpdateDetails d) {
    if (_startDrag == null) return;
    final delta = d.localPosition - _startDrag!;
    if (delta.distance < 12) return; // small threshold
    if (delta.dx.abs() > delta.dy.abs()) {
      _changeDirection(delta.dx > 0 ? Direction.right : Direction.left);
    } else {
      _changeDirection(delta.dy > 0 ? Direction.down : Direction.up);
    }
    _startDrag = d.localPosition; // allow continuous swipes
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
              child: Row(
                children: [
                  Text('Snake', style: Theme.of(context).textTheme.headlineSmall),
                  const Spacer(),
                  _Badge(label: 'Score', value: '$_score'),
                  const SizedBox(width: 8),
                  _Badge(label: 'Speed', value: '${(1000 / _speedMs).toStringAsFixed(1)} t/s'),
                ],
              ),
            ),
            Expanded(
              child: LayoutBuilder(
                builder: (context, constraints) {
                  return Center(
                    child: AspectRatio(
                      aspectRatio: cols / rows,
                      child: GestureDetector(
                        onTap: _running ? _pause : _start,
                        onPanStart: _onPanStart,
                        onPanEnd: _onPanEnd,
                        onPanUpdate: _onPanUpdate,
                        child: CustomPaint(
                          painter: SnakePainter(
                            rows: rows,
                            cols: cols,
                            snake: _snake,
                            food: _food,
                            gameOver: _gameOver,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  FilledButton.icon(
                    onPressed: _running ? _pause : _start,
                    icon: Icon(_running ? Icons.pause : Icons.play_arrow),
                    label: Text(_running ? 'Pause' : 'Play'),
                  ),
                  FilledButton.icon(
                    onPressed: _restart,
                    icon: const Icon(Icons.replay),
                    label: const Text('Restart'),
                  ),
                  SegmentedButton<Direction>(
                    segments: const [
                      ButtonSegment(value: Direction.up, icon: Icon(Icons.keyboard_arrow_up)),
                      ButtonSegment(value: Direction.left, icon: Icon(Icons.keyboard_arrow_left)),
                      ButtonSegment(value: Direction.down, icon: Icon(Icons.keyboard_arrow_down)),
                      ButtonSegment(value: Direction.right, icon: Icon(Icons.keyboard_arrow_right)),
                    ],
                    selected: {_dir},
                    showSelectedIcon: false,
                    onSelectionChanged: (s) => _changeDirection(s.first),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class SnakePainter extends CustomPainter {
  SnakePainter({
    required this.rows,
    required this.cols,
    required this.snake,
    required this.food,
    required this.gameOver,
  });

  final int rows;
  final int cols;
  final List<Point<int>> snake;
  final Point<int> food;
  final bool gameOver;

  @override
  void paint(Canvas canvas, Size size) {
    final cell = min(size.width / cols, size.height / rows);
    final boardW = cell * cols;
    final boardH = cell * rows;
    final dx = (size.width - boardW) / 2;
    final dy = (size.height - boardH) / 2;
    final boardRect = Rect.fromLTWH(dx, dy, boardW, boardH);

    // Background
    final bg = Paint()..color = const Color(0xFF0E0F12);
    final border = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2
      ..color = const Color(0xFF2A2D34);
    canvas.drawRRect(RRect.fromRectAndRadius(boardRect, const Radius.circular(16)), bg);
    canvas.drawRRect(RRect.fromRectAndRadius(boardRect, const Radius.circular(16)), border);

    // Subtle grid
    final grid = Paint()
      ..color = const Color(0xFF1B1E24)
      ..strokeWidth = 1;
    for (int c = 1; c < cols; c++) {
      final x = dx + c * cell;
      canvas.drawLine(Offset(x, dy), Offset(x, dy + boardH), grid);
    }
    for (int r = 1; r < rows; r++) {
      final y = dy + r * cell;
      canvas.drawLine(Offset(dx, y), Offset(dx + boardW, y), grid);
    }

    // Food
    final foodPaint = Paint()..color = const Color(0xFFE74C3C);
    _drawCell(canvas, dx, dy, cell, food, foodPaint, radius: cell * 0.2);

    // Snake
    final headPaint = Paint()..color = const Color(0xFF58D68D);
    final bodyPaint = Paint()..color = const Color(0xFF27AE60);

    for (int i = 0; i < snake.length; i++) {
      final p = snake[i];
      final paint = i == 0 ? headPaint : bodyPaint;
      _drawCell(canvas, dx, dy, cell, p, paint, radius: cell * 0.28);
    }

    if (gameOver) {
      _drawOverlay(canvas, boardRect, 'Game Over', 'Tap Restart');
    }
  }

  void _drawCell(Canvas canvas, double dx, double dy, double cell, Point<int> p, Paint paint, {double radius = 0}) {
    final rect = Rect.fromLTWH(dx + p.x * cell, dy + p.y * cell, cell, cell);
    if (radius > 0) {
      canvas.drawRRect(RRect.fromRectAndRadius(rect.deflate(cell * 0.08), Radius.circular(radius)), paint);
    } else {
      canvas.drawRect(rect.deflate(cell * 0.08), paint);
    }
  }

  void _drawOverlay(Canvas canvas, Rect rect, String title, String subtitle) {
    final overlay = Paint()..color = Colors.black.withOpacity(0.45);
    canvas.drawRRect(RRect.fromRectAndRadius(rect, const Radius.circular(16)), overlay);

    // Text painters
    final tp1 = TextPainter(
      text: TextSpan(
        text: '$title\n',
        style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.white),
        children: [
          TextSpan(
            text: subtitle,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: Colors.white70),
          ),
        ],
      ),
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
    )..layout(maxWidth: rect.width * 0.8);

    final offset = Offset(rect.center.dx - tp1.width / 2, rect.center.dy - tp1.height / 2);
    tp1.paint(canvas, offset);
  }

  @override
  bool shouldRepaint(covariant SnakePainter old) {
    return old.snake != snake || old.food != food || old.gameOver != gameOver || old.rows != rows || old.cols != cols;
  }
}

class _Badge extends StatelessWidget {
  const _Badge({required this.label, required this.value});
  final String label;
  final String value;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: const Color(0xFF1B1E24),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFF2A2D34)),
      ),
      child: Row(
        children: [
          Text(label, style: const TextStyle(color: Colors.white70)),
          const SizedBox(width: 6),
          Text(value, style: const TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}
