import 'package:flutter/material.dart';

Widget reviewCard({required String text}) {
  return Padding(
    padding: EdgeInsets.only(bottom: 13),
    child: Container(
      padding: EdgeInsets.only(left: 8, right: 8, top: 12, bottom: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
        boxShadow: [
          BoxShadow(color: Colors.grey.withOpacity(0.5), blurRadius: 5),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              CircleAvatar(radius: 20, backgroundColor: Colors.brown),
              SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('John Wick'),
                  SizedBox(height: 5),
                  Text('2 days'),
                ],
              ),
              Spacer(),
              Icon(Icons.more_vert),
            ],
          ),

          SizedBox(height: 5),

          Row(
            children: [
              ...List.generate(
                5,
                (index) => Icon(Icons.star, size: 16, color: Colors.orange),
              ),
            ],
          ),
          SizedBox(height: 5),

          Text(text),
        ],
      ),
    ),
  );
}
