


import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'constants.dart' as k;
import 'dart:convert';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isLoaded=false;
  num temp=0;
  num press=0;
  num hum=0;
  num cover=0;
    String cityname='';
  TextEditingController controller=TextEditingController();

  @override
  void initState() {
    super.initState();
    getCurrentLocation();
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
        width: double.infinity,
        height: double.infinity,
        padding:  const EdgeInsets.all(20),
        decoration:  const BoxDecoration(
          gradient: LinearGradient(
            // begin: Alignment.topRight,
            // end: Alignment.bottomRight,
            begin: Alignment.bottomLeft,
            end: Alignment.topRight,
          
            colors: [
              Color.fromARGB(255, 233, 174, 236),
              Color(0xFF2BD2FF),
              Color.fromARGB(255, 124, 241, 175),
          //  Color.fromABRGB(255, 244, 191, 77), 
          // Color(0xFF22c1c3),
          
            
          
          ])
        ),
        child:  Visibility(
          visible: isLoaded,
          replacement: const Center(child: CircularProgressIndicator()),
          child: Column(
            children: [
              Container(
                width: MediaQuery.of(context).size.width*0.85,
                height: MediaQuery.of(context).size.height*0.09,
                padding: const EdgeInsets.symmetric(
                  horizontal: 10
                ),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.3),
                  borderRadius: const BorderRadius.all(Radius.circular(
                    20
                    ),
                  )
                ),
              child: Center(
                child: TextFormField(
                  onFieldSubmitted:(String s){
                    setState(() {
                      cityname=s;
                      getCityWeather(s);
                      isLoaded=false;
                      controller.clear();
              
                    });
              
                  },
                  controller: controller,
                  cursorColor: Colors.white,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.white.withOpacity(0.7)
                  ),
                  decoration: InputDecoration(
                    hintText: 'Search City',
                    hintStyle: TextStyle(color: Colors.white.withOpacity(0.7)),
                    prefixIcon: Icon(
                      Icons.search,
                      size: 25,
                      color: Colors.white.withOpacity(0.7),
                    ),
                    border: InputBorder.none
                    
                    ),
                ),
              ),
              
              ),
              const SizedBox(height: 30,),
               Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    const Icon(Icons.pin_drop,
                    color: Colors.red,
                    size: 40,
                    ),
                    Text(
                      cityname,
                      overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 20,),
              Container(
                width: double.infinity,
              height: MediaQuery.of(context).size.height*0.12,
              margin: const EdgeInsets.symmetric(
                vertical: 10,
              ),
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(15),
                ),
                color: Colors.white,
                boxShadow: [BoxShadow(
                  color: Colors.grey.shade900,offset: const Offset(1,2),
                  blurRadius: 3,
                  spreadRadius: 1
                )
                ]
              ),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.network('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS6J8-eizzJF_7PFW1LidOLa7jbfBm84znC-w&usqp=CAU',
                    width: MediaQuery.of(context).size.width*0.09,
                    height: MediaQuery.of(context).size.height*0.05,
                    ),
                  ),
                  Text(
                    'Temperature: ${temp.toStringAsFixed(2)}℃',
                    style: const TextStyle(fontSize: 20,
                    fontWeight: FontWeight.w600),
                  )
                  
                ],
              ),
              ),
                Container(
                width: double.infinity,
              height: MediaQuery.of(context).size.height*0.12,
              margin: const EdgeInsets.symmetric(
                vertical: 10,
              ),
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(15),
                ),
                color: Colors.white,
                boxShadow: [BoxShadow(
                  color: Colors.grey.shade900,offset: const Offset(1,2),
                  blurRadius: 3,
                  spreadRadius: 1
                )
                ]
              ),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.network('https://www.jqueryscript.net/images/flat-barometer.jpg?v3',
                    width: MediaQuery.of(context).size.width*0.10,
                    height: MediaQuery.of(context).size.height*0.05,
                    ),
                  ),
                  Text(
                    'Pressure: ${press.toInt()} hPa',
                    style: const TextStyle(fontSize: 20,
                    fontWeight: FontWeight.w600),
                  )
                  
                ],
              ),
              ), Container(
                width: double.infinity,
              height: MediaQuery.of(context).size.height*0.12,
              margin: const EdgeInsets.symmetric(
                vertical: 10,
              ),
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(15),
                ),
                color: Colors.white,
                boxShadow: [BoxShadow(
                  color: Colors.grey.shade900,offset: const Offset(1,2),
                  blurRadius: 3,
                  spreadRadius: 1
                )
                ]
              ),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.network('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSXrzXJwtpLQBYxeShwM3qymEH9cd8Bv_VnbQ&usqp=CAU',
                    width: MediaQuery.of(context).size.width*0.09,
                    height: MediaQuery.of(context).size.height*0.05,
                    ),
                  ),
                  Text(
                    'Humidity: ${hum.toInt()}%',
                    style: const TextStyle(fontSize: 20,
                    fontWeight: FontWeight.w600),
                  )
                  
                ],
              ),
              ),
               Container(
                width: double.infinity,
              height: MediaQuery.of(context).size.height*0.12,
              margin: const EdgeInsets.symmetric(
                vertical: 10,
              ),
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(15),
                ),
                color: Colors.white,
                boxShadow: [BoxShadow(
                  color: Colors.grey.shade900,offset: const Offset(1,2),
                  blurRadius: 3,
                  spreadRadius: 1
                )
                ]
              ),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.network('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTa28hwqAwlMmRwF97MyiqN3xWMJ9QPc91Alg&usqp=CAU',
                    width: MediaQuery.of(context).size.width*0.09,
                    height: MediaQuery.of(context).size.height*0.05,
                    ),
                  ),
                  Text(
                    'Cloud Cover: ${cover.toInt()}%',
                    style: const TextStyle(fontSize: 20,
                    fontWeight: FontWeight.w600),
                  )
                  
                ],
              ),
              ),
            ],
          ),
        ),
        ),
      ));
      
  }
  getCurrentLocation() async{
   var p=await Geolocator.getCurrentPosition(
    desiredAccuracy: LocationAccuracy.low,
    forceAndroidLocationManager: true,
   );
   if (p!=null) {
     print('Lat:${p.latitude}, Long:${p.longitude}');
     getCurrentCityWeather(p);
   }else{
    print('Data unavailable');
   }

  }
  getCurrentCityWeather(Position position) async{
   var client = http.Client();
   var uri='${k.domain}lat=${position.latitude}&lon=${position.longitude}&appid=${k.apikey}';
   var url=Uri.parse(uri);
   var response=await client.get(url);
   if (response.statusCode==200) {
     var data=response.body;
     var decodeData=json.decode(data);
     print(data);
     updateUI(decodeData);
     setState(() {
      isLoaded=true;
     });
   }else{
    print(response.statusCode);
   }
  }
   
   getCityWeather(String  cityname) async{
    var client = http.Client();
   var uri='${k.domain}q=$cityname&appid=${k.apikey}';
   var url=Uri.parse(uri);
   var response=await client.get(url);
   if (response.statusCode==200) {
     var data=response.body;
     var decodeData=json.decode(data);
     print(data);
     updateUI(decodeData);
       setState(() {
      isLoaded=true;
     });
   }else{
    print(response.statusCode);
   }

   }
   updateUI( var decodeData){
    setState(() {
       if (decodeData==null) {
      temp;
      press;
      hum;
      cover;
      cityname='Not available';
      
    }else{
     temp=decodeData['main']['temp']-273;
      press=decodeData['main']['pressure'];
      hum=decodeData['main']['humidity'];
      cover=decodeData['clouds']['all'];
      cityname=decodeData['name'];
    }
    });
   

  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  }


  

  
