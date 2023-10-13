import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatefulWidget{
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>{
  bool Oturn = true;      //first person is 0
  String whoturn='';
  List<String> displayXO=['','','','','','','','',''];
  var myTextStyle=TextStyle(color: Colors.white,fontSize: 30);
  int Oscore=0;
  int Xscore=0;
  int filledBoxes=0;
  String turn='';

  static var myNewFont=GoogleFonts.pressStart2p(
      textStyle:TextStyle(color:Colors.black,letterSpacing: 3));
  static var myNewFontWhite=GoogleFonts.pressStart2p(
      textStyle:TextStyle(color:Colors.white,fontSize: 15));


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[800],
        body:Column(
          children: <Widget> [
            SizedBox(height: 30,),

            Expanded(child: Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Player 1 ',style:myNewFontWhite,),
                        Text(Oscore.toString(),style:myTextStyle,),
                      ],
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Player 2 ',style:myNewFontWhite,),
                      Text(Xscore.toString(),style:myTextStyle,),
                    ],
                  ),

                ],
              ),
            )
            ),

            Container(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(turn,style: myNewFontWhite.copyWith(fontSize: 16),),
              )
            ),
            Expanded(
              flex: 3,
              child: GridView.builder(
                  itemCount: 9 ,
                  gridDelegate:
                  SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
                  itemBuilder: (BuildContext context,int index){
                    return GestureDetector(
                      onTap:(){
                        tapped(index);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(color:Colors.grey),
                        ),
                        child: Center(
                          child:Text(
                            displayXO[index]
                            ,style: TextStyle(color: Colors.white,
                              fontSize: 40),),
                        ),
                      ),
                    );
                  }

              ),
            ),

            Expanded(
                child: Container(
                    child:Center(
                        child:Column(
                          children: [

                            Text('TIC TAC TOE',style:myNewFontWhite.copyWith(fontSize: 25,)),
                            SizedBox(height: 50,),
                            Text('@CREATEDBYHARSH',style:myNewFontWhite.copyWith(fontSize:22)),
                          ],
                        )
                    )
                )
            ),
          ],
        ) );

  }


  void tapped(int index) {
    setState(() {
      if(Oturn && displayXO[index]==''){
        displayXO[index]='O';
        turn="X's turn";
        filledBoxes+=1;
      }else if(!Oturn && displayXO[index]==''){
        displayXO[index]='X';
        turn="O's turn";
        filledBoxes+=1;
      }
      Oturn=!Oturn;
      checkWinner();
    });
  }

  void checkWinner(){


//checks 1st row
    if(displayXO[0] == displayXO[1] &&
        displayXO[1] == displayXO[2] &&
        displayXO[0]!= ''){
      showWinDialog(displayXO[0]);
    }

    //checks 2nd row
    if(displayXO[3] == displayXO[4] &&
        displayXO[4] == displayXO[5] &&
        displayXO[3]!= ''){
      showWinDialog(displayXO[3]);
    }

    //checks 3rd row
    if(displayXO[6] == displayXO[7] &&
        displayXO[7] == displayXO[8] &&
        displayXO[6]!= ''){
      showWinDialog(displayXO[6]);
    }

    //checks 1st column
    if(displayXO[0] == displayXO[3] &&
        displayXO[3] == displayXO[6] &&
        displayXO[0]!= ''){
      showWinDialog(displayXO[0]);
    }

    //checks 2nd column
    if(displayXO[1] == displayXO[4] &&
        displayXO[4] == displayXO[7] &&
        displayXO[1]!= ''){
      showWinDialog(displayXO[1] );
    }

    //checks 3rd column
    if(displayXO[2] == displayXO[5] &&
        displayXO[5] == displayXO[8] &&
        displayXO[2]!= ''){
      showWinDialog(displayXO[2]);
    }

    //checks diagonally
    if(displayXO[2] == displayXO[4] &&
        displayXO[4] == displayXO[6] &&
        displayXO[2]!= ''){
      showWinDialog(displayXO[2]);
    }

    //checks diagonally
    if(displayXO[0] == displayXO[4] &&
        displayXO[4] == displayXO[8] &&
        displayXO[0]!= ''){
      showWinDialog(displayXO[0] );
    }else if(filledBoxes== 9){
      showDrawDialog();
    }
  }

  void showWinDialog(String winner){
    showDialog(
        barrierDismissible: false,
        context: context, builder:(BuildContext context){
      return AlertDialog(
        actions: <Widget>[
          ElevatedButton(onPressed:(){
            clearBoard();
            Navigator.of(context).pop();
          },
            child: Text('Play Again?',
                style:TextStyle(color:Colors.white)),
            style: ElevatedButton.styleFrom(
              primary: Colors.blue,
            ),
          )
        ],
        backgroundColor: Colors.white,
        title: Text('$winner player WINS!!',style: TextStyle(fontSize: 26,),),

      );
    });

    if(winner == 'O'){
      Oscore+=1;
    }else if(winner == 'X'){
      Xscore+=1;
    }

  }

  void showDrawDialog(){
    showDialog(
        barrierDismissible: false,
        context: context, builder:(BuildContext context){
      return AlertDialog(
        actions: <Widget>[
          ElevatedButton(onPressed:(){
            clearBoard();
            Navigator.of(context).pop();
          },
            child: Text('Play Again?',
                style:TextStyle(color:Colors.white)),
            style: ElevatedButton.styleFrom(
              primary: Colors.blue,
            ),
          )
        ],
        backgroundColor: Colors.white,
        title: Text('Match DRAW!!',style: TextStyle(fontSize: 26,),),

      );
    });

  }

  void clearBoard(){
    for(int i=0;i<9;i++){
      setState(() {
        displayXO[i]='';
        turn='';
      });
    }
    filledBoxes=0;
  }
}