import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:namma_metro/Pages/Home/home.dart';
import 'package:namma_metro/Pages/Profile_Menu/profile_menu.dart';
import 'package:namma_metro/Pages/top_app_bar.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:upi_india/upi_india.dart';

class PaymentInit extends StatefulWidget {
  final double amount;
  final String metroCard, source;
  final Map<String, dynamic> passedVals;

  const PaymentInit({
    super.key,
    required this.amount,
    required this.metroCard,
    required this.passedVals,
    required this.source
  });

  @override
  State<PaymentInit> createState() => _PaymentInitState();
}

class _PaymentInitState extends State<PaymentInit> {
  final UpiIndia _upi = UpiIndia();
  List<UpiApp>? apps;

  TextStyle header = GoogleFonts.rajdhani(
    fontSize: 24,
    fontWeight: FontWeight.bold
  );
  @override
  void initState() {
    _upi.getAllUpiApps(mandatoryTransactionId: false).then((value) {
      setState(() {
        apps = value;
      });
    }).catchError((e) {
      apps = [];
    });
    super.initState();
  }

  Widget displayApps(){
    if(apps == null){
      return const Center(
        child: CircularProgressIndicator()
      );
    }
    else if (apps!.isEmpty){
      return Center(
        child: Text("No App is setup!", style: header),
      );
    }
    else{
      return Align(
        alignment: Alignment.topCenter,
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 60, horizontal: 15),
            child: Wrap(
              children: apps!.map<Widget>((UpiApp app) {
                return GestureDetector(
                  onTap: () async{
                    await initiateTransaction(app)
                    .then((res) async {
                      String? transId = res.transactionId;
                      String? approvalRefNumber = res.approvalRefNo;
                      String? transRefId = res.transactionRefId;
                      String? status = res.status;
                      Map<String, dynamic> data = {
                        "user_id": FirebaseAuth.instance.currentUser!.uid,
                        "trans_amount": widget.amount,
                      };
                      if(status == UpiPaymentStatus.FAILURE){
                        if(widget.passedVals["source"] == "SmartCard"){
                          var extend = {
                            "trans_id": transId,
                            "approval_ref_number": approvalRefNumber,
                            "trans_ref_id": transRefId,
                            "metro_card_number": widget.metroCard
                          };
                          data.addAll(extend.cast<String, Object>());
                          await FirebaseFirestore.instance.collection("transaction_history").doc().set(data)
                          .then((res) {
                            Navigator.popUntil(context, (route) => false);
                            // PersistentNavBarNavigator()
                            PersistentNavBarNavigator.pushNewScreenWithRouteSettings(context, screen:   const ProfileMenu(), settings: const RouteSettings(name: "/home"),);
                          });
                        }
                        else{
                          // var url = Uri.parse("https://api.qrserver.com/v1/create-qr-code/?data=${DateTime.now().millisecondsSinceEpoch}&amp;size=100x100");
                          // await http.get(url).then((res) {
                          //   if(res.statusCode == 200){
                          //     var data = jsonDecode(res.body);
                          //     log(res.body);
                          //   }
                          //   else{
                          //     showDialog(
                          //       context: context,
                          //       builder: (context) {
                          //         return AlertDialog(
                          //           title: Text(
                          //             'FAILED TO FETCH QR CODE!',
                          //             style: GoogleFonts.rajdhani(
                          //                 fontSize: 30,
                          //                 fontWeight: FontWeight.bold
                          //             ),
                          //           ),
                          //           shape: RoundedRectangleBorder(
                          //             borderRadius: BorderRadius.circular(10.0),
                          //           ),
                          //           backgroundColor: Colors.redAccent,
                          //         );
                          //       },
                          //     );
                          //   }
                          // });

                          var extend = {
                            "source_station": widget.passedVals["source_station"],
                            "destination_station": widget.passedVals["destination_station"],
                            "date_and_time": DateTime.now(),
                            "valid_till": DateTime.now().add(const Duration(minutes: 45)),
                            "qr_url": "xyz"
                          };
                          data.addAll(extend);
                          await FirebaseFirestore.instance.collection("tickets").doc().set(data)
                              .then((res) {
                            Navigator.popUntil(context, (route) => false);
                            PersistentNavBarNavigator.pushNewScreen(context, screen: const HomePage());
                          });
                        }
                      }
                      else if(status == UpiPaymentStatus.SUBMITTED){
                        return const Center(child: CircularProgressIndicator());
                      }
                      else{
                        Future.delayed(
                          const Duration(seconds: 5),
                          () {
                            Navigator.popUntil(context, (route) => false);
                            PersistentNavBarNavigator.pushNewScreen(context, screen: const ProfileMenu());
                          },
                        );
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              backgroundColor: Colors.redAccent,
                              title: Text(
                                'PAYMENT FAILURE',
                                style: GoogleFonts.rajdhani(
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold
                                ),
                              ),
                              content: SizedBox(
                                // Specify width and height constraints here
                                width: 200.0, // Set your desired width
                                height: 150.0, // Set your desired height
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      'Your Payment Failed for some reason, please try again later',
                                      style: GoogleFonts.rajdhani(
                                        fontSize: 24,
                                        fontWeight: FontWeight.w600
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }
                        );
                      }
                    });
                    setState(() {});
                  },
                  child: SizedBox(
                    height: 100,
                    width: 100,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget> [
                        Image.memory(
                          app.icon,
                          height: 60,
                          width: 60,
                        ),
                        Text(
                          app.name,
                          style: GoogleFonts.rajdhani(
                            fontSize: 20,
                            fontWeight: FontWeight.bold
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ),
      );
    }
  }

  Future<UpiResponse> initiateTransaction(UpiApp app) async {
    return _upi.startTransaction(
      app: app,
      receiverUpiId: "nidhimn48@oksbi",
      receiverName: 'Pulkit Raina',
      transactionRefId: DateTime.now().millisecondsSinceEpoch.toString(),
      transactionNote: 'Trial Transaction!',
      amount: widget.amount,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      appBar: CustomTopAppBar(
        text: "Payment",
        show: true,
        context: context,
      ),
      body: Center(
        child: Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(20)),
            boxShadow: [
              BoxShadow(
                color: Colors.black,
                offset: Offset(0, 2),
                blurRadius: 15
              )
            ],
            color: Color.fromRGBO(65, 48, 166, 0.9019607843137255),
          ),
          child: displayApps(),
        ),
      ),
    );
  }
}
