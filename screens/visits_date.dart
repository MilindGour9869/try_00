import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter_app/default.dart';
import 'package:flutter_app/widgets/add_visits.dart';
import 'package:flutter_app/classes/Patient_name_list.dart';

import 'package:date_format/date_format.dart';


class VisitsDate extends StatefulWidget {


  Patient_name_data_list patient_data;








  VisitsDate(this.patient_data);

  @override
  _VisitsDateState createState() => _VisitsDateState();
}

class _VisitsDateState extends State<VisitsDate> {

  Future f;

  List<Patient_name_data_list> visits_instance_list=[];

  List<String> visit_dates=[];

  bool delete = false;









  Future<dynamic> visist_date()async{

    FirebaseFirestore.instance.collection('Patient').doc(widget.patient_data.doc_id).collection('visits').get().then((QuerySnapshot querySnapshot){

      visits_instance_list=[];

      visit_dates=[];


      querySnapshot.docs.forEach((element) {


        print(element.data());

        //visits_instance_list.add(Patient_name_data_list.visits(element.data()));

        Map<String,dynamic> map = element.data();
        print(map['visit_date']);



        
        widget.patient_data.Visit_Map_Data(map: element.data() , visit_date:formatDate(map['visit_date'].toDate(), [ dd, '-', mm, '-', yyyy]).toString()  );
        
        visit_dates.add(formatDate(map['visit_date'].toDate(), [ dd, '-', mm, '-', yyyy]).toString());


        
        print(widget.patient_data.hashCode);
        

        

      });


     setState(() {
       visit_dates=visit_dates;

     });





    } );
  }




















  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    print(widget.patient_data.doc_id);
    f=visist_date();

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: Text('Visits'),
        backgroundColor: AppTheme.teal,

        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: IconButton(onPressed: (){

              setState(() {
                delete=!delete;

              });
            }, icon: Icon(Icons.delete_outline_outlined)),
          )
        ],
      ),
      body: SingleChildScrollView(

        child: FutureBuilder(
          future: f,
          builder: (context,snapshot){

            if(snapshot.connectionState==ConnectionState.waiting)
              {
                return CircularProgressIndicator();

              }

            if(visit_dates.isEmpty)
              {
                return Text('loading');

              }


            if(visit_dates.isNotEmpty)
              {
                return Center(
                  child: RefreshIndicator(
                    onRefresh: visist_date,
                    child: Wrap(
                        spacing: 10,
                        runSpacing: 10,
                        direction: Axis.horizontal,


                        children:visit_dates.map((date) {





                          return SizedBox(

                              child: GestureDetector(
                                onTap: (){
                                  Navigator.push(context , MaterialPageRoute(builder: (context)=>AddVisits(

                                    visit_date: date.toString(),

                                    icon_tap: false,

                                    patient_data: widget.patient_data,

                                    map: widget.patient_data.visits_mapData_list[date],

                                  ))).then((value) {

                                  });


                                },


                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    SizedBox(
                                      height: 120,
                                      width: 120,
                                      child: Card(


                                          child: Center(child: Text(date.toString()),
                              )),
                                    ),

                                    Visibility(
                                      visible: delete,
                                      child: CircleAvatar(
                                        backgroundColor: AppTheme.white,
                                        child: IconButton(onPressed: ()async{

                                          widget.patient_data.visits_mapData_list.remove(date);
                                          setState(() {
                                            visit_dates.remove(date);

                                          });


                                          await FirebaseFirestore.instance.collection('Patient').doc(widget.patient_data.doc_id).collection('visits').doc(date).delete();




                                        }, icon: Icon(Icons.delete_outline_outlined , color: Colors.red,)
                                        ),
                                      ),
                                    )],
                                )));
                        }).toList()),
                  ),
                );
              }

            else
              {
                return Text('aerror');

              }

          },
        )
      ),

      floatingActionButton: FloatingActionButton(
        elevation: 15,

        splashColor: AppTheme.notWhite,
        onPressed: (){
          Navigator.push(context , MaterialPageRoute(builder: (context)=>AddVisits(

              icon_tap: true,

              patient_data: widget.patient_data,

              visit_date: formatDate(Timestamp.now().toDate(), [ dd, '-', mm, '-', yyyy]).toString(),



          ))).then((value) {
             print("ascdve");
            if(value == 'save')
              {
                visist_date();
              }
          });
        },
        child: Icon(Icons.add , color: Colors.black,),
        backgroundColor: AppTheme.green,
      ),
      bottomNavigationBar: BottomAppBar(

        color: AppTheme.white,
        child: Container(
          height:MediaQuery.of(context).size.height*0.08,


        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
