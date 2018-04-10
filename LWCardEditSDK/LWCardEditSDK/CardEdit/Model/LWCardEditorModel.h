//
//  LWCardEditorModel.h
//  CardEditor
//
//  Created by linwei on 2017/11/1.
//  Copyright © 2017年 linwei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LWCardEditorModel : NSObject
@property(nonatomic,copy)NSString *title;
@property(nonatomic,copy)NSString *itemId;
@property(nonatomic,copy)NSString *imageUrl;
@property(nonatomic,strong)UIImage *placeholderImage;
@property(nonatomic,strong)UIImage *addImage;
@property(nonatomic,strong)UIImage *existImage;
@property(nonatomic,strong)UIImage *reduceImage;
@end
