import 'package:flutter/material.dart';
import 'package:noteapp/Models/DoubleSwipeExit.dart';
import 'package:noteapp/Models/JournalyList.dart';
import 'package:noteapp/Models/Loginpage.dart';
import 'package:noteapp/Screens/Quick_Notes_Page.dart';
import 'package:noteapp/Widgets/Home_Containers.dart';
import 'package:noteapp/consts/Const_Color.dart';

class HomePage extends StatelessWidget 
{
  const HomePage
  ({
    super.key,
  });

  @override
  Widget build(BuildContext context) 
  {
    return  DoubleSwipeExit(
      child: Scaffold
      (
        backgroundColor: backgroundColor2,
        body: Padding
        (
          padding: const EdgeInsets.symmetric( horizontal: 20.0),
          child: Column
          (
            children: 
            [
              const SizedBox(height: 100,),
              HomeContainers(title: "Jornal", subtitle: "Last edited 5 Nov 24" , imagePath: "Assets/Home_Page_assets/Jornal.png", containerColor: PinkLight,
              onTap: ()
              {
                Navigator.push
                (
                  context, 
                  MaterialPageRoute
                  (
                    builder: (context) => const journalList(),
                  )
                );
              },
              ),
              HomeContainers(title: "Quick Notes", subtitle: "Last edited 1 Dec 24" , imagePath: "Assets/Home_Page_assets/Quick_Note_Girl.png", containerColor: BlueLight,imageheight: 90,imagewidth: 90,imagerightpadding: 7.5,
              onTap: ()
              {
                Navigator.push
                (
                  context, 
                  MaterialPageRoute
                  (
                    builder: (context) => const QuickNotesPage(),
                  )
                );
              },
              ),
              HomeContainers(title: "Goals", subtitle: "Last edited 7 Nov 24" , imagePath: "Assets/Home_Page_assets/Quistions_Design_2.png", containerColor: YellowLight,imageheight: 90,imagewidth: 90,
              onTap: ()
              {
                Navigator.push
                (
                  context, 
                  MaterialPageRoute
                  (
                    builder: (context) => Loginpage(),
                  )
                );
              },
              ),
              HomeContainers(title: "Road Map", subtitle: "Last edited 30 Oct 24" , imagePath: "Assets/Home_Page_assets/Road_Map.png", containerColor: GreenLight,imageheight: 90,imagewidth: 90, imagerightpadding: 10,),
            ],
          ),
        )
      ),
    );
  }
}