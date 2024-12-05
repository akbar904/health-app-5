import 'package:flutter/material.dart';

class CalendarWidget extends StatelessWidget {
  final Map<DateTime, List<String>> events;
  final Function(DateTime)? onDaySelected;

  const CalendarWidget({
    Key? key,
    this.events = const {},
    this.onDaySelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          _buildCalendarHeader(),
          _buildCalendarGrid(),
          if (events.isNotEmpty) _buildEventList(),
        ],
      ),
    );
  }

  Widget _buildCalendarHeader() {
    final now = DateTime.now();
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '${_getMonthName(now.month)} ${now.year}',
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          Row(
            children: [
              IconButton(
                icon: const Icon(Icons.chevron_left),
                onPressed: () {
                  // Handle previous month
                },
              ),
              IconButton(
                icon: const Icon(Icons.chevron_right),
                onPressed: () {
                  // Handle next month
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCalendarGrid() {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 7,
        mainAxisSpacing: 8,
        crossAxisSpacing: 8,
      ),
      itemCount: 7 * 6, // 6 weeks
      itemBuilder: (context, index) {
        final day = index + 1;
        return _buildDayCell(day);
      },
    );
  }

  Widget _buildDayCell(int day) {
    return InkWell(
      onTap: () {
        // Handle day selection
        if (onDaySelected != null) {
          onDaySelected!(DateTime.now());
        }
      },
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey[300]!),
          borderRadius: BorderRadius.circular(4),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              day.toString(),
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            if (_hasEvents(day))
              Container(
                width: 6,
                height: 6,
                decoration: const BoxDecoration(
                  color: Colors.blue,
                  shape: BoxShape.circle,
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildEventList() {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Events',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: events.length,
            itemBuilder: (context, index) {
              final event = events.entries.elementAt(index);
              return ListTile(
                title: Text(event.value.first),
                subtitle: Text(_formatDate(event.key)),
              );
            },
          ),
        ],
      ),
    );
  }

  bool _hasEvents(int day) {
    final date = DateTime(DateTime.now().year, DateTime.now().month, day);
    return events.containsKey(date);
  }

  String _getMonthName(int month) {
    const months = [
      'January', 'February', 'March', 'April', 'May', 'June',
      'July', 'August', 'September', 'October', 'November', 'December'
    ];
    return months[month - 1];
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }
}