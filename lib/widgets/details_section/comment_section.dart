import 'package:flutter/material.dart';

class CommentSection extends StatelessWidget {
  const CommentSection({super.key});

  Widget starButton(int index) {
    return IconButton(
      onPressed: () {
        // setState(() {
        //   _isSelected = !_isSelected;
        // });
      },
      icon: Icon(Icons.star, color: Colors.amber),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 5.0, right: 5.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [BoxShadow(blurRadius: 5, color: Colors.grey)],
        ),
        child: DraggableScrollableActuator(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Reviews (1)",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),
                Row(
                  children: [
                    Icon(Icons.star, color: Colors.yellow),
                    Text("2.5", style: TextStyle(fontWeight: FontWeight.bold)),
                    SizedBox(width: 15),
                    Text("(1 review)"),
                  ],
                ),
                SizedBox(height: 10),
                Card(
                  color: Colors.grey.withValues(alpha: 0),
                  // shadowColor: Colors.grey,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            const CircleAvatar(
                              backgroundImage: AssetImage(
                                'assets/images/cloths.jpg',
                              ),
                            ),
                            SizedBox(width: 10),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text('John Doe'),
                                const Text('2 days ago'),
                              ],
                            ),
                            Spacer(),
                            ...List.generate(
                              5,
                              (index) => Icon(
                                Icons.star,
                                size: 16,
                                color: Colors.orange,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 8.0),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Card(
                  color: Colors.grey.withValues(alpha: 0),
                  // shadowColor: Colors.grey,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            const CircleAvatar(
                              backgroundImage: AssetImage(
                                'assets/images/cloths.jpg',
                              ),
                            ),
                            SizedBox(width: 10),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text('John Doe'),
                                const Text('2 days ago'),
                              ],
                            ),
                            Spacer(),
                            ...List.generate(
                              5,
                              (index) => Icon(
                                Icons.star,
                                size: 16,
                                color: Colors.orange,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 8.0),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
