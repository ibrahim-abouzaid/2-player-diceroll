import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';

void main (){
  runApp(const Myapp());
}
class Myapp extends StatelessWidget{
  const Myapp({super.key});

  @override
  Widget build(BuildContext context) {
    return  const MaterialApp(
      home: DiceRoller(),
    );

  }

}

class DiceRoller extends StatefulWidget{
  const DiceRoller({super.key});

  @override
  State<DiceRoller> createState() => _DiceRollerState();
}

class _DiceRollerState extends State<DiceRoller> {

  void score(){
    if(diceblue!=-1 && dicered!=-1){
      if(diceblue<dicered){
        redteam+=1;
        print("redteam is ${redteam}");
      }
      else if(diceblue>dicered){
        blueteam+=1;
        print("blueteam is ${blueteam}");
      }
      diceblue=-1;
      dicered=-1;
    }
  }
  static int dicered=-1;
  static int diceblue=-1;
  static int redteam=0,blueteam=0;
  int CurrentRedDice=1,CurrentBlueDice=1,counter=0;
  Random random=Random();

  @override
  Widget build(BuildContext context) {
   return Scaffold(

     body: SafeArea(
       child: Container(
         decoration: BoxDecoration(
           gradient: LinearGradient(
             colors: [
               Colors.red,
               Colors.blue,
             ],
             stops: [
               0.5,
               0.5,
             ],
             end: Alignment.bottomCenter,
             begin: Alignment.topCenter,
           ),
         ),
         child: Column(
           mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Expanded(
                child: Container(
                  width: double.infinity,
                  child:  Transform.rotate(
                    angle: pi ,
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            children: [
                              const SizedBox(width: 20,),
                              Text("$redteam",style: const TextStyle(fontSize: 55),),
                            ],
                          ),
                          Image(image: AssetImage("assets/image/dice-$CurrentRedDice.png"),height: 195,),

                          ElevatedButton(onPressed: (){
                            Timer.periodic(const Duration(milliseconds: 80),(timer){
                              counter++;
                              setState(() {
                                CurrentRedDice=random.nextInt(6)+1;
                              });
                              if(counter>=20){
                                timer.cancel();
                                counter=1;
                                dicered=CurrentRedDice;
                                score();
                                setState(() {

                                });
                              }
                            });


                          },style : ButtonStyle(
                            backgroundColor :MaterialStatePropertyAll(Colors.red[900]),
                          ), child: const Padding(
                            padding: EdgeInsets.all(10),
                            child: Text("Roll Dice",style: TextStyle(
                                fontSize: 35
                            ),),
                          )),

                        ],
                      ),
                    ),
                  ),
                ),

              ),
              ElevatedButton(onPressed: (){
                setState(() {
                  redteam=0;
                  blueteam=0;
                  diceblue=-1;
                  dicered=-1;
                });
              }, child: Text("reset", style: TextStyle(fontSize: 40,color: Colors.white)),
              style: ButtonStyle(
                backgroundColor: MaterialStatePropertyAll(Colors.teal)
              )),
              Expanded(
                child: Container(
                  width: double.infinity,
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              const SizedBox(width: 20,),
                              Text("$blueteam",style: const TextStyle(fontSize: 55),),
                            ],
                          ),
                          Image(image: AssetImage("assets/image/dice-$CurrentBlueDice.png"),height: 195,),

                          ElevatedButton(onPressed: (){
                            Timer.periodic(const Duration(milliseconds: 80),(timer){
                              counter++;
                              setState(() {
                                CurrentBlueDice=random.nextInt(6)+1;
                              });
                              if(counter>=20){
                                timer.cancel();
                                counter=1;
                                diceblue=CurrentBlueDice;
                                score();
                                setState(() {

                                });
                              }
                            });


                          },style : ButtonStyle(
                            backgroundColor :MaterialStatePropertyAll(Colors.blue[900]),
                          ), child: const Padding(
                            padding: EdgeInsets.all(10),
                            child: Text("Roll Dice",style: TextStyle(
                                fontSize: 35
                            ),),
                          )),

                        ],
                      ),
                    ),
                ),

              ),
            ],
         ),
       ),
     ),
   );
  }
}
