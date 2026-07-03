import 'package:flutter/material.dart';

class CommentSection extends StatefulWidget {
  const CommentSection({super.key});

  @override
  State<CommentSection> createState() => _CommentSectionState();
}

class _CommentSectionState extends State<CommentSection> {
  bool _isSelected = false;

  Widget starButton(int index) {
    return IconButton(
      onPressed: () {
        setState(() {
          _isSelected = !_isSelected;
        });
      },
      icon: Icon(
        Icons.star,
        color: _isSelected ? Colors.amber : Colors.transparent,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          ListTile(
            leading: const CircleAvatar(
              backgroundImage: AssetImage('assets/images/cloths.jpg'),
            ),
            title: const Text('John Doe'),
            subtitle: const Text('2 days ago'),
            trailing: IconButton(
              icon: const Icon(Icons.thumb_up),
              onPressed: () {
                // Handle like button press
              },
            ),
          ),
          SizedBox(height: 8.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: List.generate(5, (index) => starButton(index)),
          ),
        ],
      ),
    );
  }
}
