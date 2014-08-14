//
//  gvPendingVC.m
//  erMohw
//
//  Created by Bunny Lin on 2014/8/11.
//  Copyright (c) 2014年 Bunny Lin. All rights reserved.
//

#import "gvPendingVC.h"
#import "NetworkMM.h"
#import "gvLineInfoCollViewCell.h"
#import "ActionSheetStringPicker.h"

NSArray *erArrayWithGVPendingVCZone(gvPendingVCDisplayZone zone) {
    return (NSArray *)[ZONE_HOST_ARRAY objectAtIndex:zone];
}

@interface gvPendingVC ()

@end

@implementation gvPendingVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.lineView.dataSource = self;
    self.lineView.delegate = self;
    
    //initial status
    self.curDisplayStat = -1;
    self.curDisplayZone = -1;
    
    
//    self.lineView.frame = CGRectMake(0, 40, 320, self.view.frame.size.height-40-self.infoCollView.frame.size.height);
//    self.infoView.frame = CGRectMake(0, 40+self.lineView.frame.size.height, 320, 80);

    
    [self quryFun];
	
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark internal function

- (NSArray *) genRandomColorArrayWithSize:(int) size
{
    NSMutableArray *tmpColor = [[NSMutableArray alloc] init];
    for (int x=0; x< size;x++){
        CGFloat hue = ( arc4random() % 256 / 256.0 );  //  0.0 to 1.0
        CGFloat saturation = ( arc4random() % 128 / 256.0 ) + 0.5;  //  0.5 to 1.0, away from white
        CGFloat brightness = ( arc4random() % 128 / 256.0 ) + 0.5;  //  0.5 to 1.0, away from black
        UIColor *color = [UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:1];
        [tmpColor addObject:color];
    }
    return tmpColor;
}

- (void) quryFun{
    // subclass doing
    
    [[NetworkMM sharedNetworkMM] queryAllPendingInPast24hr:^(AFHTTPRequestOperation *operation, id responseObject) {
        self.allHospInfo = responseObject;
        self.allHospColor = [self genRandomColorArrayWithSize:[self.allHospInfo count]];
        [self updateUIWithStat:gvPendingWard
                          zone:gvZoneAll];
        
    }
                                                   failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                                           NSLog(@"Error: %@", error);
                                                       }];
    
    
}

- (void) updateUIWithStat:(gvPendingVCDisplayStatus) stat
                     zone:(gvPendingVCDisplayZone) zone
{
    self.curDisplayStat = stat;
    if (self.curDisplayZone != zone){
        self.curDisplayZone = zone;
     
        if (self.curDisplayZone == gvZoneAll){
            self.filteredHospInfo = self.allHospInfo;
            self.filteredHospColor = self.allHospColor;
        }
        else {
            NSArray *zoneHospArr = [ZONE_HOST_ARRAY objectAtIndex:self.curDisplayZone];
            NSMutableArray *tmpHosp = [[NSMutableArray alloc] init];
            NSMutableArray *tmpHospColor = [[NSMutableArray alloc] init];
            for (int x = 0; x<[self.allHospInfo count]; x++ ){
                ER *er = [self.allHospInfo objectAtIndex:x];
                if ([zoneHospArr indexOfObject:er.hospital_sn] != NSNotFound){
                    [tmpHosp addObject:er];
                    [tmpHospColor addObject:[self.allHospColor objectAtIndex:x]];
                }
            }
            self.filteredHospInfo = tmpHosp;
            self.filteredHospColor = tmpHospColor;
        }
    }
    
    
    [self.curDisplayInfo setText:[STAT_NAME_ARRAY objectAtIndex:stat]];
    [self.curDisplayZoneLabel setText:[ZONE_NAME_ARRAY objectAtIndex:zone]];
    [self.lineView reloadData];
    [self.infoCollView reloadData];

}


#pragma mark ibaction
- (IBAction) changeDisplay:(id)sender
{
    [ActionSheetStringPicker showPickerWithTitle:@"請選擇"
                                            rows:STAT_NAME_ARRAY
                                initialSelection:0
                                       doneBlock:^(ActionSheetStringPicker *picker, NSInteger selectedIndex, id selectedValue) {
                                           NSLog(@"Picker: %@", picker);
                                           NSLog(@"Selected Index: %d", selectedIndex);
                                           NSLog(@"Selected Value: %@", selectedValue);
                                           if (self.curDisplayStat == selectedIndex)
                                               return ;
                                           [self updateUIWithStat:selectedIndex
                                                             zone:self.curDisplayZone];
                                       }
                                     cancelBlock:nil
                                          origin:sender];
}


- (IBAction) changeZone:(id)sender
{
    [ActionSheetStringPicker showPickerWithTitle:@"請選擇"
                                            rows:ZONE_NAME_ARRAY
                                initialSelection:0
                                       doneBlock:^(ActionSheetStringPicker *picker, NSInteger selectedIndex, id selectedValue) {
                                           NSLog(@"Picker: %@", picker);
                                           NSLog(@"Selected Index: %d", selectedIndex);
                                           NSLog(@"Selected Value: %@", selectedValue);
                                           if (self.curDisplayZone == selectedIndex)
                                               return ;
                                           [self updateUIWithStat:self.curDisplayStat
                                                             zone:selectedIndex];
                                       }
                                     cancelBlock:nil
                                          origin:sender];
}

#pragma mark JBLineChartView
- (NSUInteger)numberOfLinesInLineChartView:(JBLineChartView *)lineChartView
{
    return [self.filteredHospInfo count];
}

- (NSUInteger)lineChartView:(JBLineChartView *)lineChartView
numberOfVerticalValuesAtLineIndex:(NSUInteger)lineIndex
{
    ER *er = [self.filteredHospInfo objectAtIndex:lineIndex];
    return [er.wardingInfos count]; // number of values for a line
}
- (CGFloat)lineChartView:(JBLineChartView *)lineChartView
verticalValueForHorizontalIndex:(NSUInteger)horizontalIndex
             atLineIndex:(NSUInteger)lineIndex
{
    ER *er = [self.filteredHospInfo objectAtIndex:lineIndex];
    WardInfo *info = [er.wardingInfos objectAtIndex:horizontalIndex]; // number of values for a line
   
    return [info getValueWithDispStat:self.curDisplayStat];
    
}

- (UIColor *)lineChartView:(JBLineChartView *)lineChartView
   colorForLineAtLineIndex:(NSUInteger)lineIndex
{
    return [self.filteredHospColor objectAtIndex:lineIndex]; // color of line in chart
}


- (CGFloat)lineChartView:(JBLineChartView *)lineChartView
 widthForLineAtLineIndex:(NSUInteger)lineIndex
{
    return 2; // width of line in chart
}

- (void)lineChartView:(JBLineChartView *)lineChartView
 didSelectLineAtIndex:(NSUInteger)lineIndex
      horizontalIndex:(NSUInteger)horizontalIndex
           touchPoint:(CGPoint)touchPoint
{
    [self.infoCollView setHidden:TRUE];
    [self.info setHidden:FALSE];
    // Update view
    ER *er = [self.filteredHospInfo objectAtIndex:lineIndex];
    WardInfo *info = [er.wardingInfos objectAtIndex:horizontalIndex];
    NSString *name = [er getName];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy MM-dd HH:mm"];
    NSString *strDate = [dateFormatter stringFromDate:info.time];
    
    
    int number = [info getValueWithDispStat:self.curDisplayStat];
    
    [self.info setText:[NSString stringWithFormat:@"%@ :%@ %d",name,strDate, number]];
}

- (void)didDeselectLineInLineChartView:(JBLineChartView *)lineChartView
{
    // Update view
    [self.info setText:@""];
    [self.infoCollView setHidden:FALSE];
    [self.info setHidden:TRUE];
    
}

#pragma mark UICollectionView

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return self.filteredHospInfo?([self.filteredHospInfo count]/4)+1:0;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView
     numberOfItemsInSection:(NSInteger)section
{
    return self.filteredHospInfo?(section< ([self.filteredHospInfo count]/4) ?4:[self.filteredHospInfo count]%4):0;
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    gvLineInfoCollViewCell *myCell = [collectionView
                                    dequeueReusableCellWithReuseIdentifier:@"gvLineInfoCollViewCell"
                                    forIndexPath:indexPath];
    NSUInteger index = indexPath.section*4+indexPath.row;
    
    if (index < [self.filteredHospInfo count]){
        ER *er = [self.filteredHospInfo objectAtIndex:index];
        NSString *name = [er getName];
        WardInfo *info = [er.wardingInfos lastObject];
        
        int number = [info getValueWithDispStat:self.curDisplayStat];
        
        [myCell.name setText:[NSString stringWithFormat:@"%@: %d",name, number]];
        [myCell.colorView setBackgroundColor:[self.filteredHospColor objectAtIndex:index]];
    
        return myCell;
    }
    else{
        return  NULL;
    }
}


@end
