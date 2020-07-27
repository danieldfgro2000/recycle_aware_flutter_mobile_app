
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';


const String _markdownData = """
# Recycle
![Recycle Logo](https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcRTCGGkXo16_F5p4dy8NQEzJQiic8C1hf0oLYlX764Z_qgbZXM-)    

## Background

>Romania worst in Europe for recycling,
>with 99 percent of waste going to landfills
>
![Landfill](https://www.romania-insider.com/sites/default/files/styles/article_large_image/public/featured_images/landfill-landscape.jpg)

[Romania](https://www.romania-insider.com/romania-worst-in-europe-for-recycling-with-99-percent-of-waste-going-to-landfills)

## With current recycling methods
### It is costly inefficient to recycle
#### Raw new materials are cheaper than recycled materials

> ------------------
>Recycling is in trouble
>and it might be your fault
>
> -------------------

[USA](https://eu.usatoday.com/story/news/politics/2017/04/20/weak-markets-make-consumers-wishful-recycling-big-problem/100654976/)

![Sort](https://www.gannett-cdn.com/media/2017/04/19/USATODAY/USATODAY/636282189162779270-XXX-JJC16661.JPG?width=1080&quality=50)


# How to overcome this problem?
## Smarter recycling
[Allerin](https://www.allerin.com/blog/using-computer-vision-and-ml-for-smarter-recycling)

[Computer Vision](http://www.recyclingwasteworld.co.uk/in-depth-article/what-is-compter-vision-and-how-can-it-help-the-waste-industry-ai-deep-learning/220067/)

[Smart Robots](https://www.iotsolutionprovider.com/industrial/smart-robots-tackle-the-dirty-job-of-recycling)

![Computer Vision](https://www.iotsolutionprovider.com/sites/iotsolutionprovider/files/AMP_Neuron.JPG)

""";







class WhyPage extends StatefulWidget {
  @override
  _WhyPageState createState() => _WhyPageState();
}

class _WhyPageState extends State<WhyPage> {
  @override
  Widget build(BuildContext context) {
    final controller = ScrollController();
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50.0), // here the desired height
        child: AppBar(
            title: Text('Why', textScaleFactor: 1.5,),
            actions: <Widget>[
              ClipRRect(
                borderRadius: BorderRadius.circular(10.0),
                child:
                Image.asset("assets/images/ecou_logo_crop.png",

                  fit: BoxFit.fill,
                ),
              ),


              IconButton(
                icon: Icon(
                  Icons.settings_applications,
                  color: Colors.white,
                ),
                onPressed: () {
                  // do something
                },
              )
            ]),
      ),

      body: SafeArea(
        child: Markdown(
          controller: controller,
          selectable: true,
          data: _markdownData,
        ),
      ),

      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.arrow_upward),
        onPressed: () =>
            controller.animateTo(0,
                duration: Duration(seconds: 1), curve: Curves.easeOut),
      ),
    );
  }
  }
