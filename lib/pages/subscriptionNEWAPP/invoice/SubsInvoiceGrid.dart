import 'package:ecommerce_admin/notifiers/productNotifier.dart';
import 'package:ecommerce_admin/notifiers/themeNotifier.dart';
import 'package:ecommerce_admin/pages/homePage.dart';
import 'package:ecommerce_admin/widgets/buttons/actionBtn.dart';
import 'package:ecommerce_admin/widgets/buttons/addBtn.dart';
import 'package:ecommerce_admin/widgets/buttons/swtich.dart';
import 'package:ecommerce_admin/widgets/grid/gridContents.dart';
import 'package:ecommerce_admin/widgets/grid/gridFooter.dart';
import 'package:ecommerce_admin/widgets/grid/gridWithWidgetParam.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scutiwidgets/size.dart';
import 'package:scutiwidgets/pageRoutes.dart' as pr;

import '../../../constants.dart';




class SubscriberInvoice extends StatefulWidget {
  const SubscriberInvoice({Key? key}) : super(key: key);

  @override
  _SubscriberInvoiceState createState() => _SubscriberInvoiceState();
}

class _SubscriberInvoiceState extends State<SubscriberInvoice> {
  late double width;
  List<GridHeaderModel> gridHeaderList=[
    GridHeaderModel(columnName: "Company ",),
    GridHeaderModel(columnName: "Bill Date",width: 200),
    GridHeaderModel(columnName: "Bill No",width: 200),
    GridHeaderModel(columnName: "Due Date",),
    GridHeaderModel(columnName: "Bill Amount",),
    GridHeaderModel(columnName: "Paid Amount",),
    GridHeaderModel(columnName: "BalanceAmt",),
    GridHeaderModel(columnName: "Status",),
    GridHeaderModel(columnName: "Actions",width: 100),
  ];
  @override
  void initState() {
    Provider.of<ProductNotifier>(context,listen: false).init(false);
    super.initState();
  }
  // @override
  // void didChangeDependencies() {
  //   print("CUstomer did");
  //   super.didChangeDependencies();
  // }

  @override
  Widget build(BuildContext context) {
    width=SizeConfig.screenWidth!-100;
    return Consumer<ThemeNotifier>(
      builder: (context,th,child)=>Consumer<ProductNotifier>(
        builder: (context,pn,child)=>  Container(
          height: SizeConfig.screenHeight!-appBarHei,
          width: width,
          color: bgColor,
          padding: bodyPadding,
          child: Column(
            children: [
              GridWithWidgetParam(
                  headerHeight: headerHeight,
                  headerWidth: width,
                  gridHeaderList: gridHeaderList,
                  showAdd: false,
                  addBtnTap: (){
                    // Navigator.push(context, pr.PageRoute().fade(AdminSubsPlanAdd()));
                  },
                  filterOnTap: (i){
                    setState(() {
                      gridHeaderList[i].isActive=!gridHeaderList[i].isActive;
                    });
                  },
                  searchFunc: (v){
                    pn.searchCustomer(v);
                  },
                  headerWidget: Row(
                      children: gridHeaderList.asMap().map((key, value) =>
                          MapEntry(key, value.isActive? GridHeader(
                            width: value.width,
                            title: value.columnName,
                          ):Container(),
                          )
                      ).values.toList()
                  ),
                  bodyHeight: SizeConfig.screenHeight!-270,
                  bodyWidth: width,
                  bodyWidget: Column(
                    children: pn.subsInvoice.asMap().map((key, value) => MapEntry(key,
                        Container(
                          //width: width,
                          padding: bodyPadd,
                          margin: bodyMargin,
                          decoration: bodyDecoration,
                          constraints: bodyConstraints,
                          child: Row(
                            children: [
                              gridHeaderList[0].isActive?GridContent(
                                width:  gridHeaderList[0].width,
                                title: value.company,
                              ):Container(),
                              gridHeaderList[1].isActive?GridContent(
                                width:  gridHeaderList[1].width,
                                title: value.billDate,
                              ):Container(),
                              gridHeaderList[2].isActive?GridContent(
                                width:  gridHeaderList[2].width,
                                alignment: gridHeaderList[2].alignment,
                                title: value.billNo,
                              ):Container(),
                              gridHeaderList[3].isActive?GridContent(
                                width:  gridHeaderList[3].width,
                                title: value.dueDate,
                              ):Container(),
                              gridHeaderList[4].isActive?GridContent(
                                width:  gridHeaderList[4].width,
                                title: value.billAmount,
                              ):Container(),
                              gridHeaderList[5].isActive?GridContent(
                                width:  gridHeaderList[5].width,
                                title: value.paidAmount,
                              ):Container(),
                              gridHeaderList[6].isActive?GridContent(
                                width:  gridHeaderList[6].width,
                                alignment:  gridHeaderList[6].alignment,
                                title: value.balanceAmt,
                              ):Container(),
                              gridHeaderList[7].isActive?GridContent(
                                width:  gridHeaderList[7].width,
                                alignment:  gridHeaderList[7].alignment,
                                title: value.status,
                              ):Container(),
                              gridHeaderList[8].isActive?Container(
                                width:  gridHeaderList[8].width,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: [
                                    AddBtn(
                                      ontap: (){
                                        // Navigator.push(context, pr.PageRoute().slideFromLeftToRight(CustomerView()));
                                      },
                                      color: Colors.transparent,
                                      hei: 30,
                                      margin: EdgeInsets.only(left: 0),
                                      widget: Icon(Icons.download_outlined,color: Colors.grey,size: 30,),
                                    ),
                                    // ActionIcon(ontap: (){
                                    // }, imgColor: Colors.red, img: "assets/icons/delete.svg"
                                    // ),
                                  ],
                                ),
                              ):Container(),
                            ],
                          ),
                        )
                    )
                    ).values.toList(),
                  )
              ),
              GridFooter(
                  width: width-70,
                  perPage: pn.perPage,
                  currentPage: pn.currentPage+1,
                  prev: (){
                    pn.prev();
                  },
                  next: (){
                    pn.next();
                  },
                  ontap: (i){
                    setState(() {
                      pn.perPage=i;
                    });
                    pn.init(true);
                  }
              ),

            ],
          ),
        ),
      ),
    );
  }
}


