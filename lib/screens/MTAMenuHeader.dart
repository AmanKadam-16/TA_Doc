
import 'package:flutter/material.dart';

class MTAManuHeader extends StatefulWidget {
  const MTAManuHeader({super.key});

  @override
  State<MTAManuHeader> createState() => _MTAManuHeaderState();
}

class _MTAManuHeaderState extends State<MTAManuHeader> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blueAccent ,
      width: double.infinity,
      height: 200,
      padding: const EdgeInsets.only(top: 20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(

              child: const CircleAvatar(
                radius: 55,
                backgroundColor: Colors.white,
                child: CircleAvatar(
                  radius: 50,
                  backgroundColor: Colors.white,
                  backgroundImage: AssetImage('assets/images/nykaa.png'),
                ),
              )

          ),
          const Text('Insignia E Security Pvt. Ltd.',style: TextStyle(color: Colors.white,fontSize: 20,),),
          const Text('www.planetinsignia.com',style: TextStyle(color: Colors.white,fontSize: 14,),),
        ],
      ),
    );
  }

}


