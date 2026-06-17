import 'dart:math';
import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';
import '../../constants/blueprint_colors.dart';
import '../../database/database.dart';

const _kPpm = 1.5; // pixels per minute
const _kPph = _kPpm * 60.0; // 90 px per hour
const _kEvtH = 64.0; // event block height
const _kLabelW = 56.0;
const _kMinHours = 4;

class DayTimelineScreen extends StatelessWidget {
  final DateTime date;
  final List<EventWithPet> events;

  const DayTimelineScreen(
      {super.key, required this.date, required this.events});

  static String _fmtDate(DateTime d) {
    const wd = ['Monday','Tuesday','Wednesday','Thursday','Friday','Saturday','Sunday'];
    const mo = ['January','February','March','April','May','June','July','August','September','October','November','December'];
    return '${wd[d.weekday - 1]}, ${mo[d.month - 1]} ${d.day}';
  }

  static String _fmtHour(int h) {
    final n = h % 24;
    if (n == 0) return '12 AM';
    if (n < 12) return '$n AM';
    if (n == 12) return '12 PM';
    return '${n - 12} PM';
  }

  int get _startHr =>
      events.isEmpty ? 8 : (events.first.timestamp.hour - 1).clamp(0, 23);

  int _endHr(int startHr) {
    if (events.isEmpty) return startHr + _kMinHours;
    final natural = events.last.timestamp.hour + 2;
    return max(natural, startHr + _kMinHours);
  }

  @override
  Widget build(BuildContext context) {
    if (events.isEmpty) {
      return Scaffold(
        appBar: AppBar(title: Text(_fmtDate(date))),
        body: const Center(
            child: Text('No events on this day',
                style: TextStyle(color: Colors.grey))),
      );
    }

    final startHr = _startHr;
    final endHr = _endHr(startHr);
    final totalHours = endHr - startHr;
    final totalH = totalHours * _kPph;

    // Group events sharing the same timestamp for side-by-side columns.
    final groups = <DateTime, List<EventWithPet>>{};
    for (final e in events) {
      groups.putIfAbsent(e.timestamp, () => []).add(e);
    }

    return Scaffold(
      appBar: AppBar(title: Text(_fmtDate(date))),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(top: 8, bottom: 32, right: 8),
        child: SizedBox(
          height: totalH,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Hour labels column
              SizedBox(
                width: _kLabelW,
                child: Stack(
                  children: [
                    for (int h = startHr; h <= endHr; h++)
                      Positioned(
                        top: (h - startHr) * _kPph - 8,
                        right: 8,
                        child: Text(_fmtHour(h),
                            style: const TextStyle(
                                fontSize: 11, color: Colors.grey)),
                      ),
                  ],
                ),
              ),
              // Events area
              Expanded(
                child: LayoutBuilder(builder: (ctx, constraints) {
                  final w = constraints.maxWidth;
                  return Stack(children: [
                    // Hour divider lines
                    for (int h = startHr; h <= endHr; h++)
                      Positioned(
                        top: (h - startHr) * _kPph,
                        left: 0,
                        right: 0,
                        child: Divider(height: 1, color: Colors.grey.shade200),
                      ),
                    // Event blocks
                    for (final entry in groups.entries)
                      for (int i = 0; i < entry.value.length; i++)
                        Positioned(
                          top: ((entry.key.hour - startHr) * 60 +
                                  entry.key.minute) *
                              _kPpm,
                          left: i / entry.value.length * w,
                          width: w / entry.value.length - 4,
                          child: _EventBlock(event: entry.value[i]),
                        ),
                  ]);
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _EventBlock extends StatelessWidget {
  final EventWithPet event;
  const _EventBlock({required this.event});

  @override
  Widget build(BuildContext context) {
    final accentColor = event.systemComponents.isNotEmpty
        ? blueprintColor(event.systemComponents.first)
        : AppColors.sand;
    return Container(
      height: _kEvtH,
      margin: const EdgeInsets.only(bottom: 2),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(left: BorderSide(color: accentColor, width: 4)),
        borderRadius: const BorderRadius.horizontal(right: Radius.circular(6)),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withValues(alpha: 0.07),
              blurRadius: 4,
              offset: const Offset(0, 1))
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
        child: Row(
          children: [
            CircleAvatar(
              radius: 14,
              backgroundColor: AppColors.sand,
              child: Text(event.petName[0].toUpperCase(),
                  style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 12)),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('${event.petName} ${event.displayLabel}',
                      style: const TextStyle(
                          fontSize: 12, fontWeight: FontWeight.w600),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis),
                  Text('by ${event.loggedByName}',
                      style:
                          const TextStyle(fontSize: 11, color: Colors.grey)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
