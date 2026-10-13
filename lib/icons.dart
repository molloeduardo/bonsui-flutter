import 'package:bonsui/bonsui.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BonsuiIcons {
  static IconData get playArrow =>
      BonsuiUtils.isIos() ? CupertinoIcons.play_arrow_solid : Icons.play_arrow;
  static IconData get playArrowOutlined => BonsuiUtils.isIos()
      ? CupertinoIcons.play_arrow
      : Icons.play_arrow_outlined;
  static IconData get close =>
      BonsuiUtils.isIos() ? CupertinoIcons.clear : Icons.close;
  static IconData get closeCircle => BonsuiUtils.isIos()
      ? CupertinoIcons.clear_circled
      : Icons.cancel_outlined;
  static IconData get check =>
      BonsuiUtils.isIos() ? CupertinoIcons.check_mark : Icons.check;
  static IconData get checkCircleOutlined => BonsuiUtils.isIos()
      ? CupertinoIcons.check_mark_circled
      : Icons.check_circle_outline;
  static IconData get checkCircle => BonsuiUtils.isIos()
      ? CupertinoIcons.check_mark_circled_solid
      : Icons.check_circle;
  static IconData get arrowForward =>
      BonsuiUtils.isIos() ? CupertinoIcons.forward : Icons.arrow_forward;
  static IconData get arrowBack =>
      BonsuiUtils.isIos() ? CupertinoIcons.back : Icons.arrow_back;
  static IconData get arrowRight =>
      BonsuiUtils.isIos() ? CupertinoIcons.arrow_right : Icons.arrow_right;
  static IconData get add =>
      BonsuiUtils.isIos() ? CupertinoIcons.add : Icons.add;
  static IconData get person =>
      BonsuiUtils.isIos() ? CupertinoIcons.person : Icons.person;
  static IconData get home =>
      BonsuiUtils.isIos() ? CupertinoIcons.home : Icons.home;
  static IconData get book =>
      BonsuiUtils.isIos() ? CupertinoIcons.book : Icons.book;
  static IconData get settings =>
      BonsuiUtils.isIos() ? CupertinoIcons.settings : Icons.settings;
  static IconData get brightnessAuto =>
      BonsuiUtils.isIos() ? CupertinoIcons.sun_haze : Icons.brightness_auto;
  static IconData get brightnessHigh =>
      BonsuiUtils.isIos() ? CupertinoIcons.sun_max : Icons.brightness_7;
  static IconData get brightnessLow =>
      BonsuiUtils.isIos() ? CupertinoIcons.moon : Icons.brightness_3;
  static IconData get work =>
      BonsuiUtils.isIos() ? CupertinoIcons.briefcase : Icons.work;
  static IconData get web =>
      BonsuiUtils.isIos() ? CupertinoIcons.globe : Icons.web;
  static IconData get reset =>
      BonsuiUtils.isIos() ? CupertinoIcons.restart : Icons.refresh;
  static IconData get delete =>
      BonsuiUtils.isIos() ? CupertinoIcons.delete : Icons.delete;
  static IconData get vibrate => Icons.vibration;
  static IconData get volumeUp =>
      BonsuiUtils.isIos() ? CupertinoIcons.volume_up : Icons.volume_up;
  static IconData get hint =>
      BonsuiUtils.isIos() ? CupertinoIcons.lightbulb : Icons.lightbulb;
  static IconData get hintOff => BonsuiUtils.isIos()
      ? CupertinoIcons.lightbulb_slash
      : Icons.lightbulb_outline;
  static IconData get hourglassBottom => BonsuiUtils.isIos()
      ? CupertinoIcons.hourglass_bottomhalf_fill
      : Icons.hourglass_bottom;
  static IconData get verified =>
      BonsuiUtils.isIos() ? CupertinoIcons.checkmark_seal_fill : Icons.verified;
  static IconData get analyticsOutlined =>
      BonsuiUtils.isIos() ? CupertinoIcons.chart_bar : Icons.analytics_outlined;
  static IconData get analytics =>
      BonsuiUtils.isIos() ? CupertinoIcons.chart_bar_alt_fill : Icons.analytics;
  static IconData get search =>
      BonsuiUtils.isIos() ? CupertinoIcons.search : Icons.search;
  static IconData get calendar =>
      BonsuiUtils.isIos() ? CupertinoIcons.calendar : Icons.calendar_today;
  static IconData get locked => BonsuiUtils.isIos()
      ? CupertinoIcons.lock_fill
      : Icons.lock_outline_rounded;
  static IconData get trophyOutlined => Icons.emoji_events_outlined;
  static IconData get trophy => Icons.emoji_events;
  static IconData get clock => BonsuiUtils.isIos()
      ? CupertinoIcons.clock_fill
      : Icons.access_time_filled_rounded;
  static IconData get clockOutlined =>
      BonsuiUtils.isIos() ? CupertinoIcons.clock : Icons.access_time;
  static IconData get celebration =>
      BonsuiUtils.isIos() ? CupertinoIcons.sparkles : Icons.celebration;
  static IconData get warning => BonsuiUtils.isIos()
      ? CupertinoIcons.exclamationmark_triangle_fill
      : Icons.warning;
  static IconData get warningOutlined => BonsuiUtils.isIos()
      ? CupertinoIcons.exclamationmark_triangle
      : Icons.warning_amber_outlined;
  static IconData get cloudDownload => BonsuiUtils.isIos()
      ? CupertinoIcons.cloud_download_fill
      : Icons.cloud_download;
  static IconData get review =>
      BonsuiUtils.isIos() ? CupertinoIcons.star_fill : Icons.star_rate_rounded;
  static IconData get militaryTech => Icons.military_tech_outlined;
  static IconData get save =>
      BonsuiUtils.isIos() ? CupertinoIcons.floppy_disk : Icons.save;
  static IconData get user => BonsuiUtils.isIos()
      ? CupertinoIcons.person_alt_circle
      : Icons.account_circle_outlined;
  static IconData get mailOutlined =>
      BonsuiUtils.isIos() ? CupertinoIcons.mail : Icons.email_outlined;
  static IconData get mail =>
      BonsuiUtils.isIos() ? CupertinoIcons.mail_solid : Icons.email;
  static IconData get lock =>
      BonsuiUtils.isIos() ? CupertinoIcons.lock_fill : Icons.lock;
  static IconData get logout =>
      BonsuiUtils.isIos() ? CupertinoIcons.square_arrow_left : Icons.logout;
  static IconData get number =>
      BonsuiUtils.isIos() ? CupertinoIcons.number : Icons.numbers;
  static IconData get info =>
      BonsuiUtils.isIos() ? CupertinoIcons.info : Icons.info_outline_rounded;
  static IconData get error => BonsuiUtils.isIos()
      ? CupertinoIcons.exclamationmark_circle
      : Icons.error_outline;
  static IconData get airplane =>
      BonsuiUtils.isIos() ? CupertinoIcons.airplane : Icons.airplanemode_active;
  static IconData get wifiOff =>
      BonsuiUtils.isIos() ? CupertinoIcons.wifi_slash : Icons.wifi_off;
  static IconData get moreVert =>
      BonsuiUtils.isIos() ? CupertinoIcons.ellipsis_vertical : Icons.more_vert;
  static IconData get moreHoriz =>
      BonsuiUtils.isIos() ? CupertinoIcons.ellipsis : Icons.more_horiz;
  static IconData get share =>
      BonsuiUtils.isIos() ? CupertinoIcons.share : Icons.share;
  static IconData get gallery => BonsuiUtils.isIos()
      ? CupertinoIcons.photo_fill_on_rectangle_fill
      : Icons.photo_library;
  static IconData get mapFill =>
      BonsuiUtils.isIos() ? CupertinoIcons.map_fill : Icons.map;
  static IconData get backspace =>
      BonsuiUtils.isIos() ? CupertinoIcons.delete_left : Icons.backspace;
  static IconData get chevronDown =>
      BonsuiUtils.isIos() ? CupertinoIcons.chevron_down : Icons.expand_more;
  static IconData get chevronUp =>
      BonsuiUtils.isIos() ? CupertinoIcons.chevron_up : Icons.expand_less;
  static IconData get chevronLeft =>
      BonsuiUtils.isIos() ? CupertinoIcons.chevron_left : Icons.chevron_left;
  static IconData get chevronRight =>
      BonsuiUtils.isIos() ? CupertinoIcons.chevron_right : Icons.chevron_right;
  static IconData get location =>
      BonsuiUtils.isIos() ? CupertinoIcons.location_fill : Icons.location_on;
  static IconData get place => Icons.place;
  static IconData get question =>
      BonsuiUtils.isIos() ? CupertinoIcons.question : Icons.help;
  static IconData get questionOutlined => BonsuiUtils.isIos()
      ? CupertinoIcons.question_circle
      : Icons.help_outline_rounded;
  static IconData get list =>
      BonsuiUtils.isIos() ? CupertinoIcons.list_bullet : Icons.list;
  static IconData get dragHandle => BonsuiUtils.isIos()
      ? CupertinoIcons.line_horizontal_3
      : Icons.drag_handle;
  static IconData get target =>
      BonsuiUtils.isIos() ? CupertinoIcons.flag : Icons.flag;
  static IconData get laptop =>
      BonsuiUtils.isIos() ? CupertinoIcons.device_laptop : Icons.laptop_mac;
  static IconData get text =>
      BonsuiUtils.isIos() ? CupertinoIcons.textformat : Icons.text_fields;
  static IconData get phone =>
      BonsuiUtils.isIos() ? CupertinoIcons.phone : Icons.phone_android;
  static IconData get folder =>
      BonsuiUtils.isIos() ? CupertinoIcons.folder : Icons.folder_open;
  static IconData get pause =>
      BonsuiUtils.isIos() ? CupertinoIcons.pause : Icons.pause;
  static IconData get music =>
      BonsuiUtils.isIos() ? CupertinoIcons.music_note : Icons.music_note;
  static IconData get arrowDown =>
      BonsuiUtils.isIos() ? CupertinoIcons.arrow_down : Icons.arrow_downward;
  static IconData get arrowUp =>
      BonsuiUtils.isIos() ? CupertinoIcons.arrow_up : Icons.arrow_upward;
  static IconData get chartBar =>
      BonsuiUtils.isIos() ? CupertinoIcons.chart_bar : Icons.bar_chart;
  static IconData get volumeOff =>
      BonsuiUtils.isIos() ? CupertinoIcons.speaker_slash : Icons.volume_off;
  static IconData get arrowLeft =>
      BonsuiUtils.isIos() ? CupertinoIcons.arrow_left : Icons.arrow_left;
  static IconData get chartPie =>
      BonsuiUtils.isIos() ? CupertinoIcons.chart_pie : Icons.pie_chart;
  static IconData get heart =>
      BonsuiUtils.isIos() ? CupertinoIcons.heart_fill : Icons.favorite;
  static IconData get heartOutlined =>
      BonsuiUtils.isIos() ? CupertinoIcons.heart : Icons.favorite_border;
  static IconData get star =>
      BonsuiUtils.isIos() ? CupertinoIcons.star_fill : Icons.star;
  static IconData get starOutlined =>
      BonsuiUtils.isIos() ? CupertinoIcons.star : Icons.star_border;
  static IconData get leaderboard =>
      BonsuiUtils.isIos() ? CupertinoIcons.chart_bar : Icons.leaderboard;
  static IconData get circle =>
      BonsuiUtils.isIos() ? CupertinoIcons.circle_fill : Icons.circle;
  static IconData get sun =>
      BonsuiUtils.isIos() ? CupertinoIcons.sun_max_fill : Icons.wb_sunny;
  static IconData get sound => BonsuiUtils.isIos()
      ? CupertinoIcons.speaker_3_fill
      : Icons.volume_up_rounded;
  static IconData get flag =>
      BonsuiUtils.isIos() ? CupertinoIcons.flag_fill : Icons.flag;
  static IconData get currencyDollar =>
      BonsuiUtils.isIos() ? CupertinoIcons.money_dollar : Icons.attach_money;
  static IconData get wallet => BonsuiUtils.isIos()
      ? CupertinoIcons.creditcard_fill
      : Icons.account_balance_wallet;
  static IconData get bookmark =>
      BonsuiUtils.isIos() ? CupertinoIcons.bookmark_fill : Icons.bookmark;
  static IconData get bookmarkOutlined =>
      BonsuiUtils.isIos() ? CupertinoIcons.bookmark : Icons.bookmark_border;
  static IconData get edit =>
      BonsuiUtils.isIos() ? CupertinoIcons.pencil : Icons.edit;
  static IconData get send =>
      BonsuiUtils.isIos() ? CupertinoIcons.paperplane_fill : Icons.send;
  static IconData get language =>
      BonsuiUtils.isIos() ? CupertinoIcons.globe : Icons.language;
  static IconData get alert => BonsuiUtils.isIos()
      ? CupertinoIcons.bell_fill
      : Icons.notifications_active;
  static IconData get thumbsUpOutlined => BonsuiUtils.isIos()
      ? CupertinoIcons.hand_thumbsup
      : Icons.thumb_up_outlined;
  static IconData get thumbsUp =>
      BonsuiUtils.isIos() ? CupertinoIcons.hand_thumbsup_fill : Icons.thumb_up;
  static IconData get deviceDesktop => BonsuiUtils.isIos()
      ? CupertinoIcons.device_desktop
      : Icons.desktop_windows;
  static IconData get deviceLaptop =>
      BonsuiUtils.isIos() ? CupertinoIcons.device_laptop : Icons.laptop_mac;
  static IconData get deviceMobile => BonsuiUtils.isIos()
      ? CupertinoIcons.device_phone_portrait
      : Icons.smartphone;
  static IconData get download => BonsuiUtils.isIos()
      ? CupertinoIcons.square_arrow_down_fill
      : Icons.download;
  static IconData get downloadOutlined => BonsuiUtils.isIos()
      ? CupertinoIcons.square_arrow_down
      : Icons.download_outlined;
  static IconData get refresh =>
      BonsuiUtils.isIos() ? CupertinoIcons.refresh : Icons.refresh;
  static IconData get ban =>
      BonsuiUtils.isIos() ? CupertinoIcons.xmark_octagon_fill : Icons.block;
  static IconData get dashboard => BonsuiUtils.isIos()
      ? CupertinoIcons.square_grid_2x2_fill
      : Icons.dashboard;
  static IconData get coffee =>
      BonsuiUtils.isIos() ? Icons.coffee : Icons.coffee;
  static IconData get coffeeOutlined =>
      BonsuiUtils.isIos() ? Icons.coffee_outlined : Icons.coffee_outlined;
  static IconData get swapHoriz => BonsuiUtils.isIos()
      ? CupertinoIcons.arrow_right_arrow_left
      : Icons.swap_horiz;
  static IconData get sparkles =>
      BonsuiUtils.isIos() ? CupertinoIcons.sparkles : Icons.auto_awesome;
  static IconData get reddit => Icons.reddit;
  static IconData get apple => Icons.apple;
}
