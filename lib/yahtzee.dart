// Barrett Koster
// This is a finished Yahtzee roller
// tweak to make git work
// and again

import "package:flutter/material.dart";
import "dart:math";

void main() // 25
{
  runApp(Yahtzee());
}

class Yahtzee extends StatelessWidget
{
  Yahtzee({super.key});

  @override
  Widget build( BuildContext context )
  { return MaterialApp
    ( title: "yahtzee",
      home: YahtzeeHome(),
    );
  }
}

class YahtzeeHome extends StatefulWidget
{
  @override
  State<YahtzeeHome> createState() => YahtzeeHomeState();
}

class YahtzeeHomeState extends State<YahtzeeHome>
{
  var total = 0;
  List<Dice> theDice = [Dice(),Dice(),Dice(),Dice(),Dice(), ];

  @override
  Widget build( BuildContext context )
  { 
    return Scaffold
    ( appBar: AppBar(title: const Text("yahtzee")),
      body: Column
      ( children:
        [ FloatingActionButton
          ( onPressed: ()
            { setState
              ( () 
                { for ( Dice d in theDice )
                  { d.roll();   } 
                }
              );
            },
            child: Text("roll all"),
          ),
          Text("total $total"),
          Row( children: theDice, ),
        ]
      ),
    );
  }
}

class Dice extends StatefulWidget
{
  final DiceState ds = DiceState();
  @override
  State<Dice> createState() => ds;

  void roll() { ds.roll(); }
}

class DiceState extends State<Dice>
{
  var face = 5;
  bool holding = false;
  final randy = Random();

  void roll()
  { if (!holding)
    { setState
      ( () {face = randy.nextInt(6) + 1; }
      );
      
    }
  }

  Widget build( BuildContext context )
  {
    List<Dot> dots = [];
    if ( face>1 ) // upper left and lower right
    { dots.add( Dot(top:10,left:20) );
      dots.add( Dot(top:70, left:70) );
    }
    if ( face>3 ) // other corners
    { dots.add( Dot(top:10,left:70) );
      dots.add( Dot(top:70, left:20) );
    }
    if (face==4 || face==6 )
    { dots.add( Dot(top:40,left:20) );
      dots.add( Dot(top:40, left:70) );
    }
    if ( face==1 || face==3 || face==5 )
    { dots.add( Dot(top:40,left:45) ); 
    }

    return Column
    ( children: 
      [ Container
        ( decoration: BoxDecoration
          ( border: Border.all( width:2, ) ,
            color: (holding? Colors.pink: Colors.white),
          ),
          height: 100, width: 100, 
          child: Stack( children:dots, ),
        ),
        FloatingActionButton
        ( onPressed: (){ setState((){ holding = !holding;}); },
          child: Text("hold"),
        ),
      ],
    );
  }
}

class Dot extends Positioned
{
  Dot(  {super.top, super.left } )
  : super
    ( child: Container
      ( height: 10, width: 10,
        decoration: BoxDecoration
        ( color: Colors.black,
          shape: BoxShape.circle,
        ),
      ),
    );
}