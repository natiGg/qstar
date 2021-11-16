import 'package:flutter/material.dart';
import 'package:qstar/constant.dart';

class TextFieldWidget extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  const TextFieldWidget({ Key? key,required this.label,required this.controller}) : super(key: key);

  Widget build(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          const SizedBox(height: 8),
          TextFormField(
            controller: controller,
            decoration: InputDecoration(
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: mPrimaryColor, width: 2.0),
                borderRadius: BorderRadius.circular(12),
              ),
              border: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.white, width: 2.0),
                borderRadius: BorderRadius.circular(12),
                
              ),
            ),

   
          ),
        ],
      );
}
