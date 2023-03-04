import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:pdf_pro/main.dart';
import 'package:share_plus/share_plus.dart';
import '../widgets/action_button.dart';


class PdfViewer extends StatefulWidget {
  static const String id ='/pdf_view';
  final String path;

  const PdfViewer({Key? key, required this.path}) : super(key: key);

  @override
  State<PdfViewer> createState() => _PdfViewerState();
}

class _PdfViewerState extends State<PdfViewer> {
   bool pdfReady=false;
   int _totalPage =0;
   PDFViewController? _pdfViewController;
   var renderOverlay = true;
   var visible = true;
   var switchLabelPosition = false;
   var extend = false;
   var mini = false;
   var rmicons = false;
   var customDialRoot = false;
   var closeManually = false;
   var useRAnimation = true;
   var isDialOpen = ValueNotifier<bool>(false);
   var speedDialDirection = SpeedDialDirection.up;
   var buttonSize = const Size(56.0, 56.0);
   var childrenButtonSize = const Size(56.0, 56.0);
   bool isNight = false;


  @override
  Widget build(BuildContext context)  {
    return  WillPopScope(
      onWillPop: () async{
        if(isDialOpen.value){
          isDialOpen.value = false;
          return false;
        }else{
          return true;
        }
      },
      child: Scaffold(
        body: Stack(
          children:<Widget> [
            PDFView(
              defaultPage: 0,
              nightMode: isNight ? true : false,
              filePath: widget.path,
              autoSpacing: true,
              enableSwipe: true,
              pageSnap: true,
              swipeHorizontal: false,
              onError: (e){print(e);},
              onRender:(_pages){
                setState(() {
                  _totalPage=_pages!;
                  pdfReady=true;
                });

              } ,
              onViewCreated: (PDFViewController vc){
                _pdfViewController =vc;
              },
              onPageChanged:(int? page , int? total){
                setState(() {


                });
              },
              onPageError: (page , e){},
            ),
            !pdfReady? const Center(child: CircularProgressIndicator()) : const Offstage()
          ],
        ),
        floatingActionButton: SpeedDial(
          animationDuration: const Duration(milliseconds: 400),
          backgroundColor: Colors.deepPurple.shade600,
          icon: Icons.add,
          activeIcon: Icons.close,
          spacing: 3,
          elevation: 8,
          childPadding: const EdgeInsets.all(5),
          spaceBetweenChildren: 4,
          mini: mini,
          openCloseDial: isDialOpen,
          buttonSize: buttonSize,
          childrenButtonSize: childrenButtonSize,
          visible: visible,
          direction: speedDialDirection,
          switchLabelPosition: switchLabelPosition,
          closeManually: closeManually,
          renderOverlay: renderOverlay,
          animationCurve: Curves.elasticInOut,
          isOpenOnStart: false,
          useRotationAnimation: useRAnimation,
          shape: customDialRoot
              ? const RoundedRectangleBorder()
              : const StadiumBorder(),

          children: [
            SpeedDialChild(

              child: ActionButton (
                icon:const Icon(Icons.share_rounded , color: Colors.black,),
                onPressed: (){
                  Share.share(' حمل كتاب الدعاء المستجاب, من تأليف الدكتور عثمان العبادلة   \n هذا الكتاب وقف لله تعالى, شاركه ولك الأجر إن شاءالله\n       https://play.google.com/store/apps/details?id=com.example.pdf_pro \n \n \n ',);
                },
              ),
              label: "مشاركة التطبيق",
              labelBackgroundColor: Colors.black,
              labelStyle: const TextStyle(color: Colors.white,fontSize: 12),
            ),
            SpeedDialChild(
              child: ActionButton(
                icon:const Icon(Icons.save , color: Colors.black,),
                onPressed: (){


                },
              ),
              label: "الحفظ التلقائي",
              labelBackgroundColor: Colors.black,
              labelStyle: const TextStyle(color: Colors.white,fontSize: 12),

            ),
            SpeedDialChild(
              child: ActionButton(
                icon:  Icon(MyApp.themeNotifier.value==ThemeMode.light? Icons.nightlight: Icons.sunny , color: Colors.black,),
                onPressed: (){
                  setState(() {
                    isNight=!isNight;
                    print("pressed");
                  });
                  MyApp.themeNotifier.value = MyApp.themeNotifier.value==ThemeMode.light
                      ? ThemeMode.dark
                      :ThemeMode.light;
                },
              ),
              label:MyApp.themeNotifier.value==ThemeMode.light?
              ' الغاء تفعيل الوضع الليلي':
              ' تفعيل الوضع الليلي',
              labelBackgroundColor: Colors.black,
              labelStyle: const TextStyle(color: Colors.white,fontSize: 12),
            ),
            SpeedDialChild(
              child:
              ActionButton(
                icon:const Icon(Icons.window , color: Colors.black,),
                onPressed: (){ },
              ),
              label: "الفهرس",
              labelBackgroundColor: Colors.black,
              labelStyle: const TextStyle(color: Colors.white,fontSize: 12),
            ),
          ],
        ),

      ),
    );

}}
