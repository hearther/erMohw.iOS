//
//  gvPendingVC.h
//  erMohw
//
//  Created by Bunny Lin on 2014/8/11.
//  Copyright (c) 2014年 Bunny Lin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JBChartView/JBLineChartView.h"
#include "CommonDef.h"


@interface gvPendingVC : UIViewController
<JBLineChartViewDataSource, JBLineChartViewDelegate,
UICollectionViewDataSource, UICollectionViewDelegate>
@property (nonatomic, retain) IBOutlet JBLineChartView *lineView;
@property (nonatomic, retain) IBOutlet UIView *infoView;
@property (nonatomic, retain) IBOutlet UICollectionView *infoCollView;
@property (nonatomic, retain) IBOutlet UILabel *info;

@property (nonatomic, retain) NSArray *allHospInfo;
@property (nonatomic, retain) NSArray *allHospColor;
@property (nonatomic, retain) NSArray *filteredHospInfo;
@property (nonatomic, retain) NSArray *filteredHospColor;


@property (nonatomic, retain) IBOutlet UILabel *curDisplayInfo;
@property gvPendingVCDisplayStatus curDisplayStat;
@property (nonatomic, retain) IBOutlet UILabel *curDisplayZoneLabel;
@property gvPendingVCDisplayZone curDisplayZone;


- (IBAction) changeDisplay:(id)sender;
- (IBAction) changeZone:(id)sender;
@end
