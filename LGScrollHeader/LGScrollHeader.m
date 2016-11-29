//
//  LGScrollHeader.m
//  LGAppTool
//
//  Created by 东途 on 2016/11/26.
//  Copyright © 2016年 displayten. All rights reserved.
//

#import "LGScrollHeader.h"

#define ScreenWidth [UIScreen mainScreen].bounds.size.width
@interface LGScrollHeader() <UIScrollViewDelegate>
@property (copy, nonatomic) NSArray <NSString *>*names;
@property (weak, nonatomic) UIButton *oldBtn;
@end
@implementation LGScrollHeader {
    NSUInteger  _lbct;
}

+ (instancetype)lg_scrollHeaderWithNames:(NSArray <NSString *>*)names {
    return [[self alloc] initWithNames:names];
}
- (instancetype)initWithNames:(NSArray <NSString *>*)names {
    if (self = [super init]) {
        if (!names || names.count==0) return nil;
        if (!self.names) {
            self.names = [NSArray arrayWithArray:names];
        }
        _lbct = names.count;
    }
    return self;
}
- (void)layoutSubviews {
    [self create_UI];
}

- (void)create_UI {
    UIScrollView *sc = [[UIScrollView alloc] init];
    sc.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    [self addSubview:sc];
//    sc.delegate = self;
    sc.pagingEnabled = NO;
    sc.userInteractionEnabled = YES;
    sc.showsVerticalScrollIndicator = NO;
    sc.showsHorizontalScrollIndicator = NO;
    CGFloat font_size;
    if (self.fontSize) {
        font_size = self.fontSize;
    }
    else {
        font_size = [UIFont systemFontSize];
        self.fontSize = font_size;
    }
    if (!self.bgColor) {
        self.bgColor = [UIColor redColor];
    }
    if (!self.selBgImage) {
        self.selBgImage = [UIImage imageNamed:@"2"];
    }
    if (!self.leftMargin) {
        self.leftMargin = 10;
    }
    if (!self.rightMargin) {
        self.rightMargin = 10;
    }
    
    NSMutableArray *btns = [NSMutableArray array];
    for (int i=0; i<_lbct; i++) {
        NSString *name = self.names[i];
        UIButton *btn = [self createBtnWithTitle:name fontSize:font_size i:i befores:btns];
        [sc addSubview:btn];
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [btns addObject:btn];
    }
    UIButton *last = btns.lastObject;
    sc.contentSize = CGSizeMake(CGRectGetMaxX(last.frame), 0);
}
- (void)btnClick:(UIButton *)btn {
    
    self.oldBtn.selected = NO;
    btn.selected = YES;
    if (self.btnClick) {
        self.btnClick(btn.tag);
    }
    self.oldBtn = btn;
}

- (UIButton *)createBtnWithTitle:(NSString *)name fontSize:(CGFloat)font_size i:(int)i  befores:(NSArray *)btns {
    
    CGFloat width = [self get_WidthWithContent:name height:self.frame.size.height font:font_size];
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.tag = i;
    btn.titleLabel.font = [UIFont systemFontOfSize:font_size];
    if (i == 0) {
        btn.selected = YES;
        self.oldBtn = btn;
    }
    [btn setTitle:name forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn setTitleColor:self.bgColor forState:UIControlStateSelected];
    if (self.bgImage) {
        [btn setBackgroundImage:self.bgImage forState:UIControlStateNormal];
    }
    if (self.selBgImage) {
        [btn setBackgroundImage:self.selBgImage forState:UIControlStateSelected];
    }
    
    UILabel *before;
    CGFloat x;
    if (i>0) {
        before = btns[i-1];
        x = CGRectGetMaxX(before.frame)+self.leftMargin+self.rightMargin;
    }
    else {
        x = self.leftMargin;
    }
    btn.frame = CGRectMake(x, 0, width, self.frame.size.height);
    return btn;
}
- (CGFloat)get_WidthWithContent:(NSString *)content height:(CGFloat)height font:(CGFloat)font {
    CGRect rect;
    rect = [content boundingRectWithSize:CGSizeMake(999, height) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:font]} context:nil];
    return rect.size.width+1;
}
@end
