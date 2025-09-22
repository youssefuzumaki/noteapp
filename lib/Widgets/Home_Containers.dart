import 'package:flutter/material.dart';
import 'package:noteapp/consts/Const_Color.dart';

class HomeContainers extends StatelessWidget 
{
  final String title;
  final String subtitle;
  final String imagePath;
  final Color containerColor;
  final VoidCallback? onTap;
  final double imageheight;
  final double imagewidth;
  final double imageleftpadding;
  final double imagetoppadding ;
  final double imagebottompadding ;
  final double imagerightpadding ;
  const HomeContainers
  ({
    super.key,
    required this.title,
    required this.subtitle,
    required this.imagePath,
    required this.containerColor,
    this.onTap,
    this.imageheight = 100,
    this.imagewidth = 100,
    this.imageleftpadding = 0,
    this.imagetoppadding = 0,
    this.imagebottompadding = 0,
    this.imagerightpadding = 0,
  });

  @override
  Widget build(BuildContext context) {
    return Padding
    (
      padding: const EdgeInsets.only( top: 15.0),
      child: GestureDetector
      (
        onTap: onTap,
        child: Container
        (
          height: 120,
          width: double.infinity,
          decoration: BoxDecoration
          (
            color: containerColor,
            borderRadius: BorderRadius.circular(22.5)
          ),
          child: Row
          (
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: 
            [
              Padding
              (
                padding: const EdgeInsets.only(top: 35.0, left:30),
                child: Column
                (
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: 
                  [
                     Text(title, style: TextStyle(fontSize: 13.5,  fontWeight: FontWeight.bold, color: textColor,),),
                    const SizedBox(height: 5,),
                     Text(subtitle, style: TextStyle(fontSize: 10, color: Colors.grey),)
                  ],
                ),
              ),
              Padding
              (
                padding:  EdgeInsets.only(right: imagerightpadding, top: imagetoppadding, bottom: imagebottompadding, left: imageleftpadding),
                child: Image.asset(imagePath, height: imageheight, width: imagewidth,),
              ),
            ],
          ),
        ),
      ),
    );
  }
}