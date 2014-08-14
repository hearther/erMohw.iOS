//
//  ER.m
//  erMohw
//
//  Created by Bunny Lin on 2014/8/11.
//  Copyright (c) 2014年 Bunny Lin. All rights reserved.
//

#import "ER.h"


static NSDictionary *hospNameDict;
@implementation WardInfo
- (int) getValueWithDispStat:(gvPendingVCDisplayStatus) stat
{
    
    switch (stat) {
        case gvPendingWard:
            return self.pending_ward;
            break;
        case gvPendingDoc:
            return self.pending_doctor;
            break;
        case gvPendingBed:
            return self.pending_bed;
            break;
        case gvPendingBedDiff:
            return self.bed_diff;
            break;
        case gvPendingICU:
            return self.pending_icu;
            break;
        case gvPendingICUDiff:
            return self.icu_diff;
            break;
            
        default:
            return 0;
            break;
    }
}

@end

@implementation ER
+ (void)initialize
{
    if(self == [ER class])
    {
        hospNameDict = [NSDictionary dictionaryWithObjectsAndKeys:
                     @"大甲光田",	@"1536030075",
                     @"三總",	@"0501110514",
                     @"台中榮總",	@"0617060018",
                     @"童綜",	@"0936060016",
                     @"博愛",	@"1434020015",
                     @"秀傳",	@"0937010019",
                     @"高雄長庚",	@"1142100017",
                     @"萬芳",	@"1301200010",
                     @"新光",	@"1101150011",
                     @"淡水馬偕",	@"1131100010",
                     @"中國醫大",	@"1317050017",
                     @"安泰",	@"0943030019",
                     @"台大",	@"0401180014",
                     @"嘉基",	@"1122010012",
                     @"慈濟",	@"1145010010",
                     @"雲林台大",	@"0439010518",
                     @"彰基",	@"1137010024",
                     @"台北慈濟",	@"1131050515",
                     @"高雄榮總",	@"0602030026",
                     @"成大",	@"0421040011",
                     @"林口長庚",	@"1132070011",
                     @"義大",	@"1142120001",
                     @"嘉義長庚",	@"1140010510",
                     @"亞東",	@"1131010011",
                     @"沙鹿光田",	@"0936050029",
                     @"國泰",	@"1101020018",
                     @"榮總",	@"0601160016",
                     @"基隆長庚",	@"1111060015",
                     @"奇美",	@"1141310019",
                     @"高醫",	@"1302050014",
                     @"雙和",	@"1331040513",
                     @"台北馬偕",	@"1101100011",
                     @"中山醫大",	@"1317040011", nil];

    }
}

- (NSString *)getName {    
    NSString *tmpName = [hospNameDict objectForKey:self.hospital_sn];
    return tmpName;
}


@end
