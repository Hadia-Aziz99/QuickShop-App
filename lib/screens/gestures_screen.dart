import 'package:flutter/material.dart';

/// Requirement 5: Gestures, Requirement 6: Animated Widgets, Requirement 7: Counter
class GesturesScreen extends StatefulWidget {
  const GesturesScreen({super.key});

  @override
  State<GesturesScreen> createState() => _GesturesScreenState();
}

class _GesturesScreenState extends State<GesturesScreen> {
  String _log = 'Interact with any gesture tile below';
  int _taps = 0, _doubleTaps = 0, _longPresses = 0;
  String _drag = 'None';
  bool _expanded = false, _showVoucher = true;
  int _counter = 0;

  // List of gradient pairs for each gesture tile
  final List<List<Color>> _tileGradients = [
    [Color(0xFF7C3AED), Color(0xFF4C1D95)], // Purple
    [Color(0xFFEC4899), Color(0xFFBE185D)], // Pink
    [Color(0xFF0EA5E9), Color(0xFF0369A1)], // Blue
    [Color(0xFF10B981), Color(0xFF047857)], // Green
    [Color(0xFFF59E0B), Color(0xFFB45309)], // Amber
  ];

  Widget _tile({
    required int index,
    required IconData icon,
    required String title,
    required String subtitle,
    required String feedback,
    required VoidCallback? onTap,
    VoidCallback? onDoubleTap,
    VoidCallback? onLongPress,
    GestureDragEndCallback? onHDrag,
    GestureDragEndCallback? onVDrag,
  }) {
    final colors = _tileGradients[index % _tileGradients.length];
    return GestureDetector(
      onTap: onTap,
      onDoubleTap: onDoubleTap,
      onLongPress: onLongPress,
      onHorizontalDragEnd: onHDrag,
      onVerticalDragEnd: onVDrag,
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          boxShadow: [
            BoxShadow(
              color: colors[0].withValues(alpha: 0.15),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            // Coloured left accent bar + icon
            Container(
              width: 56,
              height: 62,
              decoration: BoxDecoration(
                gradient: LinearGradient(colors: colors, begin: Alignment.topLeft, end: Alignment.bottomRight),
                borderRadius: const BorderRadius.only(topLeft: Radius.circular(14), bottomLeft: Radius.circular(14)),
              ),
              child: Icon(icon, color: Colors.white, size: 24),
              alignment: Alignment.center,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: Color(0xFF0F172A))),
                  Text(subtitle, style: const TextStyle(fontSize: 11, color: Color(0xFF64748B))),
                ],
              ),
            ),
            // Coloured count badge
            Container(
              margin: const EdgeInsets.only(right: 12),
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                gradient: LinearGradient(colors: colors),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(feedback, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F3FF),
      appBar: AppBar(title: const Text('Gestures & Animation')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            // Live gesture log — colourful card
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF0F172A), Color(0xFF1E1B4B)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(14),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF0F172A).withValues(alpha: 0.3),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Row(
                    children: [
                      Icon(Icons.radio_button_checked, size: 10, color: Color(0xFF4ADE80)),
                      SizedBox(width: 6),
                      Text('Live Gesture Log', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: Color(0xFF94A3B8))),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(_log, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white)),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Section: 5 Gestures
            _sectionHeader('1. Gestures Implementation (5 Gestures)', Icons.touch_app_rounded, const Color(0xFF7C3AED)),
            const SizedBox(height: 10),

            _tile(
              index: 0,
              icon: Icons.touch_app,
              title: 'Gesture 1: onTap',
              subtitle: 'Tap once to trigger action',
              feedback: 'Taps: $_taps',
              onTap: () => setState(() { _taps++; _log = '👉 [onTap] Taps: $_taps'; }),
            ),
            _tile(
              index: 1,
              icon: Icons.favorite,
              title: 'Gesture 2: onDoubleTap',
              subtitle: 'Double tap quickly to like',
              feedback: 'Likes: $_doubleTaps',
              onTap: null,
              onDoubleTap: () => setState(() { _doubleTaps++; _log = '❤️ [onDoubleTap] Likes: $_doubleTaps'; }),
            ),
            _tile(
              index: 2,
              icon: Icons.timer,
              title: 'Gesture 3: onLongPress',
              subtitle: 'Press and hold for 1 second',
              feedback: 'Count: $_longPresses',
              onTap: null,
              onLongPress: () {
                setState(() { _longPresses++; _log = '⏱️ [onLongPress] Count: $_longPresses'; });
                showDialog(
                  context: context,
                  builder: (ctx) => AlertDialog(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                    title: const Text('onLongPress Detected', style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF0F172A))),
                    content: const Text('Long press detected! You can view extra options or specifications here.'),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(ctx),
                        child: const Text('OK', style: TextStyle(color: Color(0xFF7C3AED), fontWeight: FontWeight.bold)),
                      ),
                    ],
                  ),
                );
              },
            ),
            _tile(
              index: 3,
              icon: Icons.swap_horiz,
              title: 'Gesture 4: onHorizontalDrag',
              subtitle: 'Swipe horizontally left/right',
              feedback: _drag,
              onTap: null,
              onHDrag: (d) {
                final dir = (d.primaryVelocity ?? 0) < 0 ? 'Left' : 'Right';
                setState(() { _drag = dir; _log = '↔️ [onHorizontalDrag] Swiped $dir'; });
              },
            ),
            _tile(
              index: 4,
              icon: Icons.swap_vert,
              title: 'Gesture 5: onVerticalDrag',
              subtitle: 'Drag vertically up/down',
              feedback: _drag,
              onTap: null,
              onVDrag: (d) {
                final dir = (d.primaryVelocity ?? 0) < 0 ? 'Up' : 'Down';
                setState(() { _drag = dir; _log = '↕️ [onVerticalDrag] Dragged $dir'; });
              },
            ),
            const SizedBox(height: 20),

            // Section: Animated Widgets
            _sectionHeader('2. Animated Widgets', Icons.animation_rounded, const Color(0xFF0EA5E9)),
            const SizedBox(height: 10),

            GestureDetector(
              onTap: () => setState(() => _expanded = !_expanded),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 350),
                curve: Curves.easeInOut,
                width: double.infinity,
                height: _expanded ? 100 : 60,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: _expanded
                        ? [const Color(0xFF0EA5E9), const Color(0xFF0369A1)]
                        : [Colors.white, const Color(0xFFF0F9FF)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: const Color(0xFF0EA5E9), width: 1.5),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF0EA5E9).withValues(alpha: 0.2),
                      blurRadius: 10,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Center(
                  child: Text(
                    _expanded ? '🎉 AnimatedContainer Expanded!\nHeight, Gradient & Border changed!' : '✨ Tap to animate this container',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      color: _expanded ? Colors.white : const Color(0xFF0369A1),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),

            // AnimatedOpacity toggle button
            GestureDetector(
              onTap: () => setState(() => _showVoucher = !_showVoucher),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: _showVoucher
                        ? [const Color(0xFFEC4899), const Color(0xFFBE185D)]
                        : [const Color(0xFF10B981), const Color(0xFF047857)],
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(_showVoucher ? Icons.visibility_off : Icons.visibility, size: 16, color: Colors.white),
                    const SizedBox(width: 8),
                    Text(
                      _showVoucher ? 'Hide Voucher (AnimatedOpacity)' : 'Show Voucher (AnimatedOpacity)',
                      style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 13),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 8),
            AnimatedOpacity(
              opacity: _showVoucher ? 1.0 : 0.0,
              duration: const Duration(milliseconds: 400),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(colors: [Color(0xFFEC4899), Color(0xFF7C3AED)]),
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFFEC4899).withValues(alpha: 0.3),
                      blurRadius: 10,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.local_offer_rounded, color: Colors.white, size: 18),
                    SizedBox(width: 8),
                    Text(
                      'PROMO CODE: QUICK20 — 20% OFF!',
                      style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 13),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Section: Counter
            _sectionHeader('3. Counter — setState()', Icons.countertops_rounded, const Color(0xFF10B981)),
            const SizedBox(height: 10),

            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF10B981).withValues(alpha: 0.15),
                    blurRadius: 14,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                children: [
                  // Counter display with coloured background
                  Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: LinearGradient(
                        colors: _counter > 0
                            ? [const Color(0xFF10B981), const Color(0xFF047857)]
                            : _counter < 0
                                ? [const Color(0xFFEF4444), const Color(0xFFB91C1C)]
                                : [const Color(0xFF94A3B8), const Color(0xFF64748B)],
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: (_counter > 0 ? const Color(0xFF10B981) : const Color(0xFF94A3B8)).withValues(alpha: 0.3),
                          blurRadius: 16,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Center(
                      child: Text(
                        '$_counter',
                        style: const TextStyle(fontSize: 34, fontWeight: FontWeight.w900, color: Colors.white),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Decrement
                      _counterBtn('−', [const Color(0xFFEF4444), const Color(0xFFB91C1C)],
                          () => setState(() { if (_counter > 0) _counter--; })),
                      const SizedBox(width: 10),
                      // Reset
                      _counterBtn('Reset', [const Color(0xFF64748B), const Color(0xFF334155)],
                          () => setState(() => _counter = 0)),
                      const SizedBox(width: 10),
                      // Increment
                      _counterBtn('+', [const Color(0xFF10B981), const Color(0xFF047857)],
                          () => setState(() => _counter++)),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  // Colourful gradient counter button
  Widget _counterBtn(String label, List<Color> colors, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: colors),
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: colors[0].withValues(alpha: 0.3),
              blurRadius: 8,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Text(label, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14)),
      ),
    );
  }

  // Section header helper
  Widget _sectionHeader(String title, IconData icon, Color color) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(6),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.15),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, size: 16, color: color),
        ),
        const SizedBox(width: 8),
        Flexible(
          child: Text(title, style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: color)),
        ),
      ],
    );
  }
}
