//
//  LWCardManagerLayout.h
//  CardEditor
//
//  Created by linwei on 2017/11/1.
//  Copyright © 2017年 linwei. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LWCardManagerDelegate <NSObject>

/**
 * 更新数据源
 */
- (void)moveItemAtIndexPath:(NSIndexPath *)formPath toIndexPath:(NSIndexPath *)toPath;

/**
 * 改变编辑状态
 */
- (void)didChangeEditState:(BOOL)inEditState;

@end

@interface LWCardManagerLayout : UICollectionViewFlowLayout

@property (nonatomic, assign) BOOL inEditState; //检测是否处于编辑状态
@property (nonatomic, weak) id<LWCardManagerDelegate> delegate;

@end
