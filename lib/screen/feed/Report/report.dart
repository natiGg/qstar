import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:qstar/controllers/getreportcontroller.dart';
import 'package:qstar/screen/feed/model/user.dart';
import 'package:settings_ui/settings_ui.dart';
import 'package:qstar/constant.dart';

class ReportScreen extends StatefulWidget {
  final int? postid;

  const ReportScreen({required this.postid});

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

GeteportCategoryController getReportCategory =
    Get.put(GeteportCategoryController());

class _SettingsScreenState extends State<ReportScreen> {
  @override
  void initState() {
    Future.delayed(Duration.zero, () async {
      getReportCategory.fetchReplay();
    });

    super.initState();
  }

  bool lockInBackground = true;
  bool notificationsEnabled = true;
  late String strTitle;
  List<ReportScreen> arrSongList = [];
  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            backgroundColor: Colors.white,
            leading: IconButton(
                icon: const Icon(Icons.arrow_back),
                color: mPrimaryColor,
                onPressed: () {
                  Navigator.popUntil(context, (route) => route.isFirst);
                }),
            title: const Text(
              "Report",
              style: TextStyle(
                color: mPrimaryColor,
                fontSize: 27,
                fontFamily: 'font1',
              ),
            ),
            elevation: 0.0,
          ),
          body: getReportCategory.isfetched.isTrue
              ? ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (context, index) {
                    return FollowedList(
                        report: getReportCategory.list[index],
                        postid: widget.postid);
                  },
                  itemCount: getReportCategory.list.length,
                )
              : const Center(
                  child: CircularProgressIndicator(),
                ),
        ));
  }
}

class FollowedList extends StatelessWidget {
  final GetReportCategory? report;
  final int? postid;

  const FollowedList({Key? key, required this.report, required this.postid})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    GeteportCategoryController geteportCategoryController = Get.find();

    return Material(
        color: Theme.of(context).cardColor,
        child: Row(
          children: <Widget>[
            Expanded(
                child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: ListTile(
                  title: Text(report!.category),
                  onTap: () async {
                    geteportCategoryController.sendReport(report!.id, postid);
                    await Future.delayed(const Duration(seconds: 1));
                    geteportCategoryController.sent.value
                        ? Fluttertoast.showToast(
                            msg: "Succefully Reported",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.CENTER,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.green,
                            textColor: Colors.white,
                            fontSize: 16.0)
                        : Fluttertoast.showToast(
                            msg: "Not Succefully Reported",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.CENTER,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.red,
                            textColor: Colors.white,
                            fontSize: 16.0);
                    Navigator.pop(context);
                  }),
            )),
          ],
        ));
  }
}
