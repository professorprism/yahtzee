// Barrett Koster
// This is a finished Yahtzee roller

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
    ( title: "yahtzee - Barrett",
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
                { total = 0;
                  for ( Dice d in theDice )
                  { total += d.roll(); } 
                }
              );
            },
            child: Text("roll all",style:TextStyle(fontSize:30)),
          ),
          Text("total $total",style:TextStyle(fontSize:30)),
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

  // pass-through function.  
  int roll() { return ds.roll(); }
}

class DiceState extends State<Dice>
{
  var face = 0;
  bool holding = false;
  final randy = Random();

  // change face to 1-6 randomly IFF not holding
  int roll()
  { if (!holding)
    { setState
      ( () {face = randy.nextInt(6) + 1; }
      );
    }
    return face;
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
    if (face==4 || face==6 ) // middle side dots
    { dots.add( Dot(top:40,left:20) );
      dots.add( Dot(top:40, left:70) );
    }
    if ( face==1 || face==3 || face==5 ) // center dot
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
        // just for debugging
        FloatingActionButton
        ( onPressed: (){ setState((){ roll(); }); },
          child: Text("roll"),
        ),
      ],
    );
  }
}

// is one dot on one face of a Dice (die).
// It knows where it is suppose to be because it 
// extends a Positioned.  The coordinates have to be
// named in the constructor call.
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