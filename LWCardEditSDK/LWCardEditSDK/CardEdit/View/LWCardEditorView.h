//
//  LWCardEditorView.h
//  CardEditor
//
//  Created by linwei on 2017/11/1.
//  Copyright © 2017年 linwei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LWCardEditorModel.h"

#define LEFTTITLE @"LEFTTITLE"
#define RIGHTTITLE @"RIGHTTITLE"
#define DATA @"DATA"
@class LWCardManagerLayout;

@protocol LWCardEditorViewDelegate <NSObject>
@optional

//item点击回调
- (void)didSelectItemModel:(LWCardEditorModel *)model;

@end
@interface LWCardEditorView : UIView
/**
  可自定义CollectionLayout
 */
@property(nonatomic,strong) LWCardManagerLayout *mainCollectionLayout;
/**
 cell间隙 默认为20
 */
@property(nonatomic,assign) CGFloat cellSpacing;

@property(nonatomic,weak) id <LWCardEditorViewDelegate> delegate;

/**
 编辑的按钮
 */
@property (nonatomic,strong)UIButton *editBtn;

/**
 编辑的按钮点击事件

 @param button 编辑的按钮
 @param finishBlock 点击完成后返回我的应用里面的数据
 */
- (void)editBtnClickAction:(UIButton *)button finish:(void (^)(id returnValue))finishBlock;

/**
  初始化数据

 @param allDataArray 下面所有类别的数据 数据格式如下：
 [
     {
     "DATA ": [
         "<LWCardEditorModel: 0x60c00002f560>",
         "<LWCardEditorModel: 0x60c00002f8a0>",
         "<LWCardEditorModel: 0x60c000032e00>",
         "<LWCardEditorModel: 0x60c0000312c0>",
         "<LWCardEditorModel: 0x60c0000312a0>",
         "<LWCardEditorModel: 0x60c00002f260>",
         "<LWCardEditorModel: 0x60c000031340>",
         "<LWCardEditorModel: 0x60c0000313c0>",
         "<LWCardEditorModel: 0x60c000031540>",
         "<LWCardEditorModel: 0x60c000032da0>"
     ],
     "LEFTTITLE": "左边边标题",
     "RIGHTTITLE": "右边标题"
     },
     {
     "DATA ": [
         "<LWCardEditorModel: 0x60c00002f560>",
         "<LWCardEditorModel: 0x60c00002f8a0>",
         "<LWCardEditorModel: 0x60c000032e00>",
         "<LWCardEditorModel: 0x60c0000312c0>",
         "<LWCardEditorModel: 0x60c0000312a0>",
         "<LWCardEditorModel: 0x60c00002f260>",
         "<LWCardEditorModel: 0x60c000031340>",
         "<LWCardEditorModel: 0x60c0000313c0>",
         "<LWCardEditorModel: 0x60c000031540>",
         "<LWCardEditorModel: 0x60c000032da0>"
     ],
     "LEFTTITLE": "左边边标题",
     "RIGHTTITLE": "右边标题"
     }
 ]
 @param myDict 我的应用数据 数据格式如下：
 {
     "DATA ": [
     "<LWCardEditorModel: 0x60c000031340>",
     "<LWCardEditorModel: 0x60c0000313c0>",
     "<LWCardEditorModel: 0x60c000031540>",
     "<LWCardEditorModel: 0x60c000032da0>"
     ],
     "LEFTTITLE": "左边边标题",
     "RIGHTTITLE": "右边标题"
 }
 @param rowNum 每行显示个数
 */
- (void)reloadData:(NSArray *)allDataArray andMyDict:(NSDictionary *)myDict  andRowNum:(NSInteger)rowNum;
@end
