//
//  NSBundle+LWPath.h
//  LWCardEditSDK
//
//  Created by lwmini on 2018/4/4.
//  Copyright © 2018年 lw. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSBundle (LWPath)

+(NSString *)myPathForResource:(NSString *)name ofType:(NSString *)ext;

@end
