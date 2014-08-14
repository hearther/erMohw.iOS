//
//  ER.h
//  erMohw
//
//  Created by Bunny Lin on 2014/8/11.
//  Copyright (c) 2014年 Bunny Lin. All rights reserved.
//

#import <Foundation/Foundation.h>
#include "CommonDef.h"

@interface WardInfo : NSObject
@property (nonatomic, strong) NSDate *time;
//@property int ward_diff;
@property int pending_doctor;           // (integer) 等待看診人數
@property int pending_bed;           // (integer) 等待推床人數
@property int bed_diff;
@property int pending_ward;           // (integer) 等待住院人數
@property int pending_icu;           // (integer) 等待加護病床人數
@property int icu_diff;
- (int) getValueWithDispStat:(gvPendingVCDisplayStatus) stat;
@end


@interface ER : NSObject
@property (nonatomic, strong) NSString *hospital_sn;
@property (nonatomic, strong) NSMutableArray *wardingInfos;
- (NSString *)getName;
@end
