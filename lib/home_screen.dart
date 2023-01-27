import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


class homescreen extends StatefulWidget {
  @override
  State<homescreen> createState() => _homescreenState();
}

class _homescreenState extends State<homescreen> {

  bool oturn = true;
  int attempt = 0;
  String result = "";
  bool winneris = false;
  int oscore = 0;
  int xscore = 0;
  int fillbox = 0;
  Timer? timer;
  List<String> display = ["","","","","","","","","",];
  List<int> match = [];

  static const maxsec = 30;
  int sec = maxsec;

  void ontap(int index){
    final runing = timer == null ? false : timer!.isActive;
    if(runing){
      setState(() {
        if(oturn && display[index] == ''){
          display[index] = "O";
          fillbox++;
        }else if (!oturn && display[index] == ''){
          display[index] = "X";
          fillbox++;
        }
        oturn = !oturn;
        winner();
      });
    }
  }

  void winner(){
    if(display[0]== display[1] &&
        display[0]== display[2] &&
        display[0] != ""){
      setState(() {
        result = "player " + display[0] + " Wins!";
        match.addAll([0,1,2]);
        stoptimer();
        scoreupdate(display[0]);
      });
    }
    if(display[3]== display[4] &&
        display[3]== display[5] &&
        display[3] != ""){
      setState(() {
        result = "player " + display[3] + " Wins!";
        match.addAll([3,4,5]);
        stoptimer();
        scoreupdate(display[3]);
      });
    }
    if(display[6]== display[7] &&
        display[6]== display[8] &&
        display[6] != ""){
      setState(() {
        result = "player " + display[6] + " Wins!";
        match.addAll([6,7,8]);
        stoptimer();
        scoreupdate(display[6]);
      });
    }
    if(display[0]== display[3] &&
        display[0]== display[6] &&
        display[0] != ""){
      setState(() {
        result = "player " + display[0] + " Wins!";
        match.addAll([0,3,6]);
        stoptimer();
        scoreupdate(display[0]);
      });
    }
    if(display[1]== display[4] &&
        display[1]== display[7] &&
        display[1] != ""){
      setState(() {
        result = "player " + display[1] + " Wins!";
        match.addAll([1,4,7]);
        stoptimer();
        scoreupdate(display[1]);
      });
    }
    if(display[2]== display[5] &&
        display[2]== display[8] &&
        display[2] != ""){
      setState(() {
        result = "player " + display[2] + " Wins!";
        match.addAll([2,5,8]);
        stoptimer();
        scoreupdate(display[2]);
      });
    }
    if(display[0]== display[4] &&
        display[0]== display[8] &&
        display[0] != ""){
      setState(() {
        result = "player " + display[0] + " Wins!";
        match.addAll([0,4,8]);
        stoptimer();
        scoreupdate(display[0]);
      });
    }
    if(display[6]== display[4] &&
        display[6]== display[2] &&
        display[6] != ""){
      setState(() {
        result = "player " + display[6] + " Wins!";
        match.addAll([6,4,2]);
        stoptimer();
        scoreupdate(display[6]);
      });
    }
    else if ( !winneris && fillbox == 9){
      setState(() {
        result = 'Draw!';
        stoptimer();
      });
    }
  }

  void scoreupdate(String winner){
    if(winner == 'O'){
      oscore++;
    }
    else if (winner == 'X'){
      xscore++;
    }
    winneris = true;
  }

  void clearall(){
    setState(() {
      for (int i =0; i <9; i++){
        display[i]='';
      }
      result = '';
    });
    fillbox = 0;
    match = [];
  }

  void starttimer(){
    timer = Timer.periodic(Duration(seconds: 1), (_) {
      setState(() {
        if (sec>0){
          sec--;
        }else{
          stoptimer();
        }
      });
    });
  }

  void stoptimer(){
    resettimer();
    timer?.cancel();
  }

  void resettimer() => sec = maxsec;


  Widget buildtimer(){
    final runing = timer == null ? false : timer!.isActive;
    return runing ?
        SizedBox(
          width:90,
            height:90,
          child: Stack(
            fit: StackFit.expand,
            children: [
              CircularProgressIndicator(
                value: 1-sec/maxsec,
                valueColor: AlwaysStoppedAnimation(Colors.white),
                strokeWidth:8,
                backgroundColor: Colors.amber,
              ),
              Center(
                child: Text(
                  '$sec',
                  style: TextStyle(
                    fontSize: 50,
                    color:Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        )
        : ElevatedButton(
          onPressed: (){
            starttimer();
          clearall();
          attempt++;
        },
            style: ElevatedButton.styleFrom(
            backgroundColor: Colors.white,
            padding: EdgeInsets.symmetric(horizontal: 40,vertical: 20)
        ),
           child: Text(
               attempt ==0 ? 'Start' : "Play Again",
               style: TextStyle(color: Colors.black , fontSize: 20)));
  }


  @override

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepOrange,
      body: Padding(
        padding: EdgeInsets.all(25),
        child: Column(
          children: [
            Expanded(
              flex: 1,
              child:  Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text('Player O', style: GoogleFonts.rumRaisin(textStyle: TextStyle(color:Colors.white, fontSize:40),)),
                        Text(oscore.toString(), style: GoogleFonts.rumRaisin(textStyle: TextStyle(color:Colors.white, fontSize: 40),))
                      ],
                    ),
                    SizedBox(width:60,),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text('Player X',  style: GoogleFonts.rumRaisin(textStyle: TextStyle(color:Colors.white, fontSize: 40),)),
                        Text(xscore.toString(), style: GoogleFonts.rumRaisin(textStyle: TextStyle(color:Colors.white, fontSize: 40),))
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 3,
              child: GridView.builder(
                itemCount: 9,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount:3),
                  itemBuilder: (BuildContext context, int index){
                    return GestureDetector(
                      onTap: (){
                        ontap(index);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(
                            width: 5,
                            color: Colors.black
                          ),
                          color: match.contains(index)?
                          Colors.blueAccent:
                          Colors.amber,
                        ),
                        child: Center(
                          child: Text(display[index],
                            style: GoogleFonts.fredokaOne(
                            textStyle: TextStyle(
                                fontSize:67,
                                color: Colors.black,
                            ),
                          ),),
                        ) ,
                      ),
                    );
                  },
              ),
            ),
            Expanded(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(result,
                    style: GoogleFonts.rumRaisin(textStyle:
                    TextStyle(color:Colors.white, fontSize: 40), )
                    ),
                    SizedBox(height: 10,),
                    buildtimer(),
                  ],
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }
}
