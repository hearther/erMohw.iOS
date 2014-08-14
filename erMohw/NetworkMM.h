//
//  NetworkMM.h
//  erMohw
//
//  Created by Bunny Lin on 2014/8/11.
//  Copyright (c) 2014年 Bunny Lin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"
#import "ER.h"

@interface NetworkMM : NSObject
+ (NetworkMM *)sharedNetworkMM;
- (void) queryDB:(NSString *)queryStr
         success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
         failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;

- (void) queryAllPendingInPast24hr:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                           failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;

- (void) query:(void (^)(AFHTTPRequestOperation *, id))success
                                     failure:(void (^)(AFHTTPRequestOperation *, NSError *))failure;

@end
