import 'package:flutter/material.dart';
import 'chat.dart';
import 'photo.dart';
import 'qut.dart';
import 'audio.dart';
import 'const.dart';
class chose extends StatefulWidget {
  const chose({super.key});

  @override
  State<chose> createState() => _choseState();
}

class _choseState extends State<chose> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(backgroundColor: app,
      appBar: AppBar(title: Text("Welcome To AI World",style: TextStyle(color: txt),),backgroundColor:back ),
      body:
      SizedBox.expand(
    child: Container(   decoration: BoxDecoration(
                      image: DecorationImage(
                      image: AssetImage("images/s.gif"),
                      fit: BoxFit.cover,
                      )),
          child: ListView(
            children: [
              Padding(
                padding:  EdgeInsets.fromLTRB(10,10,10,0),
                child: GestureDetector(
                  onTap: (){
                  Navigator.push(context,MaterialPageRoute(builder: (context) =>HomeScreen() ,));
                },
                        child:
                        expn("AI Bot can I Help You !",Icons.rocket_launch,l3,Icons.interests_outlined),
                ),
              ),
              Padding(
                padding:  EdgeInsets.fromLTRB(10,30,10,10),
                child: GestureDetector(
                  onTap: (){
                  Navigator.push(context,MaterialPageRoute(builder: (context) =>photo() ,));
                },
                child: expn("Im you Photo Generator !", Icons.image_outlined, l1,Icons.panorama_photosphere),),
              ),
              Padding(
                padding:  EdgeInsets.fromLTRB(10,30,10,10),
                child: GestureDetector(
                  onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context) => QuoteGenerator(),));},
                child: expn("Quote  Generator !", Icons.article,l2,Icons.edit ),),
              ),
              Padding(
                padding:  EdgeInsets.fromLTRB(10,30,10,10),
                child: GestureDetector(
                  onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context) => audio(),));},
                  child: expn(" audio File To Text!", Icons.wrap_text_outlined, l4,Icons.file_present),),
              ),


            ],
          ),
        ),
      ),
    );
  }}

  Expanded expn(t1,icn,clr,icn2) {
    return Expanded(child:
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Container(height: 100,
                      decoration: BoxDecoration(
                          color: clr,
                          borderRadius: BorderRadius.all(Radius.circular(20))

                      ),child:Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [CircleAvatar(backgroundColor: back,radius: 30,child: Icon(icn2,color: Colors.white,size: 45,))
                            ,Text(t1,style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: txt),),
                            Icon(icn,size: 40,color: txt,)],
                        ),
                      )
                  ),
                ),);
  }
