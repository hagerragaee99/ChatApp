// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class CustomTextformfield extends StatefulWidget {
  String? hintText;
  CustomTextformfield({super.key, this.hintText});

  @override
  State<CustomTextformfield> createState() => _CustomTextformfieldState();
}

class _CustomTextformfieldState extends State<CustomTextformfield> {
  bool _obscureText = true;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 15.0),
      child: TextFormField(
        style: TextStyle(color: Colors.white, fontSize: 13),
        onChanged: (value) {},
        obscuringCharacter: '*',
        obscureText:
            widget.hintText == 'Enter Your Password' ||
                widget.hintText == 'Confirm Your Password'
            ? _obscureText
            : _obscureText = false,

        decoration: InputDecoration(
          enabled: true,
          suffixIcon:
              widget.hintText == 'Enter Your Password' ||
                  widget.hintText == 'Confirm Your Password'
              ? IconButton(
                  icon: Icon(
                    Icons.remove_red_eye,
                    color: Colors.white54,
                    size: 15,
                  ),
                  onPressed: () {
                    setState(() {
                      _obscureText = !_obscureText;
                    });
                  },
                )
              : null,
          hintText: widget.hintText,
          hintStyle: TextStyle(color: Colors.white54, fontSize: 13),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          contentPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
              color: const Color.fromARGB(255, 126, 164, 184),
              width: 1,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: Colors.blue, width: 2),
          ),
        ),
      ),
    );
  }
}
