import 'dart:ui';

import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sample/common/Style.dart';
import './action.dart';
import './state.dart';

Widget buildView(
    UserAgreeMentState state, Dispatch dispatch, ViewService viewService) {
      final BuildContext context = viewService.context;
  final TextStyle bigTitle = TextStyle(color: Colors.black, fontSize: ScreenUtil().setSp(28), fontWeight: FontWeight.w600);
  final TextStyle secondTitle = TextStyle(color: Colors.black, fontSize: ScreenUtil().setSp(26), fontWeight: FontWeight.w600);
  final TextStyle content = TextStyle(color: Colors.black54, fontSize: ScreenUtil().setSp(26), fontWeight: FontWeight.w400);
  return Scaffold(
    appBar: AppBar(
      leading: IconButton(icon: Icon(Icons.arrow_back_ios, color: Colors.black87,), onPressed: () {
        Navigator.of(context).pop();
      }),
      title: const Text('用户协议和隐私政策', style: TextStyle(color: Colors.black,)),
      bottom: Style.preferredSize,
      brightness: Brightness.light,
      backgroundColor: Colors.white,
      elevation: 0,
    ),
    backgroundColor: Colors.grey[200],
    body:
        SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: ScreenUtil().setWidth(26), horizontal: ScreenUtil().setWidth(26)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              padding: EdgeInsets.symmetric(vertical: ScreenUtil().setWidth(12)),
              child: Text('一、总则', style: bigTitle )
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: ScreenUtil().setWidth(12)),
              child: Text('      深圳车库电桩科技有限公司(以下简称“车库电桩科技”) 在此特别提醒您(用户) 在注册成为用户之前，请认真阅读本《用户协议》(以下简称“协议”) ，确保您充分理解本协议中各条款。请您审慎阅读并选择接受或不接受本协议。除非您接受本协议所有条款，否则您无权注册、登录或使用本协议所涉服务。您在进行申请程序过程中点击“登录”即表示您完全接受本协议项下的全部条款。', style: content )
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: ScreenUtil().setWidth(12)),
              child: Text('      您的注册、登录、使用等行为将视为对本协议的接受，并同意接受本协议各项条款的约束。', style: content )
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: ScreenUtil().setWidth(12)),
              child: Text('      请您务必审慎阅读、充分理解各条款内容，特别是免除或者限制责任的条款、管辖与法律适用条款，以及开通或使用某项服务的单独协议（如有）。限制、免责条款以黑体加粗的形式提示您重点注意。除非您已阅读并接受本协议所有条款，否则请勿点击“登录”，您注册“车库电桩”账号或使用“车库电桩”的服务即视为您已阅读并同意上述条款的约束。', style: content )
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: ScreenUtil().setWidth(12)),
              child: Text('      本协议约定车库电桩科技与用户之间关于“车库电桩”软件服务（以下简称“服务”）的权利义务。“用户”是指注册、登录、使用本服务的个人。协议和公告将会随时更新，并提前15天在显著位置公示。您在使用“车库电桩”所提供的各项服务之前，应仔细阅读会员服务协议和公告。如您不同意更新后的服务协议或公告，您可以停止或取消使用“车库电桩”所提供的服务；您一旦使用“车库电桩”服务，即视为您已了解并完全同意会员服务协议的各项内容，包括“车库电桩”对服务协议所做的修改。', style: content )
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: ScreenUtil().setWidth(12)),
              child: Text('      为方便联系您以解决各项事宜，请您注册时使用本人有效手机号码作为账号；您应当对该账号进行的所有活动和事件承担法律责任。', style: content )
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: ScreenUtil().setWidth(12)),
              child: Text('二、注册信息和隐私保护', style: secondTitle )
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: ScreenUtil().setWidth(12)),
              child: Text.rich(TextSpan(children: <TextSpan>[
                TextSpan(text: '2.1 ', style: secondTitle),
                TextSpan(text: '“车库电桩”账号(即“车库电桩”用户ID) 的所有权归属于“车库电桩”，您完成注册申请手续后，可获得“车库电桩”账号的使用权。注册时您应提供即时、详尽及准确的个人资料，并有义务不断更新注册资料，以符合即时、详尽、准确的要求。所有原始键入的资料将认定为注册资料。因注册资料不真实而引起的问题，及该问题引发的后果，“车库电桩”不承担任何责任。', style: content)
              ])),
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: ScreenUtil().setWidth(12)),
              child: Text.rich(TextSpan(children: <TextSpan>[
                TextSpan(text: '2.2 ', style: secondTitle),
                TextSpan(text: '因系统服务将涉及在线支付，适用于您与商户间发生的包括但不限于服务纠纷、付款错误、退款等情况，为方便及时联系与您确认， “车库电桩”强烈要求您使用真实的手机号码进行账号注册。', style: content)
              ])),
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: ScreenUtil().setWidth(12)),
              child: Text.rich(TextSpan(children: <TextSpan>[
                TextSpan(text: '2.3 ', style: secondTitle),
                TextSpan(text: '“车库电桩”提示您请勿将账号、密码转让、出售或借予他人使用，若您授权他人使用账号，对被授权人在该账户下实施的所有行为您须承担全部责任。', style: content)
              ])),
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: ScreenUtil().setWidth(12)),
              child: Text.rich(TextSpan(children: <TextSpan>[
                TextSpan(text: '2.4 ', style: secondTitle),
                TextSpan(text: '“车库电桩”保证不对外公开或向第三方提供您的注册资料及在使用网络服务时存储在本平台上的非公开内容，但下列情况除外：', style: content)
              ])),
            ),
            Container(
              child: Text.rich(TextSpan(children: <TextSpan>[
                TextSpan(text: '    1、事先获得用户的明确授权。', style: content)
              ])),
            ),
            Container(
              child: Text.rich(TextSpan(children: <TextSpan>[
                TextSpan(text: '    2、根据有关的法律法规要求。', style: content)
              ])),
            ),
            Container(
              child: Text.rich(TextSpan(children: <TextSpan>[
                TextSpan(text: '    3、按照相关政府主管部门的要求。', style: content)
              ])),
            ),
            Container(
              child: Text.rich(TextSpan(children: <TextSpan>[
                TextSpan(text: '    4、为维护社会公众的利益。', style: content)
              ])),
            ),
            Container(
              child: Text.rich(TextSpan(children: <TextSpan>[
                TextSpan(text: '    5、为维护本平台或用户的合法权益。', style: content)
              ])),
            ),
            Container(
              child: Text.rich(TextSpan(children: <TextSpan>[
                TextSpan(text: '    6、不可抗力所导致的用户信息公开。', style: content)
              ])),
            ),
            Container(
              child: Text.rich(TextSpan(children: <TextSpan>[
                TextSpan(text: '    7、不能归咎于本站的客观情势，所导致的个人资料的公开。', style: content)
              ])),
            ),
            Container(
              child: Text.rich(TextSpan(children: <TextSpan>[
                TextSpan(text: '    8、本平台有充分理由相信用户信息的公开，符合本站和用户利益要求的。', style: content)
              ])),
            ),
            Container(
              child: Text.rich(TextSpan(children: <TextSpan>[
                TextSpan(text: '    9、在不透露单个用户信息的前提下，本平台有权对整个用户数据库进行分析并对用户数据库进行利用。', style: content)
              ])),
            ),
            Container(
              child: Text.rich(TextSpan(children: <TextSpan>[
                TextSpan(text: '    10、“车库电桩”应在其网络系统内建立合理的安全体系，包括身份识别体系、内部安全防范体系，以使用户数据完整，并且保密。但用户了解并同意技术手段在不断更新，本平台无法杜绝全部的非安全因素，但本平台会及时更新体系，妥善维护网络及相关数据。', style: content)
              ])),
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: ScreenUtil().setWidth(12)),
              child: Text.rich(TextSpan(children: <TextSpan>[
                TextSpan(text: '2.5 ', style: secondTitle),
                TextSpan(text: '您在注册“车库电桩”账号，使用“车库电桩”产品或服务，访问“车库电桩”网页，或参加促销和有奖游戏等类似情形时，“车库电桩”将会自动收集您的个人身份识别资料且不再另行通知您。这些资料将会用于：改进并优化为您提供的服务及网页内容。', style: content)
              ])),
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: ScreenUtil().setWidth(12)),
              child: Text('三、使用规则', style: secondTitle )
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: ScreenUtil().setWidth(12)),
              child: Text.rich(TextSpan(children: <TextSpan>[
                TextSpan(text: '3.1 ', style: secondTitle),
                TextSpan(text: '您在使用“车库电桩”服务时，必须遵守中华人民共和国相关法律法规的规定，不得利用本服务进行任何违法或不正当的活动，包括但不限于下列行为：', style: content)
              ])),
            ),
            Container(
              child: Text.rich(TextSpan(children: <TextSpan>[
                TextSpan(text: '（1）、您的名称、头像和简介不得损害“车库电桩”利益，不得损害其他用户利益，不得损害社会公共利益。您不得采用下述文字、符号、图片等不良信息，包括但不限于：', style: content)
              ])),
            ),
            Container(
              child: Text.rich(TextSpan(children: <TextSpan>[
                TextSpan(text: '        1）和“车库电桩”名称一致或相似的文字或符号或容易与“车库电桩”在线客服人员名称混淆的文字或符号；', style: content)
              ])),
            ),
            Container(
              child: Text.rich(TextSpan(children: <TextSpan>[
                TextSpan(text: '        2）同中华人民共和国的国家名称、省市名称、国旗名称相同或者近似的，或同中央国家机关名称或所在地特定地点或者标志性建筑物的名称相同的文字或符号；', style: content)
              ])),
            ),
            Container(
              child: Text.rich(TextSpan(children: <TextSpan>[
                TextSpan(text: '        3）同外国的国家名称、国旗名称、政府间国际组织的名称相同或者近似的文字或符号；', style: content)
              ])),
            ),
            Container(
              child: Text.rich(TextSpan(children: <TextSpan>[
                TextSpan(text: '        4）和中华人民共和国国家政要、外国政府政要、政府间国际组织负责人名字相同的文字或符号；', style: content)
              ])),
            ),
            Container(
              child: Text.rich(TextSpan(children: <TextSpan>[
                TextSpan(text: '        5）带有民族歧视性、违反道德风尚、损害国家利益或有其他不良影响的文字或符号；', style: content)
              ])),
            ),
            Container(
              child: Text.rich(TextSpan(children: <TextSpan>[
                TextSpan(text: '        6）同国内外非法组织名称相同或类似的文字或符号；', style: content)
              ])),
            ),
            Container(
              child: Text.rich(TextSpan(children: <TextSpan>[
                TextSpan(text: '        7）危害“车库电桩”形象的文字或符号；', style: content)
              ])),
            ),
            Container(
              child: Text.rich(TextSpan(children: <TextSpan>[
                TextSpan(text: '        8）法律法规禁止使用的其他名称；', style: content)
              ])),
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: ScreenUtil().setWidth(12)),
              child: Text.rich(TextSpan(children: <TextSpan>[
                TextSpan(text: '', style: secondTitle),
                TextSpan(text: '上述列举仅供明确违反名称、头像和简介规则的具体表现形式，并非违反规则仅限于上述具体表现形式，凡是损害“车库电桩”利益或损害其他用户利益或损害社会公众利益的文字、符号、图片等不良信息，都不得用于名称、头像和简介。在完全遵守本协议约定的前提下，我们授予您使用“车库电桩”的许可，您可以据此注册一个或几个账号，享受网络服务。您不得恶意注册账号。“车库电桩”可以对恶意注册行为进行独立判断和处理。', style: content)
              ])),
            ),
            Container(
              child: Text.rich(TextSpan(children: <TextSpan>[
                TextSpan(text: '（2)、上载、展示、张贴、传播或以其他方式传达含有下列内容之一的信息：', style: content)
              ])),
            ),
            Container(
              child: Text.rich(TextSpan(children: <TextSpan>[
                TextSpan(text: '        1）反对宪法所确定的基本原则的；', style: content)
              ])),
            ),
            Container(
              child: Text.rich(TextSpan(children: <TextSpan>[
                TextSpan(text: '        2）危害国家安全，泄露国家秘密，颠覆国家政权，破坏国家统一的；', style: content)
              ])),
            ),
            Container(
              child: Text.rich(TextSpan(children: <TextSpan>[
                TextSpan(text: '        3）损害国家荣誉和利益的；', style: content)
              ])),
            ),
            Container(
              child: Text.rich(TextSpan(children: <TextSpan>[
                TextSpan(text: '        4）煽动民族仇恨、民族歧视、破坏民族团结的；', style: content)
              ])),
            ),
            Container(
              child: Text.rich(TextSpan(children: <TextSpan>[
                TextSpan(text: '        5）破坏国家宗教政策，宣扬邪教和封建迷信的；', style: content)
              ])),
            ),
            Container(
              child: Text.rich(TextSpan(children: <TextSpan>[
                TextSpan(text: '        6）散布谣言，扰乱社会秩序，破坏社会稳定的；', style: content)
              ])),
            ),
            Container(
              child: Text.rich(TextSpan(children: <TextSpan>[
                TextSpan(text: '        7）散布淫秽、色情、赌博、暴力、凶杀、恐怖或者教唆犯罪的；', style: content)
              ])),
            ),
            Container(
              child: Text.rich(TextSpan(children: <TextSpan>[
                TextSpan(text: '        8）侮辱或者诽谤他人，侵害他人合法权利的；', style: content)
              ])),
            ),
            Container(
              child: Text.rich(TextSpan(children: <TextSpan>[
                TextSpan(text: '        9）含有虚假、有害、胁迫、侵害他人隐私、骚扰、侵害、中伤、粗俗、猥亵或其它道德上令人反感的内容；', style: content)
              ])),
            ),
            Container(
              child: Text.rich(TextSpan(children: <TextSpan>[
                TextSpan(text: '        10）含有中国法律、法规、规章、条例以及任何具有法律效力之规范所限制或禁止的其它内容的；', style: content)
              ])),
            ),
            Container(
              child: Text.rich(TextSpan(children: <TextSpan>[
                TextSpan(text: ' (3)、不得为任何非法目的而使用网络服务系统；', style: content)
              ])),
            ),
            Container(
              child: Text.rich(TextSpan(children: <TextSpan>[
                TextSpan(text: ' (4)、不得利用“车库电桩”服务从事以下活动：', style: content)
              ])),
            ),
            Container(
              child: Text.rich(TextSpan(children: <TextSpan>[
                TextSpan(text: '        1）未经允许，进入计算机信息网络或者使用计算机信息网络资源的；', style: content)
              ])),
            ),
            Container(
              child: Text.rich(TextSpan(children: <TextSpan>[
                TextSpan(text: '        2）未经允许，对计算机信息网络功能进行删除、修改或者增加的；', style: content)
              ])),
            ),
            Container(
              child: Text.rich(TextSpan(children: <TextSpan>[
                TextSpan(text: '        3）未经允许，对进入计算机信息网络中存储、处理或者传输的数据和应用程序进行删除、修改或增加的；', style: content)
              ])),
            ),
            Container(
              child: Text.rich(TextSpan(children: <TextSpan>[
                TextSpan(text: '        4）故意制作、传播计算机病毒等破坏性程序的；', style: content)
              ])),
            ),
            Container(
              child: Text.rich(TextSpan(children: <TextSpan>[
                TextSpan(text: '        5）其他危害计算机信息网络安全的行为。', style: content)
              ])),
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: ScreenUtil().setWidth(12)),
              child: Text.rich(TextSpan(children: <TextSpan>[
                TextSpan(text: '3.2 ', style: secondTitle),
                TextSpan(text: '因您违反本协议或相关服务条款的规定，导致或产生的任何第三方主张的索赔、要求或损失，包括合理的律师费在内，您同意对“车库电桩”及其合作公司、关联公司作出赔偿，并使之免受损害。对此，“车库电桩”有权根据您的行为性质，采取包括但不限于删除发布的信息内容、限制使用、暂停使用许可、终止服务、注销“车库电桩”账号、追究法律责任等措施。对恶意注册“车库电桩”账号或利用“车库电桩”账号进行违法活动，扰乱、骚扰、欺骗其他用户以及其他违反本协议的行为，“车库电桩”有权注销其账号。同时，“车库电桩”将会协助相关部门开展调查活动。', style: content)
              ])),
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: ScreenUtil().setWidth(12)),
              child: Text.rich(TextSpan(children: <TextSpan>[
                TextSpan(text: '3.3 ', style: secondTitle),
                TextSpan(text: '您不得将“车库电桩”服务任何部分或基于“车库电桩”服务之使用或获得，进行复制、拷贝、出售、转售或用于任何其他目的。', style: content)
              ])),
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: ScreenUtil().setWidth(12)),
              child: Text.rich(TextSpan(children: <TextSpan>[
                TextSpan(text: '3.4 ', style: secondTitle),
                TextSpan(text: '您须对自己在使用“车库电桩”服务过程中的行为承担法律责任。您承担法律责任的形式包含但不限于：直接对受到侵害者进行赔偿，以及在“车库电桩”因您的行为遭受行政处罚或导致侵权损害赔偿后，给予“车库电桩”等额的赔偿。', style: content)
              ])),
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: ScreenUtil().setWidth(12)),
              child: Text('四、服务内容', style: secondTitle )
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: ScreenUtil().setWidth(12)),
              child: Text.rich(TextSpan(children: <TextSpan>[
                TextSpan(text: '4.1 ', style: secondTitle),
                TextSpan(text: '“车库电桩”网络服务的具体内容由“车库电桩”根据实际情况提供。', style: content)
              ])),
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: ScreenUtil().setWidth(12)),
              child: Text.rich(TextSpan(children: <TextSpan>[
                TextSpan(text: '4.2、', style: secondTitle),
                TextSpan(text: '除非本服务协议另有其他明示规定，“车库电桩”推出的新产品、新功能、新服务，均受到本服务协议之规范。', style: content)
              ])),
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: ScreenUtil().setWidth(12)),
              child: Text.rich(TextSpan(children: <TextSpan>[
                TextSpan(text: '4.3 ', style: secondTitle),
                TextSpan(text: '为使用本服务，您必须经有提供互联网接入服务法律资格的第三方以进入国际互联网，并自行支付相关服务费用。此外，您必须自行配备及负责与国际互联网连线所需之一切必要装备，包括但不限于计算机、数据机或其它存取装置。', style: content)
              ])),
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: ScreenUtil().setWidth(12)),
              child: Text.rich(TextSpan(children: <TextSpan>[
                TextSpan(text: '4.4 ', style: secondTitle),
                TextSpan(text: '鉴于网络服务的特殊性，您知悉且同意“车库电桩”无需事先通知，有权随时变更、中断或终止部分或全部网络服务(包括收费网络服务) 。“车库电桩”对网络服务是否存在中断可能性，以及网络服务的及时性、安全性、准确性均不作保证。', style: content)
              ])),
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: ScreenUtil().setWidth(12)),
              child: Text.rich(TextSpan(children: <TextSpan>[
                TextSpan(text: '4.5 ', style: secondTitle),
                TextSpan(text: '“车库电桩”将定期或不定期地对提供网络服务的平台或相关的设备进行检修或者维护，您知悉并同意因此类情况而造成的网络服务(包括收费网络服务) 在合理时间内的中断， “车库电桩”无需为此承担任何责任，且“车库电桩”无需事先通知用户，有权为维修、保养、升级或其它目的而暂停任何服务。', style: content)
              ])),
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: ScreenUtil().setWidth(12)),
              child: Text.rich(TextSpan(children: <TextSpan>[
                TextSpan(text: '4.6 ', style: secondTitle),
                TextSpan(text: '本服务提供过程中及第三人可自由提供其它国际互联网之网站或资源链接。由于“车库电桩”无法控制这些网站及资源信息的发布，您已了解并同意，对此类网站或资源是否具有可利用性，“车库电桩”不作保证且不承担任何责任，对存在或源于此类网站或资源之任何内容、广告、产品或其它资料，“车库电桩”亦不作保证且不承担任何责任。因使用或依赖任何此类网站或资源发布的或经由此类网站或资源获得的任何内容、商品或服务所产生的任何损害或损失，“车库电桩”不承担任何责任。', style: content)
              ])),
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: ScreenUtil().setWidth(12)),
              child: Text.rich(TextSpan(children: <TextSpan>[
                TextSpan(text: '4.7 ', style: secondTitle),
                TextSpan(text: '您明确同意在使用“车库电桩”网络服务过程中产生的风险将完全由其自己承担。，确认由您独立作出下载或通过“车库电桩”服务取得信息资料的行为，并愿意承担可能发生的系统受损、资料丢失以及其他任何风险。', style: content)
              ])),
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: ScreenUtil().setWidth(12)),
              child: Text.rich(TextSpan(children: <TextSpan>[
                TextSpan(text: '4.8 ', style: secondTitle),
                TextSpan(text: '“车库电桩”有权于任何时间暂时或永久地修改或终止本服务(或其任何部分) ，而无论其通知与否，“车库电桩”对您或任何第三人均无需承担任何责任。', style: content)
              ])),
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: ScreenUtil().setWidth(12)),
              child: Text.rich(TextSpan(children: <TextSpan>[
                TextSpan(text: '4.9 ', style: secondTitle),
                TextSpan(text: '终止服务：您同意“车库电桩”有权基于其自身之考虑，因任何原因，包含但不限于您长时间未使用，或“车库电桩”认为您已经违反本服务协议的文字及精神，终止您的密码、账号或本服务之使用(或服务之任何部分) ，并将您在本服务内任何内容加以移除并删除。您同意依本服务协议规定而提供之服务，“车库电桩”无需进行事先通知即可中断或终止；您承认并同意，“车库电桩”可随时关闭或删除您的账号及您账号中所有相关信息及文件，及/或禁止您继续使用前述文件或本服务。此外，您同意出现本服务之使用被中断、终止或您的账号及相关信息和文件被关闭、删除的情形，“车库电桩”对您或任何第三人均不承担任何责任。', style: content)
              ])),
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: ScreenUtil().setWidth(12)),
              child: Text('五、知识产权和其他合法权益(包括但不限于名誉权、商誉权)', style: secondTitle )
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: ScreenUtil().setWidth(12)),
              child: Text.rich(TextSpan(children: <TextSpan>[
                TextSpan(text: '5.1 ', style: secondTitle),
                TextSpan(text: '知识产权：', style: content)
              ])),
            ),
            Container(
              child: Text.rich(TextSpan(children: <TextSpan>[
                TextSpan(text: '  (1)、“车库电桩”所包含的全部智力成果包括但不限于数据库、网站设计、文字和图表、软件、照片、录像、音乐、声音及其前述组合，软件编译、相关源代码和软件 (包括小应用程序和脚本) 的知识产权权利均归“车库电桩”所有。未经特殊书面授权您不得为任何目的复制、更改、拷贝、发送或使用前述任何材料或内容。', style: content)
              ])),
            ),
            Container(
              child: Text.rich(TextSpan(children: <TextSpan>[
                TextSpan(text: '  (2)、“车库电桩”名称中包含的所有权利 (包括商誉和商标) 均归深圳车库电桩科技有限公司所有。', style: content)
              ])),
            ),
            Container(
              child: Text.rich(TextSpan(children: <TextSpan>[
                TextSpan(text: '  (3)、您接受本协议即视为已知悉并自愿主动将在“车库电桩”系统平台及相关区域发表的任何形式的信息的著作权，包括但不限于：复制权、发行权、出租权、展览权、表演权、放映权、广播权、信息网络传播权、摄制权、改编权、翻译权、汇编权以及应当由著作权人享有的其他财产权利长期无偿独占许可给“车库电桩”使用，“车库电桩”有权利就任何主体对上述著作权的侵权行为单独提起诉讼并获得全部赔偿。本协议属于《中华人民共和国著作权法》第二十五条规定的书面协议，其效力及于您在“车库电桩”发布的任何受著作权法保护的作品内容，无论该内容形成于本协议签订前还是本协议签订后。您请勿在“车库电桩”系统平台及相关区域内发布您无权使用或需保留著作权的信息材料，对此“车库电桩”将不再进行通知，因此而产生的侵权责任或权利纠纷，将由您自己承担责任。', style: content)
              ])),
            ),
            Container(
              child: Text.rich(TextSpan(children: <TextSpan>[
                TextSpan(text: '  (4)、您在使用“车库电桩”服务过程中不得非法使用或处分“车库电桩”或他人的知识产权权利。您不得将已发表于“车库电桩”的信息以任何形式发布或授权其它网站(及媒体) 使用。', style: content)
              ])),
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: ScreenUtil().setWidth(12)),
              child: Text('六、隐私保护', style: secondTitle )
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: ScreenUtil().setWidth(12)),
              child: Text('我们尊重并保护所有使用我们网络服务的个人的隐私。未事先得到您的同意，我们不会有意将涉及您个人隐私的内容透露给任何第三方，但本协议另有说明的除外。如对本隐私保护或相关事宜有任何问题，请与我们联系。', style: content )
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: ScreenUtil().setWidth(12)),
              child: Text.rich(TextSpan(children: <TextSpan>[
                TextSpan(text: '6.1 ', style: secondTitle),
                TextSpan(text: '我们收集的信息', style: content)
              ])),
            ),
            Container(
              child: Text.rich(TextSpan(children: <TextSpan>[
                TextSpan(text: '我们提供服务时，可能会收集、储存和使用下列与您有关的信息。如果您不提供相关信息，可能无法注册成为我们的用户或无法享受我们提供的某些服务，或者无法达到相关服务拟达到的效果。', style: content)
              ])),
            ),
            Container(
              child: Text.rich(TextSpan(children: <TextSpan>[
                TextSpan(text: '  (1）、您提供的信息', style: content)
              ])),
            ),
            Container(
              child: Text.rich(TextSpan(children: <TextSpan>[
                TextSpan(text: '    您在注册账户或使用我们的服务时，向我们提供的相关个人信息，例如电话号码、电子邮件或银行卡号等；', style: content)
              ])),
            ),
            Container(
              child: Text.rich(TextSpan(children: <TextSpan>[
                TextSpan(text: '    您通过我们的服务向其他方提供的共享信息，以及您使用我们的服务时所储存的信息。', style: content)
              ])),
            ),
            Container(
              child: Text.rich(TextSpan(children: <TextSpan>[
                TextSpan(text: '  (2）、其他方共享的您的信息。', style: content)
              ])),
            ),
            Container(
              child: Text.rich(TextSpan(children: <TextSpan>[
                TextSpan(text: '    其他方使用我们的服务时所提供有关您的共享信息', style: content)
              ])),
            ),
            Container(
              child: Text.rich(TextSpan(children: <TextSpan>[
                TextSpan(text: '  (3）、我们获取的您的信息', style: content)
              ])),
            ),
            Container(
              child: Text.rich(TextSpan(children: <TextSpan>[
                TextSpan(text: '    您使用服务时我们可能收集如下信息：', style: content)
              ])),
            ),
            Container(
              child: Text.rich(TextSpan(children: <TextSpan>[
                TextSpan(text: '          日志信息， 指您使用我们的服务时，系统可能通过cookies、web beacon或其他方式自动采集的技术信息，包括：', style: content)
              ])),
            ),
            Container(
              child: Text.rich(TextSpan(children: <TextSpan>[
                TextSpan(text: '          设备或软件信息，例如您的移动设备、网页浏览器或用于接入我们服务的其他程序所提供的配置信息、您的IP地址和移动设备所用的版本和设备识别码；', style: content)
              ])),
            ),
            Container(
              child: Text.rich(TextSpan(children: <TextSpan>[
                TextSpan(text: '          设备或软件信息，例如您的移动设备、网页浏览器或用于接入我们服务的其他程序所提供的配置信息、您的IP地址和移动设备所用的版本和设备识别码；', style: content)
              ])),
            ),
            Container(
              child: Text.rich(TextSpan(children: <TextSpan>[
                TextSpan(text: '          在使用我们服务时搜索或浏览的信息，例如您使用的网页搜索词语、访问的社交媒体页面url地址，以及您在使用我们服务时浏览或要求提供的其他信息和内容详情；', style: content)
              ])),
            ),
            Container(
              child: Text.rich(TextSpan(children: <TextSpan>[
                TextSpan(text: '           有关您曾使用的移动应用(APP) 和其他软件的信息，以及您曾经使用该等移动应用和软件的信息；', style: content)
              ])),
            ),
            Container(
              child: Text.rich(TextSpan(children: <TextSpan>[
                TextSpan(text: '           您通过我们的服务进行通讯的信息，例如曾通讯的账号，以及通讯时间、数据和时长；', style: content)
              ])),
            ),
            Container(
              child: Text.rich(TextSpan(children: <TextSpan>[
                TextSpan(text: '           您通过我们的服务共享的内容所包含的信息(元数据) ，例如拍摄或上传的共享照片或录像的日期、时间或地点等。', style: content)
              ])),
            ),
            Container(
              child: Text.rich(TextSpan(children: <TextSpan>[
                TextSpan(text: '           位置信息， 指您开启设备定位功能并使用我们基于位置提供的相关服务时，收集的有关您位置的信息，包括：', style: content)
              ])),
            ),
            Container(
              child: Text.rich(TextSpan(children: <TextSpan>[
                TextSpan(text: '           您通过具有定位功能的移动设备使用我们的服务时，通过GPS或WiFi等方式收集的您的地理位置信息；', style: content)
              ])),
            ),
            Container(
              child: Text.rich(TextSpan(children: <TextSpan>[
                TextSpan(text: '           您或其他用户提供的包含您所处地理位置的实时信息，例如您提供的账户信息中包含的您所在地区信息，您或其他人上传的显示您当前或曾经所处地理位置的共享信息，您或其他人共享的照片包含的地理标记信息；', style: content)
              ])),
            ),
            Container(
              child: Text.rich(TextSpan(children: <TextSpan>[
                TextSpan(text: '        您可以通过关闭定位功能，停止对您的地理位置信息的收集。', style: content)
              ])),
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: ScreenUtil().setWidth(12)),
              child: Text.rich(TextSpan(children: <TextSpan>[
                TextSpan(text: '6.2 ', style: secondTitle),
                TextSpan(text: '我们如何使用信息', style: content)
              ])),
            ),
            Container(
              child: Text.rich(TextSpan(children: <TextSpan>[
                TextSpan(text: '我们将收集的信息用作下列用途：', style: content)
              ])),
            ),
            Container(
              child: Text.rich(TextSpan(children: <TextSpan>[
                TextSpan(text: '  (1）、向您提供服务;', style: content)
              ])),
            ),
            Container(
              child: Text.rich(TextSpan(children: <TextSpan>[
                TextSpan(text: '（2）、在我们提供服务时，用于身份验证、客户服务、安全防范、诈骗监测、存档和备份用途，确保我们向您提供的产品和服务的安全性；', style: content)
              ])),
            ),
            Container(
              child: Text.rich(TextSpan(children: <TextSpan>[
              TextSpan(text: '  (3）、帮助我们设计新服务，改善我们现有服务；', style: content)
              ])),
            ),
            Container(
              child: Text.rich(TextSpan(children: <TextSpan>[
                TextSpan(text: '  (4）、使我们更加了解您如何接入和使用我们的服务，从而针对性回应您的个性化需求，例如语言设定、位置设定、个性化的帮助服务和指示，或对您和其他用户作出其他方面的回应；', style: content)
              ])),
            ),
            Container(
              child: Text.rich(TextSpan(children: <TextSpan>[
                TextSpan(text: '  (5）、向您提供与您更加相关的广告以替代普遍投放的广告；', style: content)
              ])),
            ),
            Container(
              child: Text.rich(TextSpan(children: <TextSpan>[
                TextSpan(text: '  (6）、评估我们服务中的广告和其他促销及推广活动的效果，并加以改善；', style: content)
              ])),
            ),
            Container(
              child: Text.rich(TextSpan(children: <TextSpan>[
                TextSpan(text: '  (7）、软件认证或管理软件升级；', style: content)
              ])),
            ),
            Container(
              child: Text.rich(TextSpan(children: <TextSpan>[
                TextSpan(text: '  (8）、让您参与有关我们产品和服务的调查。', style: content)
              ])),
            ),
            Container(
              child: Text.rich(TextSpan(children: <TextSpan>[
                TextSpan(text: '为了让您有更好的体验、改善我们的服务或您同意的其他用途，在符合相关法律法规的前提下，我们可能将通过某一项服务所收集的信息，以汇集信息或者个性化的方式，用于我们的其他服务。例如，在您使用我们的一项服务时所收集的信息，可能在另一服务中用于向您提供特定内容，或向您展示与您相关的、非普遍推送的信息。如果我们在相关服务中提供了相应选项，您也可以授权我们将该服务所提供和储存的信息用于我们的其他服务。', style: content)
              ])),
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: ScreenUtil().setWidth(12)),
              child: Text.rich(TextSpan(children: <TextSpan>[
                TextSpan(text: '6.3 ', style: secondTitle),
                TextSpan(text: '信息保护', style: content)
              ])),
            ),
            Container(
              child: Text.rich(TextSpan(children: <TextSpan>[
                TextSpan(text: '我们使用各种安全技术和程序，以防信息的丢失、不当使用、未经授权阅览或披露。例如，在某些服务中，我们将利用加密技术(例如SSL) 来保护您提供的个人信息。但请您理解，由于技术的限制以及可能存在的各种恶意手段，在互联网行业，即便竭尽所能加强安全措施，也不可能始终保证信息百分之百的安全。您需要了解，您接入我们的服务所用的系统和通讯网络，有可能因我们可控范围外的因素而出现问题。', style: content)
              ])),
            ),
            Container(
              child: Text.rich(TextSpan(children: <TextSpan>[
                TextSpan(text: '我们仅按照法律法规要求的时限保留您的个人信息。', style: content)
              ])),
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: ScreenUtil().setWidth(12)),
              child: Text('七、隐私保护的适用例外', style: secondTitle )
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: ScreenUtil().setWidth(12)),
              child: Text.rich(TextSpan(children: <TextSpan>[
                TextSpan(text: '7.1 ', style: secondTitle),
                TextSpan(text: '您利用 “共享”键将某些内容共享到我们的服务，或您利用第三方连线服务登录我们的服务。这些功能可能会收集您的相关信息(包括您的日志信息) ，并可能在您的电脑装置cookies，从而正常运行上述功能；', style: content)
              ])),
            ),
            Container(
              child: Text.rich(TextSpan(children: <TextSpan>[
                TextSpan(text: '（1）、您利用 “共享”键将某些内容共享到我们的服务，或您利用第三方连线服务登录我们的服务。这些功能可能会收集您的相关信息(包括您的日志信息) ，并可能在您的电脑装置cookies，从而正常运行上述功能；', style: content)
              ])),
            ),
            Container(
              child: Text.rich(TextSpan(children: <TextSpan>[
                TextSpan(text: '（2）、我们通过广告或我们服务的其他方式向您提供链接，使您可以接入第三方的服务或网站。', style: content)
              ])),
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: ScreenUtil().setWidth(12)),
              child: Text.rich(TextSpan(children: <TextSpan>[
                TextSpan(text: '7.2 ', style: secondTitle),
                TextSpan(text: '该等第三方社交媒体或其他服务可能由相关的第三方或我们运营。您使用该等第三方的社交媒体服务或其他服务(包括您向该等第三方提供的任何个人信息) ，须受该第三方的服务条款及隐私保护(而非本协议) 约束，您需要仔细阅读其条款。本协议仅适用于我们所收集的信息，并不适用于任何第三方提供的服务或第三方的信息使用规则，我们对任何第三方使用由您提供的信息不承担任何责任。', style: content)
              ])),
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: ScreenUtil().setWidth(12)),
              child: Text.rich(TextSpan(children: <TextSpan>[
                TextSpan(text: '7.3 ', style: secondTitle),
                TextSpan(text: '除某些特定服务外，我们所有的服务均适用本协议。这些特定服务将适用特定的隐私保护。针对某些特定服务的特定隐私保护，将更具体地说明我们在该等服务中如何使用您的信息。如相关特定服务的隐私保护与本协议有不一致之处，适用该特定服务的隐私保护。', style: content)
              ])),
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: ScreenUtil().setWidth(12)),
              child: Text.rich(TextSpan(children: <TextSpan>[
                TextSpan(text: '7.4 ', style: secondTitle),
                TextSpan(text: '请您注意，本协议不适用于以下情况：', style: content)
              ])),
            ),
            Container(
              child: Text.rich(TextSpan(children: <TextSpan>[
                TextSpan(text: '（1）、通过我们的服务而接入的第三方服务(包括任何第三方网站) 收集的信息；', style: content)
              ])),
            ),
            Container(
              child: Text.rich(TextSpan(children: <TextSpan>[
                TextSpan(text: '（2）、通过在我们服务中进行广告服务的其他公司或机构所收集的信息。', style: content)
              ])),
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: ScreenUtil().setWidth(12)),
              child: Text('八、收费服务', style: secondTitle )
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: ScreenUtil().setWidth(12)),
              child: Text.rich(TextSpan(children: <TextSpan>[
                TextSpan(text: '8.1 ', style: secondTitle),
                TextSpan(text: '我们的部分服务是以收费方式提供的，如您使用收费服务，请遵守相关的协议。', style: content)
              ])),
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: ScreenUtil().setWidth(12)),
              child: Text.rich(TextSpan(children: <TextSpan>[
                TextSpan(text: '8.2 ', style: secondTitle),
                TextSpan(text: '我们可能根据实际需要对收费服务的收费标准、方式进行修改和变更，我们也可能会对部分免费服务开始收费。前述修改、变更或开始收费前，我们将在相应服务页面进行通知或公告。如果您不同意上述修改、变更或付费内容，则应停止使用该服务。', style: content)
              ])),
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: ScreenUtil().setWidth(12)),
              child: Text('九、免责声明', style: secondTitle )
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: ScreenUtil().setWidth(12)),
              child: Text.rich(TextSpan(children: <TextSpan>[
                TextSpan(text: '9.1 ', style: secondTitle),
                TextSpan(text: '“车库电桩”不就互联网的中断或无法运作、技术故障、计算机错误或病毒、信息损坏或丢失或其它在本平台合理控制范围之外的原因而产生的其他任何性质的破坏而向用户或任何第三方承担赔偿责任。', style: content)
              ])),
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: ScreenUtil().setWidth(12)),
              child: Text.rich(TextSpan(children: <TextSpan>[
                TextSpan(text: '9.2 ', style: secondTitle),
                TextSpan(text: '车库电桩科技不保证用户在使用“车库电桩”时在操作上不会中断或没有错误，不保证会纠正“车库电桩”所有缺陷，亦不保证“车库电桩”能满足用户的所有要求', style: content)
              ])),
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: ScreenUtil().setWidth(12)),
              child: Text.rich(TextSpan(children: <TextSpan>[
                TextSpan(text: '9.3 ', style: secondTitle),
                TextSpan(text: '“车库电桩”不担保其所提供的网络服务一定能满足用户的要求，也不担保网络服务不会中断，对网络服务的及时性、安全性、准确性也都不作担保。如因“车库电桩”原因造成本平台不正常中断或其它技术故障，则用户同意所获唯一赔偿为不超过本协议项下已收取费用总额。', style: content)
              ])),
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: ScreenUtil().setWidth(12)),
              child: Text.rich(TextSpan(children: <TextSpan>[
                TextSpan(text: '9.4 ', style: secondTitle),
                TextSpan(text: '用户明确同意其使用“车库电桩”网络服务所存在的风险将完全由其自己承担；因其使用本网络服务而产生的一切后果也由其自己承担，车库电桩科技对用户不承担任何责任。', style: content)
              ])),
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: ScreenUtil().setWidth(12)),
              child: Text.rich(TextSpan(children: <TextSpan>[
                TextSpan(text: '9.5 ', style: secondTitle),
                TextSpan(text: '在所适用的法律允许范围内，任何一方均无须就数据的丢失和/或损坏及任何间接的、附带的、特殊的、后果性的损失向另一方负责赔偿。', style: content)
              ])),
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: ScreenUtil().setWidth(12)),
              child: Text.rich(TextSpan(children: <TextSpan>[
                TextSpan(text: '9.6 ', style: secondTitle),
                TextSpan(text: '“车库电桩”部分业务模块由第三方软件进行支撑，若此功能模块非本平台接口所造成的功能异常或第三方软件中所出现的任何内容错误，“车库电桩”不承担责任。', style: content)
              ])),
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: ScreenUtil().setWidth(12)),
              child: Text('十、其他', style: secondTitle )
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: ScreenUtil().setWidth(12)),
              child: Text.rich(TextSpan(children: <TextSpan>[
                TextSpan(text: '10.1 ', style: secondTitle),
                TextSpan(text: '本协议的订立、执行和解释及争议的解决均应适用中华人民共和国法律。', style: content)
              ])),
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: ScreenUtil().setWidth(12)),
              child: Text.rich(TextSpan(children: <TextSpan>[
                TextSpan(text: '10.2 ', style: secondTitle),
                TextSpan(text: '如双方就本协议内容或其执行发生任何争议，双方应通过友好协商的方式进行解决；协商不成时，任何一方均可向深圳车库电桩科技有限公司所在地深圳有管辖权的人民法院提起诉讼。', style: content)
              ])),
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: ScreenUtil().setWidth(12)),
              child: Text.rich(TextSpan(children: <TextSpan>[
                TextSpan(text: '10.3 ', style: secondTitle),
                TextSpan(text: '“车库电桩”未行使或执行本服务协议所规定的任何权利或规定，不构成对前述权利之放弃。', style: content)
              ])),
            ),
          ]
        ),
      )
    ),
    bottomNavigationBar: state.agreement == 'yes' ?
      const SizedBox(width: 0, height: 0) :
      Container(
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(top: BorderSide(color: Colors.grey, width: ScreenUtil().setWidth(1)))
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.max,
        children: <FlatButton>[
          FlatButton(
            child: Text('拒绝', style: TextStyle(color: Colors.grey),),
            onPressed: () {
              dispatch(UserAgreeMentActionCreator.onRefuseAction());
            },
          ),
          FlatButton(
            child: Text.rich(TextSpan(
              children: <TextSpan>[
                TextSpan(text: '同意', style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600)),
                state.count > 0 ? TextSpan(text: '(${state.count}s)', style: TextStyle(color: Colors.black, fontSize: ScreenUtil().setSp(24), fontWeight: FontWeight.w600)) : const TextSpan(text: ''),
              ]
            )
            ),
            onPressed: () {
              dispatch(UserAgreeMentActionCreator.onAgreeAction());
            },
          ),
        ]
      )
      ) 
  );
}
