library posreportdatatable;

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';


Color gridExcelBgColor=const Color(0xFFF1F2F4);
Color gridBgColor=const Color(0xFFF8F9FB);
Color reportGridBottomBorderColor=const Color(0xFFdfdfdf);
  TextStyle reportGridHeaderTS=const TextStyle(fontFamily: 'RM',fontSize: 18,color: const Color(0xFF6d7c94),letterSpacing: 0.2);
  TextStyle reportGridValueTS=const TextStyle(fontFamily: 'RR',fontSize: 18,color: const Color(0xFF6d7c94));


class ReportHeaderModel{
  String key;
  Alignment alignment;
  double width;
  EdgeInsets edgeInsets;

  ReportHeaderModel({this.alignment=Alignment.centerLeft,required this.key,required this.width,this.edgeInsets=const EdgeInsets.only(left: 0)});
}


class ReportDataTable extends StatefulWidget {


  List<ReportHeaderModel> header;
  List<dynamic> data;
  List<dynamic> footer;
  String date;
  VoidCallback datePickerCallBack;
  VoidCallback excelCallBack;
  Function(String) searchFunc;
  String noDateImg;
  ReportDataTable({
    required this.header,
    required this.data,
    required this.date,
    required this.datePickerCallBack,
    required this.excelCallBack,
    required this.footer,
    required this.searchFunc,
    required this.noDateImg});


  @override
  _ReportDataTableState createState() => _ReportDataTableState();
}

class _ReportDataTableState extends State<ReportDataTable> {
  late double height,width,height50,width20,height80,width10;
  @override
  Widget build(BuildContext context) {
    height=MediaQuery.of(context).size.height;
    width=MediaQuery.of(context).size.width;
    height50=height*(50/800);
    height80=height*(80/800);
    width20=width*(20/1280);
    width10=width*(10/1280);

    return Container(
      height: height-height50,
      width: width*0.8,
      color: gridBgColor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [


          Container(
            margin: EdgeInsets.only(left: width20,right: width20),
            height: height*0.8,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white
            ),
            child: Column(
              children: [
                Container(
                  height: height80,
                  width: double.maxFinite,
                  padding: EdgeInsets.only(right: width10),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [

                      Container(
                        height: 45,
                        width: 250,
                        margin: EdgeInsets.only(left: width20),
                        decoration: BoxDecoration(
                            color: gridExcelBgColor,
                            borderRadius: BorderRadius.circular(10)
                        ),
                        alignment: Alignment.centerLeft,
                        child: TextFormField(
                          decoration: const InputDecoration(
                              hintText: "Search",
                              hintStyle: TextStyle(fontFamily: 'RR',fontSize: 16,color: Colors.grey),
                              border: InputBorder.none,
                              enabledBorder: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              errorBorder: InputBorder.none,
                              prefixIcon: Icon(Icons.search)
                          ),
                          onChanged: (v){
                            widget.searchFunc(v);
                          },
                        ),
                      ),

                      Spacer(),
                      Text( "${widget.date}",
                        style: TextStyle(fontFamily:'RR',color: Color(0xFF5E5E60),fontSize: 18),
                      ),
                      SizedBox(width: 10,),
                      GestureDetector(
                        onTap: () async{
                          widget.datePickerCallBack();
                        },
                        child: Container(
                          height: 45,
                          width: 60,
                          margin: EdgeInsets.only(right: 20),
                          decoration: BoxDecoration(
                            border: Border.all(color: gridExcelBgColor),
                            borderRadius: BorderRadius.circular(10),
                            // color: gridBgColor
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Icon(Icons.date_range_rounded,color: Color(0xFFB5B5B5),),
                              Container(
                                  height: 45,
                                  width: 1,
                                  color: gridExcelBgColor
                              ),
                              Icon(Icons.arrow_drop_down,color: Colors.grey,)
                            ],
                          ),
                        ),
                      ),

                      GestureDetector(
                        onTap: () async{
                          widget.excelCallBack();
                        },
                        child: ReportIconContainer(
                          image: "excel",
                        ),
                      ),
                      SizedBox(width: width20,)

                    ],
                  ),
                ),

                Container(
                    height: height50,
                    decoration: BoxDecoration(
                      border: Border(bottom: BorderSide(color:reportGridBottomBorderColor)),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: widget.header.map((e) => Container(
                          alignment:e.alignment,
                          height: height50,
                          width:e.width,
                          padding: e.edgeInsets,
                          child: Text("${e.key}",style: reportGridHeaderTS))).toList(),
                    )
                ),

                widget.data.isNotEmpty?Expanded(
                  child: ListView.builder(
                      itemCount: widget.data.length,
                      itemBuilder:(context,index){
                        return Container(
                          height: height50,
                          width: width*0.7,
                          decoration: BoxDecoration(
                            border: Border(bottom: BorderSide(color:Color(0xFFF5F6FA) )),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: widget.header.map((e) => Container(
                              height: height50,
                              width: e.width,
                              alignment: e.alignment,
                              padding: e.edgeInsets,
                              child: Text("${widget.data[index].get(e.key)}",
                                style: TextStyle(fontFamily: 'RR',fontSize: 16,color: Color(0xFF6d7c94)),
                              ),
                            )).toList(),
                          ),
                        );
                      }),
                ):
                Opacity(
                    opacity: 0.7,
                    child: Padding(
                        padding:  EdgeInsets.only(top:height80),
                        child: SvgPicture.asset(widget.noDateImg,height: 300,width: 300,)
                    )
                )
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: width20,right: width20,top: 10),
            height: 50,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white
            ),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  for(int i=0;i<widget.header.length;i++)
                    Container(
                      height: height50,
                      width: widget.header[i].width,
                      alignment: widget.header[i].alignment,
                      child: Text("${widget.footer[i]}",
                        style: TextStyle(fontFamily: 'RM',fontSize: 16,color: Color(0xFF6d7c94)),
                      ),
                    )
                ]
            ),
          )
        ],
      ),
    );
  }
}



class ReportIconContainer extends StatelessWidget {
  final String image;

  ReportIconContainer({ required this.image});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: 50,
      // margin: EdgeInsets.only(right: 10,left: index==0?SizeConfig2.width50:1),
      decoration: BoxDecoration(
        //  shape: BoxShape.circle,
        // color:index==rn.reportIconSelected?AppTheme.red:Color(0xFF7D7D7D),
          color:gridExcelBgColor,
          borderRadius: BorderRadius.circular(10)
        // color:Color(0xFF7D7D7D),
      ),
      child: Center(
          child:  SvgPicture.asset(
            'assets/reportIcons/${image}.svg',
            height:25,
            width:25,
          )
      ),
    );
  }
}
