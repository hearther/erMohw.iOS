//
//  CommonDef.h
//  erMohw
//
//  Created by Bunny Lin on 2014/8/11.
//  Copyright (c) 2014年 Bunny Lin. All rights reserved.
//

#ifndef erMohw_CommonDef_h
#define erMohw_CommonDef_h

typedef NS_ENUM(NSUInteger, gvPendingVCDisplayStatus) {
    gvPendingWard,
    gvPendingDoc,
    gvPendingBed,
    gvPendingBedDiff,
    gvPendingICU,
    gvPendingICUDiff,
};


typedef NS_ENUM(NSUInteger, gvPendingVCDisplayZone) {
    gvZoneAll,
    gvZoneTaipei,
    gvZoneNewTaipei,
    gvZoneKeelung,
    gvZoneTaoyuan,
    gvZoneTaichung,
    gvZoneChanghua,
    gvZoneYunlin,
    gvZoneChiayi,
    gvZoneTainan,
    gvZoneKaohsiung,
    gvZonePingtung,
    gvZoneHualien,
    gvZoneIlan,
};

#define STAT_NAME_ARRAY [NSArray arrayWithObjects: \
@"等待住院人數",\
@"等待看診人數",\
@"等候推床人數",\
@"急診等床變化(病房是否持續滿床)",\
@"等待加護病房人數",\
@"加護病床等床變化(加護病房是否持續滿床)", nil]

#define ZONE_NAME_ARRAY [NSArray arrayWithObjects: \
@"全部", \
@"台北市",\
@"新北市",\
@"基隆市",\
@"桃園縣",\
@"台中市",\
@"彰化縣",\
@"雲林縣",\
@"嘉義縣",\
@"台南市",\
@"高雄市",\
@"屏東縣",\
@"花蓮縣",\
@"宜蘭縣", nil]


#define ZONE_HOST_ARRAY [NSArray arrayWithObjects: \
@[@"all"],\
@[@"1101020018",@"1101100011",@"1301200010",@"0501110514",@"0601160016",@"0401180014",@"1101150011"],\
@[@"1111060015",@"1331040513",@"1131010011",@"1131050515"],\
@[@"1111060015"],\
@[@"1132070011"],\
@[@"1317040011",@"0617060018",@"1317050017",@"0936060016",@"0936050029",@"1536030075"],\
@[@"1137010024",@"0937010019"],\
@[@"0439010518"],\
@[@"1140010510",@"1122010012"],\
@[@"1141310019",@"0421040011"],\
@[@"1302050014",@"1142120001",@"0602030026",@"1142100017"],\
@[@"0943030019"],\
@[@"1145010010"],\
@[@"1434020015"], nil]


#define HOST_NAME_DICT [NSDictionary dictionaryWithObjectsAndKeys:\
@"大甲光田",	@"1536030075",\
@"三總",	@"0501110514",\
@"台中榮總",	@"0617060018",\
@"童綜",	@"0936060016",\
@"博愛",	@"1434020015",\
@"秀傳",	@"0937010019",\
@"高雄長庚",	@"1142100017",\
@"萬芳",	@"1301200010",\
@"新光",	@"1101150011",\
@"淡水馬偕",	@"1131100010",\
@"中國醫大",	@"1317050017",\
@"安泰",	@"0943030019",\
@"台大",	@"0401180014",\
@"嘉基",	@"1122010012",\
@"慈濟",	@"1145010010",\
@"雲林台大",	@"0439010518",\
@"彰基",	@"1137010024",\
@"台北慈濟",	@"1131050515",\
@"高雄榮總",	@"0602030026",\
@"成大",	@"0421040011",\
@"林口長庚",	@"1132070011",\
@"義大",	@"1142120001",\
@"嘉義長庚",	@"1140010510",\
@"亞東",	@"1131010011",\
@"沙鹿光田",	@"0936050029",\
@"國泰",	@"1101020018",\
@"榮總",	@"0601160016",\
@"基隆長庚",	@"1111060015",\
@"奇美",	@"1141310019",\
@"高醫",	@"1302050014",\
@"雙和",	@"1331040513",\
@"台北馬偕",	@"1101100011",\
@"中山醫大",	@"1317040011", nil]

#endif
