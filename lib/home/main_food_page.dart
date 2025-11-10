
/****
    import 'package:flutter/material.dart'
Day la thu vien chinh chay cho android va ios moi nguoi la chu y su dung thu vien cho chinh xacs
anh co thay doi 1 so thu vien moi nguoi nho doc ky thu vien truoc khi dung
**/
import 'package:flutter/material.dart';
class MainFoodPage  extends StatefulWidget {
  const MainFoodPage({Key? key}): super(key: key);

  @override
   _MainFoodPageState createState() => _MainFoodPageState();
}

class _MainFoodPageState extends State<MainFoodPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(


      /*Day la noi dung CHinh cua main food no chu het tat ca nhung thong tin lien quan den main food*/
      body: Column(
        children: [

          /**Header **/
          Container(

            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween ,
              children: [
                Column(
                  children: [
                    Text('ABCD'),
                    Text('EEEEEEEE'),
                  ],


                ),
                Container(
                  width: 45,
                  height: 45,
                  child: Icon(Icons.search, color: Colors.white,),
                  decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(15)
                  ),

                )

              ],

            ),
          ),



          /**Slug **/
          Container(),

        ],



      ),

    );
  }
}

