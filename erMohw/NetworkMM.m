//
//  NetworkMM.m
//  erMohw
//
//  Created by Bunny Lin on 2014/8/11.
//  Copyright (c) 2014年 Bunny Lin. All rights reserved.
//

#import "NetworkMM.h"


@implementation NetworkMM
static NetworkMM *sharedNetworkMM = nil;

+ (NetworkMM *)sharedNetworkMM
{
    @synchronized(self) {
        if (sharedNetworkMM == nil) {
            sharedNetworkMM = [[self alloc] init];
        }
    }
    return sharedNetworkMM;
}


- (void) queryDB:(NSString *)queryStr
         success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
         failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure
{
    if (queryStr == NULL || [queryStr length] == 0)
        return;
    
    // Override point for customization after application launch.
    NSDictionary *parameters = @{@"u": @"guest",
                                 @"p": @"guest",
                                 @"q": queryStr};
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:@"http://api-beta.ly.g0v.tw:8086/db/twer/series"
      parameters:parameters
         success:success
         failure:failure];
}

- (void)query:(void (^)(AFHTTPRequestOperation *, id))success
                                     failure:(void (^)(AFHTTPRequestOperation *, NSError *))failure
{
    
    [self queryDB:@"select difference(pending_ward) from /ER.+/ where time > now() - 24h group by time(20m) order asc"
          success:^(AFHTTPRequestOperation *operation, id responseObject) {
              NSLog(@"JSON: %@", responseObject);
               NSMutableDictionary *tmpDict = [[NSMutableDictionary alloc] init];
              
              for (int x = 0; x< [responseObject count]; x++){
                  NSDictionary *erInfo = [responseObject objectAtIndex:x];
                  NSString *name = [erInfo valueForKey:@"name"];
                  name = [[name componentsSeparatedByString:@"."] objectAtIndex:1];
                  NSArray *columns = [erInfo valueForKey:@"columns"];
                  NSUInteger timeIndex = [columns indexOfObject:@"time"];
                  //NSUInteger diffIndex = [columns indexOfObject:@"difference"];
                 
                  ER *er = NULL;
                  if ([tmpDict objectForKey:name] == NULL){
                      ER *newER = [[ER alloc] init];
                      newER.hospital_sn = name;
                      newER.wardingInfos = [[NSMutableArray alloc] init];
                      [tmpDict setObject:newER forKey:name];
                      er = newER;
                  }
                  else {
                      er = [tmpDict objectForKey:name];
                  }
                  NSArray *points = [erInfo valueForKey:@"points"];
                  for (int y = 0; y< [points count]; y++){
                      NSArray *point = [points objectAtIndex:y];
                      NSTimeInterval timestamp = [[point objectAtIndex:timeIndex] doubleValue];
                      WardInfo *newInfo = [[WardInfo alloc] init];
                      newInfo.time = [NSDate dateWithTimeIntervalSince1970:timestamp/1000];
//                      newInfo.pending_ward = [[pointInfo objectAtIndex:wardIndex] integerValue];
//                      newInfo.ward_diff = [[point objectAtIndex:diffIndex] integerValue];
                      [er.wardingInfos addObject:newInfo];
                  }
              }
              
              
              if (success) {
                  success(operation, [tmpDict allValues]);
              }
              
          }
          failure:^(AFHTTPRequestOperation *operation, NSError *error) {
              NSLog(@"Error: %@", error);
              if (failure){
                  failure (operation, error);
              }
          }];
}


- (void) queryAllPendingInPast24hr:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                           failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure
{
    [self queryDB:@"select last(pending_doctor) as doc, last(pending_bed) as bed, last(pending_ward) as ward, last(pending_icu) as icu, difference(pending_bed) as bed_diff, difference(pending_icu) as icu_diff from ER group by hospital_sn, time(1h) where time > now() - 24h"
          success:^(AFHTTPRequestOperation *operation, id responseObject) {
              NSLog(@"JSON: %@", responseObject);
              NSArray *columns = [[responseObject valueForKey:@"columns"] objectAtIndex:0];
              NSUInteger timeIndex = [columns indexOfObject:@"time"];
              NSUInteger docIndex = [columns indexOfObject:@"doc"];
              NSUInteger bedIndex = [columns indexOfObject:@"bed"];
              NSUInteger wardIndex = [columns indexOfObject:@"ward"];
              NSUInteger bedDiffIndex = [columns indexOfObject:@"bed_diff"];
              NSUInteger icuIndex = [columns indexOfObject:@"icu"];
              NSUInteger icuDiffIndex = [columns indexOfObject:@"icu_diff"];
              NSUInteger hospital_snIndex = [columns indexOfObject:@"hospital_sn"];
              NSMutableDictionary *tmpDict = [[NSMutableDictionary alloc] init];
              
              NSArray *points = [[responseObject valueForKey:@"points"] objectAtIndex:0];;
              for (int x = 0; x< [points count]; x++){
                  NSArray *pointInfo = (NSArray *)[points objectAtIndex:x];
                  NSString *name = [pointInfo objectAtIndex:hospital_snIndex];
                  
                  ER *er = NULL;
                  if ([tmpDict objectForKey:name] == NULL){
                      ER *newER = [[ER alloc] init];
                      newER.hospital_sn = name;
                      newER.wardingInfos = [[NSMutableArray alloc] init];
                      [tmpDict setObject:newER forKey:name];
                  }
                  else {
                      er = [tmpDict objectForKey:name];
                  }

                  
                  NSTimeInterval timestamp = [[pointInfo objectAtIndex:timeIndex] doubleValue];
                  WardInfo *newInfo = [[WardInfo alloc] init];
                  newInfo.time = [NSDate dateWithTimeIntervalSince1970:timestamp/1000];
                  newInfo.pending_doctor = [[pointInfo objectAtIndex:docIndex] integerValue];
                  newInfo.pending_bed = [[pointInfo objectAtIndex:bedIndex] integerValue];
                  newInfo.pending_ward = [[pointInfo objectAtIndex:wardIndex] integerValue];
                  newInfo.bed_diff = [[pointInfo objectAtIndex:bedDiffIndex] integerValue];
                  newInfo.pending_icu = [[pointInfo objectAtIndex:icuIndex] integerValue];
                  newInfo.icu_diff = [[pointInfo objectAtIndex:icuDiffIndex] integerValue];
//                  newInfo.ward_diff = [[pointInfo objectAtIndex:ward_diffIndex] integerValue];
                  [er.wardingInfos addObject:newInfo];
              }
              if (success) {
                  success(operation, [tmpDict allValues]);
              }
              
              
          }
          failure:^(AFHTTPRequestOperation *operation, NSError *error) {
              NSLog(@"Error: %@", error);
              if (failure){
                  failure (operation, error);
              }
          }];
}


@end
