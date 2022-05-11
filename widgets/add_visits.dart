import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:flutter_app/default.dart';

import 'package:flutter_app/list_search/list_search.dart';
import 'package:flutter_app/list_search/notes_list_search.dart';
import 'package:flutter_app/storage/storage.dart';
import 'package:flutter_app/widgets/Printer_Select_list.dart';
import 'package:flutter_app/widgets/Tile.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../list_search/vital_list_search.dart';
import 'package:flutter_app/widgets/list_search.dart';
import 'package:flutter_app/classes/Patient_name_list.dart';

import 'package:date_format/date_format.dart';
import 'package:flutter_app/widgets/service_search_list.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../screens/Medicines.dart';

class AddVisits extends StatefulWidget {
  Patient_name_data_list patient_data;

  Timestamp visit_date;

  Map<String, dynamic> map;

  bool icon_tap;

  AddVisits(
      {this.map, this.visit_date, this.icon_tap = false, this.patient_data});

  @override
  _AddVisitsState createState() => _AddVisitsState();
}

class _AddVisitsState extends State<AddVisits> {
  String complaints = "Complaints";
  String diagnosis = "Diagnosis";
  String advices = "Advices";
  String investigation = "Investigation";
  String allergies = "Allergies";
  String clinical_finding = "Clinical Finding";
  String group = "Group";

  String service = "Services";
  String medicine = "Medicine";
  String vital = "Vitals";
  String notes = 'Notes';

  String blood_group = "";

  String img_complaint = 'images/complaint_color.webp';
  String img_clinical_finding_color = 'images/clinical_finding_color.png';
  String img_diagnosis = 'images/diagnosis.webp';
  String img_medicine_color = 'images/medicine_color.webp';
  String img_vital_color = 'images/vital_color.webp';
  String img_investigation_color = 'images/investigation_color.webp';

  //10
  List Complaint = [];
  List Diagnosis = [];
  List Advices = [];
  List Investigation = [];
  List Allergies = [];
  List Clinical_finding = [];
  List Group = [];

  List Services = [];
  List<String> Medicine = [];
  List Notes = [];


  Map<String, Map<String, dynamic>> medicine_result = {};
  Map<String, Map<String, dynamic>> service_result = {};
  Map<String, Map<String, dynamic>> vital_result = {};

  Map<String, dynamic> map;

  String visit_date;
  String follow_up_date;
  Timestamp followUp_date;


  Timestamp date;


  int total_charge = 0;


  dynamic set(List<String> list, Map<String, dynamic> map, String name) {
    if (list.isNotEmpty) {
      map[name] = list;
      return map;
    }
  }

  Widget DropDown(String menu) {
    return Text(
      menu,
      textScaleFactor: AppTheme.list_tile_subtile,
    );
  }





  void Prnt() {
    print(Complaint);
    print(Clinical_finding);
  }



  void setdata() {
    setState(() {
      // Complaint = map['complaint'];

      if (map['complaint'] != null) {
        Complaint = map['complaint'];
      }

      if (map['notes'] != null) {
        Notes = map['notes'];
      }

      if (map['investigation'] != null) {
        Investigation = map['investigation'];
      }
      if (map['diagnosis'] != null) {
        Diagnosis = map['diagnosis'];
      }
      if (map['advices'] != null) {
        Advices = map['advices'];
      }
      if (map['group'] != null) {
        Group = map['group'];
      }

      if (map['allergies'] != null) {
        Allergies = map['allergies'];
      }
      if (map['service'] != null) {
        Services = map['service'].keys.toList();
        service_result = Map<String, Map<String, dynamic>>.from(map['service']);



      }
      if (map['clinical_finding'] != null) {
        Clinical_finding = map['clinical_finding'];
      }
      if (map['medicine'] != null) {
        print('in medicine');

        medicine_result = Map<String, Map<String, dynamic>>.from(map['medicine']);


      }
      if (map['vitals'] != null) {
        vital_result = map['vitals'];
      }

      if(map['follow_up_date'] != null)
        {
          followUp_date = map['follow_up_date'];
          follow_up_date = formatDate(followUp_date.toDate(), [ dd, '-', mm, '-', yyyy]).toString();

        }

      if(map['total_charge'] !=null)
        {
          total_charge = map['total_charge'];

        }

    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    if (widget.patient_data.blood_group != null) {
      blood_group = widget.patient_data.blood_group;
    }

    print(widget.patient_data.hashCode);

    if (widget.map != null) {
      print(widget.map);

      map = widget.map;

      print('\ninit');

      print(map);

      setdata();
    } else {
      print('add visit init else ');
    }

    visit_date = formatDate(widget.visit_date.toDate(), [ dd, '-', mm, '-', yyyy]).toString();
  }

  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaleFactor: 1),
      child: Scaffold(
        backgroundColor: AppTheme.notWhite,
        appBar: AppBar(
          backgroundColor: AppTheme.teal,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              size: AppTheme.icon_size,
            ),
            onPressed: () {
              Navigator.pop(context, 'back');
            },
          ),
          title: Text(
            'Add Visits',
          ),
          actions: [
            IconButton(
                onPressed: () {
                  Map<String, dynamic> patient_detail = {
                    'patient_name': widget.patient_data.name,
                    'patient_gender': widget.patient_data.gender == null
                        ? ""
                        : widget.patient_data.gender.isNotEmpty
                            ? widget.patient_data.gender
                            : "",
                    'patient_age': widget.patient_data.age == null
                        ? ""
                        : widget.patient_data.age.toString(),
                    'patient_mobile': widget.patient_data.mobile == null
                        ? ""
                        : widget.patient_data.mobile.toString(),
                    'address': widget.patient_data.address == null
                        ? ""
                        : widget.patient_data.address.isNotEmpty
                            ? widget.patient_data.address
                            : "",
                    'patient_blood_group':
                        widget.patient_data.blood_group == null
                            ? ""
                            : widget.patient_data.blood_group.isNotEmpty
                                ? widget.patient_data.blood_group
                                : "",
                  };

                  showDialog(
                      context: context,
                      builder: (context) {
                        return Printer_Select_List(
                          map_list: {
                            'Visit Date': visit_date,
                            'UID': widget.patient_data.uid,
                            'Patient Detail': patient_detail,
                            'Vitals': vital_result,
                            'Complaint': Complaint,
                            'Investigation': Investigation,
                            'Clinical Finding': Clinical_finding,
                            'Notes': Notes,
                            'Diagnosis': Diagnosis,
                            'Allergies': Allergies,
                            'Advices': Advices,
                            'Group': Group,
                            'Medicine': medicine_result,
                            'Follow up date': follow_up_date,
                          },
                          doc_id: widget.patient_data.doc_id,
                        );
                      });
                  Prnt();
                },
                icon: Icon(Icons.print_outlined)),
            Padding(
              padding: EdgeInsets.only(right: 1.w),
              child: IconButton(
                  onPressed: () {
                    var visit_doc = FirebaseFirestore.instance
                        .collection('Patient')
                        .doc(widget.patient_data.doc_id)
                        .collection('visits')
                        .doc(visit_date);
                    var patient_doc = FirebaseFirestore.instance
                        .collection('Patient')
                        .doc(widget.patient_data.doc_id);

                    Map<String, dynamic> map = {};

                    print('ffffeergre');


                    print(Complaint);


                    if (Complaint.isNotEmpty) {
                      map['complaint'] = Complaint;
                    }
                    if(Notes.isNotEmpty)
                      {
                        map['notes'] = Notes;
                      }
                    if (Investigation.isNotEmpty) {
                      map['investigation'] = Investigation;
                    }
                    if (Diagnosis.isNotEmpty) {
                      map['diagnosis'] = Diagnosis;
                    }
                    if (Advices.isNotEmpty) {
                      map['advices'] = Advices;
                    }
                    if (Group.isNotEmpty) {
                      map['group'] = Group;
                    }

                    if (Allergies.isNotEmpty) {
                      map['allergies'] = Allergies;
                    }
                    if (service_result.isNotEmpty) {
                      map['service'] = service_result;
                    }
                    if (Clinical_finding.isNotEmpty) {
                      map['clinical_finding'] = Clinical_finding;
                    }
                    if(medicine_result.isNotEmpty)
                      {
                        map['medicine']=medicine_result;
                      }
                    if(vital_result.isNotEmpty)
                      {
                        map['vitals'] = vital_result;

                      }
                    if(followUp_date != null)
                      {
                        map['follow_up_date'] = followUp_date;
                      }
                    map['total_charge'] = total_charge;




                    widget.patient_data.visits_mapData_list[visit_date] = map;

                    if (widget.icon_tap==true) {
                      map['visit_date'] =  Timestamp.now();
                      patient_doc.update({
                        'recent_visit': Timestamp.now(),
                        'blood_group':
                            blood_group == 'Blood Group' ? "" : blood_group
                      });

                      if(blood_group != 'Blood Group')
                        {
                          widget.patient_data.blood_group = blood_group;

                        }
                    }
                    else
                      {
                        map['visit_date'] = widget.visit_date;
                        patient_doc.update({
                          'recent_visit': widget.visit_date,
                          'blood_group':
                          blood_group == 'Blood Group' ? "" : blood_group
                        });
                        if(blood_group != 'Blood Group')
                        {
                          widget.patient_data.blood_group = blood_group;

                        }
                      }

                    visit_doc.set(map);

                    Navigator.pop(context, 'save');
                  },
                  icon: Icon(
                    Icons.save,
                    size: AppTheme.icon_size,
                  )),
            )
          ],
        ),
        body: SingleChildScrollView(
          child: Center(
            child: Container(
              color: Colors.transparent,
              // height: MediaQuery.of(context).size.height*0.9,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                      height: MediaQuery.of(context).size.height * 0.08,
                      width: 40.w,
                      child: Card(
                          child: Center(
                              child: TextButton(
                        child: Text(
                          '${visit_date}',
                          style: TextStyle(color: Colors.black),
                        ),
                        onPressed: () {
                          showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(1947),
                                  lastDate: DateTime(2050))
                              .then((value) {
                            print(value);
                            setState(() {
                              date = Timestamp.fromDate(value);

                              visit_date = formatDate(
                                  Timestamp.fromDate(value).toDate(),
                                  [dd, '-', mm, '-', yyyy]).toString();
                            });
                          });
                        },
                      )))), //date

                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 1.w, vertical: 1.h),
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 2.w),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                              height: MediaQuery.of(context).size.height * 0.08,
                              width: 45.w,
                              child: Card(
                                  elevation: 1,
                                  child: Center(
                                      child: TextButton.icon(
                                    icon: Icon(
                                      FontAwesomeIcons.droplet,
                                      color: Colors.red,
                                    ),
                                    label: Text(
                                      blood_group.isEmpty
                                          ? "Blood Group"
                                          : blood_group,
                                      style: TextStyle(color: Colors.black),
                                    ),
                                    onPressed: () {
                                      showDialog(
                                          context: context,
                                          builder: (context) => List_Search(
                                                result: [blood_group],
                                                get: Storage.get,
                                                set: Storage.set,
                                                one_select: true,
                                                group: 'blood_group',
                                                Group: 'Blood_Group',
                                                ky: 'blood_group',
                                              )).then((value) {
                                        if (value != null) {
                                          if (value.isNotEmpty) {
                                            setState(() {
                                              blood_group = value[0].toString();
                                            });
                                          }
                                        }
                                      });
                                    },
                                  )))),
                          SizedBox(
                              height: MediaQuery.of(context).size.height * 0.08,
                              child: Card(
                                  elevation: 1,
                                  child: Center(
                                      child: TextButton.icon(
                                    icon: Icon(Icons.timelapse_rounded),
                                    label: Text(
                                      follow_up_date == null
                                          ? 'Follow Up Date'
                                          : follow_up_date,
                                      style: TextStyle(color: Colors.black),
                                    ),
                                    onPressed: () {
                                      showDatePicker(
                                              context: context,
                                              initialDate: DateTime.now(),
                                              firstDate: DateTime(1947),
                                              lastDate: DateTime(2050))
                                          .then((value) {
                                        print(value);
                                        setState(() {


                                          follow_up_date = formatDate(
                                                  Timestamp.fromDate(value)
                                                      .toDate(),
                                                  [dd, '-', mm, '-', yyyy])
                                              .toString();
                                          followUp_date = Timestamp.fromDate(value);
                                        });
                                      });
                                    },
                                  )))),
                        ],
                      ),
                    ),
                  ),

                  Padding(
                    padding:  EdgeInsets.all(1.w),
                    child: Material(
                      borderRadius: BorderRadius.circular(10),
                      elevation: 2,


                      child: ListTile(

                        title: Padding(
                          padding:  EdgeInsets.only(top: 1.w),
                          child: Text(complaints , ),
                        ),
                        leading: Image.asset(img_complaint),

                        trailing: IconButton(onPressed: ()async{



                          print(widget.patient_data.visits_mapData_list);


                          showDialog(
                              context: context,
                              builder: (context)  {



                                return  List_Search(result: Complaint, get: Storage.get, set: Storage.set, group: 'complaint', Group: 'Complaint', one_select: false, ky: 'complaint');}
                          ).then((value)async{

                            print(value);

                            if(value != null)
                            {
                              setState(() {
                                Complaint = value;
                              });


                            }
                          });










                        }, icon: Icon(Icons.arrow_drop_down_circle_outlined , color: Colors.black,)),

                        subtitle: Padding(
                          padding:  EdgeInsets.only(top: 1.w),
                          child: Container(

                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: Complaint.map<Widget>((e)=>DropDown(e) ).toList(),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ), // Complaint

                  Padding(
                    padding:  EdgeInsets.all(1.w),
                    child: Material(
                      borderRadius: BorderRadius.circular(10),
                      elevation: 2,


                      child: ListTile(

                        title: Padding(
                          padding:  EdgeInsets.only(top: 1.w),
                          child: Text(notes , ),
                        ),
                        leading: Icon(Icons.note),

                        trailing: IconButton(onPressed: ()async{



                          print(widget.patient_data.visits_mapData_list);


                          showDialog(
                              context: context,
                              builder: (context)  {



                                return  List_Search(result: Notes, get: Storage.get, set: Storage.set, group: 'notes', Group: 'Notes', one_select: false, ky: 'notes');


                              }

                          ).then((value)async{

                            print(value);

                            if(value != null)
                            {
                              setState(() {
                                Notes = value;
                              });


                            }
                          });










                        }, icon: Icon(Icons.arrow_drop_down_circle_outlined , color: Colors.black,)),

                        subtitle: Padding(
                          padding:  EdgeInsets.only(top: 1.w),
                          child: Container(

                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: Notes.map<Widget>((e)=>DropDown(e) ).toList(),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ), // Notes


                  Padding(
                    padding:  EdgeInsets.all(1.w),
                    child: Material(
                      borderRadius: BorderRadius.circular(10),
                      elevation: 2,


                      child: ListTile(

                        title: Padding(
                          padding:  EdgeInsets.only(top: 1.w),
                          child: Text(clinical_finding , ),
                        ),
                        leading: SizedBox(
                            width: 50,
                            height: 50,
                            child: Image.asset(img_clinical_finding_color ,)),

                        trailing: IconButton(onPressed: ()async{



                          // print(formatDate(widget.data.visit_date.toDate(),[dd, '-', mm, '-', yyyy]).toString());

                          print('ddd');


                          print(widget.patient_data.visits_mapData_list[visit_date]);



                          showDialog(
                              context: context,
                              builder: (context)  {



                                return  List_Search(result: Clinical_finding, get: Storage.get, set: Storage.set, group: 'clinical_finding', Group: 'Clinical_finding', one_select: false, ky: 'clinical_finding');}
                          ).then((value)async{

                            print(value);

                            if(value != null)
                            {
                              setState(() {
                                Clinical_finding = value;
                              });


                            }
                          });










                        }, icon: Icon(Icons.arrow_drop_down_circle_outlined , color: Colors.black,)),

                        subtitle: Padding(
                          padding:  EdgeInsets.only(top: 1.w),
                          child: Container(

                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: Clinical_finding.map<Widget>((e)=>DropDown(e) ).toList(),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ), // Clinical Finding

                  Padding(
                    padding:  EdgeInsets.all(1.w),
                    child: Material(
                      borderRadius: BorderRadius.circular(10),
                      elevation: 2,


                      child: ListTile(



                        title: Padding(
                          padding:  EdgeInsets.only(top: 1.w),
                          child: Text(diagnosis , ),
                        ),
                        leading: Image.asset(img_diagnosis),

                        trailing: IconButton(onPressed: ()async{



                          // print(formatDate(widget.data.visit_date.toDate(),[dd, '-', mm, '-', yyyy]).toString());


                          showDialog(
                              context: context,
                              builder: (context)  {



                                return  List_Search(result: Diagnosis, get: Storage.get, set: Storage.set, group: 'diagnosis', Group: 'Diagnosis', one_select: false, ky: 'diagnosis');
}

    ).then((value)async{

                            print(value);

                            if(value != null)
                            {
                              setState(() {
                                Diagnosis = value;
                              });


                            }
                          });










                        }, icon: Icon(Icons.arrow_drop_down_circle_outlined , color: Colors.black,)),

                        subtitle: Padding(
                          padding:  EdgeInsets.only(top: 1.w),
                          child: Container(

                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: Diagnosis.map<Widget>((e)=>DropDown(e) ).toList(),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ), // Diagnosis

                  Padding(
                    padding:  EdgeInsets.all(1.w),
                    child: Material(
                      borderRadius: BorderRadius.circular(10),
                      elevation: 2,


                      child: ListTile(




                        title: Padding(
                          padding:  EdgeInsets.only(top: 1.w),
                          child: Text(investigation , ),
                        ),
                        leading: Image.asset(img_investigation_color),

                        trailing: IconButton(onPressed: ()async{



                          // print(formatDate(widget.data.visit_date.toDate(),[dd, '-', mm, '-', yyyy]).toString());


                          showDialog(
                              context: context,
                              builder: (context)  {



                                return  List_Search(result: Investigation, get: Storage.get, set: Storage.set, group: 'investigation', Group: 'Investigation', one_select: false, ky: 'investigation');
                              }
                          ).then((value)async{

                            print(value);

                            if(value != null)
                            {
                              setState(() {
                                Investigation = value;
                              });


                            }
                          });










                        }, icon: Icon(Icons.arrow_drop_down_circle_outlined , color: Colors.black,)),

                        subtitle: Padding(
                          padding:  EdgeInsets.only(top: 1.w),
                          child: Container(

                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: Investigation.map<Widget>((e)=>DropDown(e) ).toList(),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ), // Investigation

                  Padding(
                    padding:  EdgeInsets.all(1.w),
                    child: Material(
                      borderRadius: BorderRadius.circular(10),
                      elevation: 2,


                      child: ListTile(

                        title: Padding(
                          padding:  EdgeInsets.only(top: 1.w),
                          child: Text(allergies , ),
                        ),
                        leading: Icon(Icons.add , size: AppTheme.icon_size,),

                        trailing: IconButton(onPressed: ()async{



                          // print(formatDate(widget.data.visit_date.toDate(),[dd, '-', mm, '-', yyyy]).toString());


                          showDialog(
                              context: context,
                              builder: (context)  {



                                return List_Search(result: Allergies, get: Storage.get, set: Storage.set, group: 'allergies', Group: 'Allergies', one_select: false, ky: 'allergies');
                              }
                          ).then((value)async{

                            print(value);

                            if(value != null)
                            {
                              setState(() {
                                Allergies = value;
                              });


                            }
                          });










                        }, icon: Icon(Icons.arrow_drop_down_circle_outlined , color: Colors.black,)),

                        subtitle: Padding(
                          padding:  EdgeInsets.only(top: 1.w),
                          child: Container(

                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: Allergies.map<Widget>((e)=>DropDown(e) ).toList(),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ), // Allergies

                  Padding(
                    padding:  EdgeInsets.all(1.w),
                    child: Material(
                      borderRadius: BorderRadius.circular(10),
                      elevation: 2,


                      child: ListTile(

                        title: Padding(
                          padding:  EdgeInsets.only(top: 1.w),
                          child: Text(advices, ),
                        ),
                        leading: Icon(Icons.add),

                        trailing: IconButton(onPressed: ()async{



                          // print(formatDate(widget.data.visit_date.toDate(),[dd, '-', mm, '-', yyyy]).toString());


                          showDialog(
                              context: context,
                              builder: (context)  {



                                return  List_Search(result: Advices, get: Storage.get, set: Storage.set, group: 'advices', Group: 'Advices', one_select: false, ky: 'advices');
                              }
                          ).then((value)async{

                            print(value);

                            if(value != null)
                            {
                              setState(() {
                                Advices = value;
                              });


                            }
                          });










                        }, icon: Icon(Icons.arrow_drop_down_circle_outlined , color: Colors.black,)),

                        subtitle: Padding(
                          padding:  EdgeInsets.only(top: 1.w),
                          child: Container(

                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: Advices.map<Widget>((e)=>DropDown(e) ).toList(),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ), // Advices

                  Padding(
                    padding: EdgeInsets.all(1.w),
                    child: Material(
                      borderRadius: BorderRadius.circular(10),
                      elevation: 2,
                      child: ListTile(
                        title: Padding(
                          padding: EdgeInsets.only(top: 1.w),
                          child: Text(
                            group,
                          ),
                        ),
                        leading: Icon(Icons.add),
                        trailing: IconButton(
                            onPressed: () async {
                              // print(formatDate(widget.data.visit_date.toDate(),[dd, '-', mm, '-', yyyy]).toString());

                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    return List_Search(result: Group, get: Storage.get, set: Storage.set, group: 'group', Group: 'Group', one_select: false, ky: 'group');
                                  }).then((value) async {
                                print(value);

                                if (value != null) {
                                  setState(() {
                                    Group = value;
                                  });
                                }
                              });
                            },
                            icon: Icon(
                              Icons.arrow_drop_down_circle_outlined,
                              color: Colors.black,
                            )),
                        subtitle: Padding(
                          padding: EdgeInsets.only(top: 1.w),
                          child: Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: Group.map<Widget>((e) => DropDown(e))
                                  .toList(),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ), // Group

                  Padding(
                    padding: EdgeInsets.all(1.w),
                    child: Material(
                      borderRadius: BorderRadius.circular(10),
                      elevation: 2,
                      child: ListTile(
                        title: Padding(
                          padding: EdgeInsets.only(top: 1.w),
                          child: Text(
                            service,
                          ),
                        ),
                        leading: Icon(Icons.add),
                        trailing: IconButton(
                            onPressed: () async {
                              // print(formatDate(widget.data.visit_date.toDate(),[dd, '-', mm, '-', yyyy]).toString());

                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    return Service_Search_List(
                                      result: Services,
                                    );
                                  }).then((value) async {


                                if (value != null) {
                                  setState(() {
                                   Services = value.keys.toList();
                                   service_result = value;

                                   print('frr');
                                   print(service_result);

                                   total_charge = 0;


                                   service_result.forEach((key, value) {


                                     print(total_charge);







                                     total_charge += value['charge'];



                                   });





                                  });
                                }
                              });
                            },
                            icon: Icon(
                              Icons.arrow_drop_down_circle_outlined,
                              color: Colors.black,
                            )),
                        subtitle: Padding(
                          padding: EdgeInsets.only(top: 1.w),
                          child: Container(
                            child: Column(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: service_result.keys.map((e) {
                                    return Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(e[0].toUpperCase() + e.substring(1)),

                                        Text('₹ ${service_result[e]['charge'].toString()}' )
                                      ],
                                    );
                                  }).toList(),
                                ),
                                Divider(
                                  thickness: 1.2,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('Total Charge'),
                                    Text('₹ ${total_charge.toString()}' )
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),

                  Padding(
                    padding: EdgeInsets.all(1.w),
                    child: Material(
                      borderRadius: BorderRadius.circular(10),
                      elevation: 2,
                      child: ListTile(
                        title: Padding(
                          padding: EdgeInsets.only(top: 1.w),
                          child: Text(
                            medicine,
                          ),
                        ),
                        leading: Icon(Icons.add),
                        trailing: IconButton(
                            onPressed: () async {
                              print(medicine_result);

                              // print(formatDate(widget.data.visit_date.toDate(),[dd, '-', mm, '-', yyyy]).toString());

                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Medicines(
                                            delete: false,
                                            name: Medicine,
                                            result_map: medicine_result,
                                          ))).then((value) {
                                print('ccc');
                                print(value);

                                if (value != null) {
                                  Medicine = [];

                                  medicine_result = value;

                                  setState(() {
                                    Medicine = medicine_result.keys.toList();
                                  });

                                  print(Medicine);
                                }
                              });
                            },
                            icon: Icon(
                              Icons.arrow_drop_down_circle_outlined,
                              color: Colors.black,
                            )),
                        subtitle: Padding(
                          padding: EdgeInsets.only(top: 1.w),
                          child: Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: medicine_result.keys.map<Widget>((e) {
                                return DropDown(e);
                              }).toList(),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),

                  Padding(
                    padding: EdgeInsets.all(1.w),
                    child: Material(
                      borderRadius: BorderRadius.circular(10),
                      elevation: 2,
                      child: ListTile(
                        title: Padding(
                          padding: EdgeInsets.only(top: 1.w),
                          child: Text(
                            vital,
                          ),
                        ),
                        leading: Icon(
                          Icons.add,
                          size: AppTheme.icon_size,
                        ),
                        trailing: IconButton(
                            onPressed: () async {
                              // print(formatDate(widget.data.visit_date.toDate(),[dd, '-', mm, '-', yyyy]).toString());

                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    return Vital_List_Search(
                                      result: vital_result,
                                    );
                                  }).then((value) async {
                                print('dsdsds');

                                print(value);

                                if (value != null) {
                                  setState(() {
                                    vital_result = value;
                                  });
                                }
                              });
                            },
                            icon: Icon(
                              Icons.arrow_drop_down_circle_outlined,
                              color: Colors.black,
                            )),
                        subtitle: Padding(
                          padding: EdgeInsets.only(top: 1.w),
                          child: Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: vital_result.keys.map<Widget>((e) {
                                return Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      vital_result[e]['vital_name'],
                                      textScaleFactor:
                                          AppTheme.list_tile_subtile,
                                    ),
                                    Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text(
                                          vital_result[e]['value'],
                                          textScaleFactor:
                                              AppTheme.list_tile_subtile,
                                        ),
                                        SizedBox(
                                          width: 0.5.w,
                                        ),
                                        Text(
                                          vital_result[e]['vital_unit'],
                                          textScaleFactor:
                                              AppTheme.list_tile_subtile,
                                        ),
                                      ],
                                    )
                                  ],
                                );
                              }).toList(),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ), // Vital
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}


