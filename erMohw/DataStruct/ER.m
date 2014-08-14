//
//  ER.m
//  erMohw
//
//  Created by Bunny Lin on 2014/8/11.
//  Copyright (c) 2014年 Bunny Lin. All rights reserved.
//

#import "ER.h"

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


- (NSString *)getName {    
    NSString *tmpName = [HOST_NAME_DICT objectForKey:self.hospital_sn];
    return tmpName;
}


@end
