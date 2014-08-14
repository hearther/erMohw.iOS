//
//  gvPendingWardVC.m
//  erMohw
//
//  Created by Bunny Lin on 2014/8/11.
//  Copyright (c) 2014年 Bunny Lin. All rights reserved.
//

#import "gvPendingWardVC.h"
#import "NetworkMM.h"
#import "CommonDef.h"
#import "gvLineInfoCollViewCell.h"

@interface gvPendingWardVC ()

@end

@implementation gvPendingWardVC

- (void)viewDidLoad
{
    [super viewDidLoad];
	
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark internal function
- (void) quryFun{
    // subclass doing
    // Do any additional setup after loading the view, typically from a nib.
    [[NetworkMM sharedNetworkMM] queryAllPendingWardInPast24hr:^(AFHTTPRequestOperation *operation, id responseObject) {
        self.hospInfo = responseObject;
        self.lineView.frame = CGRectMake(0, 20, 320, self.view.frame.size.height-69-self.infoCollView.frame.size.height);
        self.infoView.frame = CGRectMake(0, 20+self.view.frame.size.height-69-self.infoCollView.frame.size.height, 320, 100);
        
        NSMutableArray *tmpColor = [[NSMutableArray alloc] init];
        for (int x=0; x< [self.hospInfo count];x++){
            CGFloat hue = ( arc4random() % 256 / 256.0 );  //  0.0 to 1.0
            CGFloat saturation = ( arc4random() % 128 / 256.0 ) + 0.5;  //  0.5 to 1.0, away from white
            CGFloat brightness = ( arc4random() % 128 / 256.0 ) + 0.5;  //  0.5 to 1.0, away from black
            UIColor *color = [UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:1];
            [tmpColor addObject:color];
        }
        self.hospColor = tmpColor;
        [self.curDisplay setText:@"等待住院人數"];
        
        [self.lineView reloadData];
        [self.infoCollView reloadData];
        
    }
                                                       failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                                           NSLog(@"Error: %@", error);
                                                       }];
}
@end