//
//  NSBundle+LWPath.m
//  LWCardEditSDK
//
//  Created by lwmini on 2018/4/4.
//  Copyright © 2018年 lw. All rights reserved.
//

#import "NSBundle+LWPath.h"

@implementation NSBundle (LWPath)
+ (NSString *)myPathForResource:(NSString *)name ofType:(NSString *)ext{
    NSString *path;
    path = [[NSBundle mainBundle]pathForResource:name ofType:ext inDirectory:@"LWCardEdit.bundle"];
    if (path.length == 0) {
        path = [[NSBundle mainBundle]pathForResource:name ofType:ext inDirectory:@"Frameworks/LWCardEditSDK.framework/LWCardEdit.bundle"];
        if (path.length == 0) {
            path = ext.length == 0?name:[NSString stringWithFormat:@"%@.%@",name,ext];
        }
    }
    return path;
}
@end
