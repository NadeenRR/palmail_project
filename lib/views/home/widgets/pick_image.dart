import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class PickImage extends StatefulWidget {
  const PickImage(
      {super.key, required this.pickImage, this.function, this.image, this.isEdit});
  final XFile? pickImage;
  final Function? function;
  final ImageProvider? image;
  final bool? isEdit;

  @override
  State<PickImage> createState() => _PickImageState();
}

class _PickImageState extends State<PickImage> {
  @override
  void initState() {

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(24),
            child: widget.pickImage == null
                ? Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(24),
                      //border: Border.all(color: Colors.black),
                      image: DecorationImage(image: widget.image!, fit: BoxFit.cover),
                    ),
                  )
                : Image.file(
                    File(widget.pickImage!.path),
                    fit: BoxFit.cover,
                    height: size.width * 0.4,
                    width: size.width * 0.4,
                  ),
          ),
        ),
        if(widget.isEdit!)
        Positioned(
          top: 0,
          right: 0,
          child: Material(
            borderRadius: BorderRadius.circular(24),
            color: Theme.of(context).colorScheme.background,
            child: InkWell(
              borderRadius: BorderRadius.circular(24),
              onTap: () {
                widget.function!();
              },
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Icon(
                  Icons.add_a_photo_rounded,
                  size: 20,
                  color: Colors.black,
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
