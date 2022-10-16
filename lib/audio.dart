// ignore_for_file: prefer_const_constructors, deprecated_member_use

import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:soundpool/soundpool.dart';

class AudioControll extends StatefulWidget {
  const AudioControll({Key? key}) : super(key: key);

  @override
  State<AudioControll> createState() => _AudioControllState();
}
bool? audioChecked = false;



class _AudioControllState extends State<AudioControll> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        // ignore: prefer_const_literals_to_create_immutables
        child: Column(
          // ignore: prefer_const_literals_to_create_immutables
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 300.0),
              child: Text("Audio check"),
            ),
            Checkbox(
                value: audioChecked,
                onChanged: (val) {
                
                }),
            FlatButton(
                onPressed: () {
                  openAudio();
                },
                child: Text("Play sound")),
              Text( audioChecked != true ? "Did you hear the sound?" : "Cool!" ) ,
              audioChecked == false ?  FlatButton(onPressed: (){
                  setState(() {
                    audioChecked = true;
                  });
                }, child: Text("Yes")) : Container(),
                 audioChecked == false ? FlatButton(onPressed: (){
                  setState(() {
                    audioChecked = false;
                    openAudio();
                  });
                 }, child: Text("No")) : Container(),
          ],
        ),
      ),
    );
  }
  Future openAudio() async {
    setState(() {
      audioChecked = false;
    });
    Soundpool pool = Soundpool(streamType: StreamType.notification);

    int soundId = await rootBundle.load("assets/test_sound.mp3").then((ByteData soundData) {
                  return pool.load(soundData);
                });
    await pool.play(soundId);
  }
}
