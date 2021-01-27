import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:harcapp_core/comm_classes/app_text_style.dart';
import 'package:harcapp_core/comm_classes/color_pack.dart';
import 'package:harcapp_core/comm_widgets/app_card.dart';
import 'package:harcapp_core/comm_widgets/fade_scroll_view.dart';
import 'package:harcapp_core/comm_widgets/simple_button.dart';
import 'package:harcapp_core/dimen.dart';


class Tag extends StatefulWidget{

  static const String TAG_ANGIELSKI = '#Angielski';
  static const String TAG_BALLADY = '#Ballady';
  static const String TAG_DLA_DZIECI = '#DlaDzieci';
  static const String TAG_HARCERSKIE = '#Harcerskie';
  static const String TAG_HISTORYCZNE = '#Historyczne';
  static const String TAG_KOLEDY = '#Kolędy';
  static const String TAG_O_MILOSCI = '#OMiłości';
  static const String TAG_PATRIOTYCZNE = '#Patriotyczne';
  static const String TAG_POWSTANCZE = '#Powstańcze';
  static const String TAG_POEZJA_SPIEWANA = '#PoezjaŚpiewana';
  static const String TAG_POPULARNE = '#Popularne';
  static const String TAG_REFLEKSYJNE = '#Refleksyjne';
  static const String TAG_RELIGIJNE = '#Religijne';
  static const String TAG_SPOKOJNE = '#Spokojne';
  static const String TAG_SZANTY = '#Szanty';
  static const String TAG_TURYSTYCZNE = '#Turystyczne';
  static const String TAG_Z_BAJEK = '#ZBajek';
  static const String TAG_ZYWE = '#Żywe';

  static const List<String> ALL_TAG_NAMES = [TAG_ANGIELSKI, TAG_BALLADY,
    TAG_DLA_DZIECI, TAG_HARCERSKIE, TAG_HISTORYCZNE, TAG_KOLEDY, TAG_O_MILOSCI,
    TAG_PATRIOTYCZNE, TAG_POWSTANCZE, TAG_POEZJA_SPIEWANA, TAG_POPULARNE,
    TAG_REFLEKSYJNE, TAG_RELIGIJNE, TAG_SPOKOJNE, TAG_SZANTY, TAG_TURYSTYCZNE,
    TAG_Z_BAJEK, TAG_ZYWE];

  static const double height = 2*Dimen.DEF_MARG + Dimen.TEXT_SIZE_SMALL;
  static const EdgeInsets defMargin = EdgeInsets.only(left: Dimen.DEF_MARG/2, right: Dimen.DEF_MARG/2, top: Dimen.DEF_MARG, bottom: Dimen.DEF_MARG+2);

  final String text;
  final Function(bool checked) onTap;
  final bool checked;
  final double fontSize;
  final EdgeInsets margin;
  final EdgeInsets padding;
  final bool elevate;
  final bool inCard;

  const Tag(this.text, {this.onTap, this.checked:true, this.fontSize, this.margin: defMargin, this.padding: const EdgeInsets.all(Dimen.ICON_MARG), this.elevate: true, this.inCard: true});

  @override
  State<StatefulWidget> createState() => TagState();
}

class TagState extends State<Tag>{

  String get text => widget.text;
  bool get checked => widget.checked;

  @override
  Widget build(BuildContext context) {

    var wordWrapText = TextPainter(
      text: TextSpan(
          style: AppTextStyle(
              fontSize: widget.fontSize,
              fontWeight: weight.halfBold
          ), text: text),
      textDirection: TextDirection.ltr,
    );
    wordWrapText.layout();
    double width = wordWrapText.width;

    Widget tagStr = SizedBox(
        child: Text(
          text,
          style: AppTextStyle(
            fontSize: widget.fontSize,
            fontWeight: checked?weight.halfBold:weight.normal,
            color: checked?textEnabled(context):hintEnabled(context),
          ),
          textAlign: TextAlign.center,
        ),
        width: width
    );

    if(widget.inCard)
      return AppCard(
          elevation: (checked && widget.elevate)?AppCard.bigElevation:0,
          color: checked?defCardEnabled(context):defCardDisabled(context),
          padding: widget.padding,
          child: tagStr,
          margin: widget.margin,
          radius: 100.0,
          onTap: widget.onTap==null?null:() => widget.onTap(checked)
      );
    else
      return SimpleButton(
          child: tagStr,
          margin: widget.margin,
          padding: widget.padding,
          onTap: widget.onTap==null?null:() => widget.onTap(checked)
      );
  }
}

enum Layout{LINEAR, WRAP}
class TagLayout extends StatelessWidget{

  final List<String> allTags;
  final List<String> checkedTags;
  final Function(String, bool) onTagTap;
  final double separator;
  final Layout layout;
  final Widget Function(BuildContext, String, bool) tagBuilder;

  static double get height => Dimen.TEXT_SIZE_BIG + 2*Dimen.ICON_MARG;

  const TagLayout({@required this.allTags, this.checkedTags = const [], this.onTagTap, this.separator: 0, @required this.layout, @required this.tagBuilder});

  static TagLayout customWrap({
    @required List<String> allTags,
    List<String> checkedTags,
    Function(String, bool) onTagTap,
    double separator,
    @required Widget Function(BuildContext, String, bool) tagBuilder
  }) => TagLayout(
    allTags: allTags,
    checkedTags: checkedTags,
    onTagTap: onTagTap,
    separator: separator,
    layout: Layout.WRAP,
    tagBuilder: tagBuilder,
  );

  static TagLayout customLinear({
    @required List<String> allTags,
    List<String> checkedTags,
    Function(String, bool) onTagTap,
    double separator,
    Widget Function(BuildContext, String, bool) tagBuilder
  }) => TagLayout(
    allTags: allTags,
    checkedTags: checkedTags,
    onTagTap: onTagTap,
    separator: separator,
    layout: Layout.LINEAR,
    tagBuilder: tagBuilder,
  );

  static TagLayout linear({
    @required List<String> allTags,
    List<String> checkedTags,
    Function(String, bool) onTagTap,
    double separator,
    double fontSize: Dimen.TEXT_SIZE_NORMAL,
  }) => TagLayout(
    allTags: allTags,
    checkedTags: checkedTags,
    onTagTap: onTagTap,
    separator: separator,
    layout: Layout.LINEAR,
    tagBuilder: (context, tag, chekced) => Tag(
      tag,
      onTap: onTagTap==null?null:(bool checked) => onTagTap(tag, checked),
      checked: checkedTags.contains(tag),
      fontSize: fontSize,
    ),
  );

  static TagLayout wrap({
    @required List<String> allTags,
    List<String> checkedTags,
    Function(String, bool) onTagTap,
    double separator,
    double fontSize: Dimen.TEXT_SIZE_NORMAL,
  }) => TagLayout(
    allTags: allTags,
    checkedTags: checkedTags,
    onTagTap: onTagTap,
    layout: Layout.WRAP,
    separator: separator,
    tagBuilder: (context, tag, chekced) => Tag(
      tag,
      onTap: onTagTap==null?null:(bool checked) => onTagTap(tag, checked),
      checked: checkedTags.contains(tag),
      fontSize: fontSize,
    ),
  );

  @override
  Widget build(BuildContext context) {

    List<Widget> tags = [];
    for(int i=0; i<allTags.length; i++) {
      String tagStr = allTags[i];
      tags.add(tagBuilder(context, tagStr, checkedTags.contains(tagStr)));
      if(i < allTags.length-1)
        tags.add(SizedBox(width: separator));
    }

    return layout == Layout.WRAP?
    Wrap(
      alignment: WrapAlignment.center,
      children: tags,
      spacing: separator,
      runSpacing: separator,
    ):
    FadeScrollView(
        padding: EdgeInsets.only(bottom: AppCard.bigElevation + 1),
        physics: BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        child: Row(children: tags)
    );
  }
}
