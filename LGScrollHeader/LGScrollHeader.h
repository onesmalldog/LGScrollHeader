//
//  LGScrollHeader.h
//  LGAppTool
//
//  Created by 东途 on 2016/11/26.
//  Copyright © 2016年 displayten. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LGScrollHeader : UIView
+ (instancetype)lg_scrollHeaderWithNames:(NSArray <NSString *>*)names;
@property (assign, nonatomic) CGFloat fontSize;
@property (copy, nonatomic) void(^btnClick)(NSInteger tag);
@property (strong, nonatomic) UIImage *bgImage;
@property (strong, nonatomic) UIImage *selBgImage;
@property (strong, nonatomic) UIColor *bgColor;
@property (assign, nonatomic) CGFloat leftMargin;
@property (assign, nonatomic) CGFloat rightMargin;
@end
