



import 'dart:convert';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:CultreApp/modal/feedresponse/GetFeedResponse.dart' as Feedresponse;
import 'package:CultreApp/modal/feedtagfilter/GetTagFilterResponse.dart' as TagFilterResponse;
import 'package:CultreApp/ui/feed/feed.dart';
import 'package:CultreApp/ui/feed/feedpresenter.dart';
import 'package:CultreApp/ui/feed/feedview.dart';
import 'package:readmore/readmore.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../colors/colors.dart';

class FeedAdapter with ChangeNotifier {
var feeddata;

List<Feedresponse.Data>? databean;
FeedAdapter(this.feeddata,this.databean);

  void updateData(List<Feedresponse.Data> list) {
      databean!.addAll(list);
    notifyListeners(); // To rebuild the Widget
  }

  void cleanData() {
    databean!.clear();
    notifyListeners();
  }

  void updateItem(int type, int pos) {
    Feedresponse.Data? data = databean![pos];
    data.isSaved = type;
    if (type == 1) {
      data.savepost! + 1;
    } else {
      data.savepost! - 1;
    }
    databean![pos] = data;
    notifyListeners();
  }

  Feedresponse.Data getItem(int pos) {
    return databean!.elementAt(pos);
  }
}

