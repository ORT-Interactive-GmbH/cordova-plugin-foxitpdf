/**
 * Copyright (C) 2003-2017, Foxit Software Inc..
 * All Rights Reserved.
 *
 * http://www.foxitsoftware.com
 *
 * The following code is copyrighted and is the proprietary of Foxit Software Inc.. It is not allowed to
 * distribute any parts of Foxit Mobile PDF SDK to third party or public without permission unless an agreement
 * is signed between Foxit Software Inc. and customers to explicitly grant customers permissions.
 * Review legal.txt for additional license and legal information.
 */

#import "MoreAnnotationsBar.h"
#import "../Thirdparties/ColorUtility/ColorUtility.h"
#import "../Thirdparties/Masonry/Masonry.h"
#import "NSSet+containsAnyObjectInArray.h"
#import "UIExtensionsManager+Private.h"
#import <FoxitRDK/FSPDFViewControl.h>

@interface MoreAnnotationsBar ()

//TextMarkup
@property (nonatomic, strong) UILabel *textLabel;

@property (nonatomic, strong) NSMutableArray *textButtons;
@property (nonatomic, strong) UIButton *highlightBtn;
@property (nonatomic, strong) UIButton *underlineBtn;
@property (nonatomic, strong) UIButton *breaklineBtn;
@property (nonatomic, strong) UIButton *strikeOutBtn;
@property (nonatomic, strong) UIButton *insertBtn;
@property (nonatomic, strong) UIButton *replaceBtn;

@property (nonatomic, strong) UIView *divideView1;

//Draw
@property (nonatomic, strong) UILabel *drawLabel;

@property (nonatomic, strong) NSMutableArray *drawButtons;
@property (nonatomic, strong) UIButton *lineBtn;
@property (nonatomic, strong) UIButton *rectBtn;
@property (nonatomic, strong) UIButton *circleBtn;
@property (nonatomic, strong) UIButton *arrowsBtn;
@property (nonatomic, strong) UIButton *pencileBtn;
@property (nonatomic, strong) UIButton *eraserBtn;

@property (nonatomic, strong) UIView *divideView2;

//Others
@property (nonatomic, strong) UILabel *othersLabel;

@property (nonatomic, strong) NSMutableArray *otherButtons;
@property (nonatomic, strong) UIButton *typewriterBtn;
@property (nonatomic, strong) UIButton *noteBtn;
@property (nonatomic, strong) UIButton *attachmentBtn;
@property (nonatomic, strong) UIButton *stampBtn;

@end

@implementation MoreAnnotationsBar

- (MoreAnnotationsBar *)initWithWidth:(CGFloat)width config:(UIExtensionsModulesConfig *)config {
    self = [super init];
    if (self) {
        self.contentView = [[UIView alloc] init];
        self.contentView.backgroundColor = [UIColor whiteColor];

        //TextMarkup
        UIImage *hightImage = [UIImage imageNamed:@"annot_hight"];
        UIImage *underlineImage = [UIImage imageNamed:@"annot_underline"];
        UIImage *breaklineImage = [UIImage imageNamed:@"annot_breakline"];
        UIImage *strokeoutImage = [UIImage imageNamed:@"annot_strokeout"];
        UIImage *replaceImage = [UIImage imageNamed:@"annot_replace"];
        UIImage *insertImage = [UIImage imageNamed:@"annot_insert"];
        self.highlightBtn = [MoreAnnotationsBar createItemWithImage:hightImage];
        self.underlineBtn = [MoreAnnotationsBar createItemWithImage:underlineImage];
        self.breaklineBtn = [MoreAnnotationsBar createItemWithImage:breaklineImage];
        self.strikeOutBtn = [MoreAnnotationsBar createItemWithImage:strokeoutImage];
        self.replaceBtn = [MoreAnnotationsBar createItemWithImage:replaceImage];
        self.insertBtn = [MoreAnnotationsBar createItemWithImage:insertImage];

        NSSet<NSString *> *tools = config.tools;
        _textButtons = @[].mutableCopy;
        if ([tools containsObject:Tool_Highlight]) {
            [_textButtons addObject:self.highlightBtn];
        }
        if ([tools containsObject:Tool_StrikeOut]) {
            [_textButtons addObject:self.strikeOutBtn];
        }
        if ([tools containsObject:Tool_Squiggly]) {
            [_textButtons addObject:self.breaklineBtn];
        }
        if ([tools containsObject:Tool_Underline]) {
            [_textButtons addObject:self.underlineBtn];
        }
        if ([tools containsObject:Tool_Insert]) {
            [_textButtons addObject:self.insertBtn];
        }
        if ([tools containsObject:Tool_Replace]) {
            [_textButtons addObject:self.replaceBtn];
        }
        
        if (_textButtons.count > 0) {
            self.textLabel = [[UILabel alloc] init];
            self.textLabel.text = FSLocalizedString(@"kMoreTextMarkup");
            self.textLabel.font = [UIFont systemFontOfSize:16.0f];
            self.textLabel.textColor = [UIColor darkGrayColor];
            [self.contentView addSubview:self.textLabel];
        }

        //Drawing
        UIImage *lineImage = [UIImage imageNamed:@"annot_line"];
        UIImage *rectImage = [UIImage imageNamed:@"annot_rect"];
        UIImage *circleImage = [UIImage imageNamed:@"annot_circle"];
        UIImage *arrowsImage = [UIImage imageNamed:@"annot_arrows"];
        UIImage *pencileImage = [UIImage imageNamed:@"annot_pencile"];
        UIImage *eraserImage = [UIImage imageNamed:@"annot_eraser"];
        self.lineBtn = [MoreAnnotationsBar createItemWithImage:lineImage];
        self.rectBtn = [MoreAnnotationsBar createItemWithImage:rectImage];
        self.circleBtn = [MoreAnnotationsBar createItemWithImage:circleImage];
        self.arrowsBtn = [MoreAnnotationsBar createItemWithImage:arrowsImage];
        self.pencileBtn = [MoreAnnotationsBar createItemWithImage:pencileImage];
        self.eraserBtn = [MoreAnnotationsBar createItemWithImage:eraserImage];

        _drawButtons = @[].mutableCopy;
        if ([tools containsObject:Tool_Line]) {
            [_drawButtons addObject:self.lineBtn];
        }
        if ([tools containsObject:Tool_Arrow]) {
            [_drawButtons addObject:self.arrowsBtn];
        }
        if ([tools containsObject:Tool_Rectangle]) {
            [_drawButtons addObject:self.rectBtn];
        }
        if ([tools containsObject:Tool_Oval]) {
            [_drawButtons addObject:self.circleBtn];
        }
        if ([tools containsObject:Tool_Pencil]) {
            [_drawButtons addObject:self.pencileBtn];
        }
        if ([tools containsObject:Tool_Eraser]) {
            [_drawButtons addObject:self.eraserBtn];
        }
        if (_drawButtons.count > 0) {
            if (_textButtons.count > 0) {
                self.divideView1 = [[UIView alloc] init];
                self.divideView1.backgroundColor = [UIColor colorWithRGBHex:0xe6e6e6];
                [self.contentView addSubview:self.divideView1];
            }
            self.drawLabel = [[UILabel alloc] init];
            self.drawLabel.text = FSLocalizedString(@"kMoreDrawing");
            self.drawLabel.font = [UIFont systemFontOfSize:16.0f];
            self.drawLabel.textColor = [UIColor darkGrayColor];
            [self.contentView addSubview:self.drawLabel];
        }
        
        //Others
        UIImage *typeriterImage = [UIImage imageNamed:@"annot_typewriter_more"];
        UIImage *noteImage = [UIImage imageNamed:@"annot_note_more"];
        UIImage *stampImage = [UIImage imageNamed:@"annot_stamp_more"];
        UIImage *attachmentImage = [UIImage imageNamed:@"annot_attachment_more"];

        self.typewriterBtn = [MoreAnnotationsBar createItemWithImageAndTitle:FSLocalizedString(@"kTypewriter") imageNormal:typeriterImage];
        self.noteBtn = [MoreAnnotationsBar createItemWithImageAndTitle:FSLocalizedString(@"kNote") imageNormal:noteImage];
        self.attachmentBtn = [MoreAnnotationsBar createItemWithImageAndTitle:FSLocalizedString(@"kAttachment") imageNormal:attachmentImage];
        self.stampBtn = [MoreAnnotationsBar createItemWithImageAndTitle:FSLocalizedString(@"kPropertyStamps") imageNormal:stampImage];

        _otherButtons = @[].mutableCopy;
        if ([tools containsObject:Tool_Freetext]) {
            [_otherButtons addObject:self.typewriterBtn];
        }
        if ([tools containsObject:Tool_Note]) {
            [_otherButtons addObject:self.noteBtn];
        }
        if ([tools containsObject:Tool_Stamp]) {
            [_otherButtons addObject:self.stampBtn];
        }
        if (config.loadAttachment) {
            [_otherButtons addObject:self.attachmentBtn];
        }
        if (_otherButtons.count > 0) {
            if (_textButtons.count > 0 || _drawButtons.count > 0) {
                self.divideView2 = [[UIView alloc] init];
                self.divideView2.backgroundColor = [UIColor colorWithRGBHex:0xe6e6e6];
                [self.contentView addSubview:self.divideView2];
            }
            self.othersLabel = [[UILabel alloc] init];
            self.othersLabel.text = FSLocalizedString(@"kMoreOthers");
            self.othersLabel.font = [UIFont systemFontOfSize:16.0f];
            self.othersLabel.textColor = [UIColor darkGrayColor];
            [self.contentView addSubview:self.othersLabel];
        }

        CGFloat height = (self.textButtons.count > 0 ? 75 : 0) + (self.drawButtons.count > 0 ? 75 : 0) + (self.otherButtons.count > 0 ? 100 : 0);
        self.contentView.frame = CGRectMake(0, 0, width, height);
        [self refreshLayoutWithWidth:width];
        [self initButtonActions];
    }
    return self;
}

- (void)refreshLayoutWithWidth:(CGFloat)width {
    CGFloat leftMargin = (width - 20) / 12 - [UIImage imageNamed:@"annot_hight"].size.width / 2;
    
    [self.textLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(leftMargin);
        make.top.equalTo(self.contentView.mas_top).offset(10);
        make.width.mas_equalTo(200);
        make.height.mas_equalTo(20);
    }];
    [_textButtons enumerateObjectsUsingBlock:^(id  _Nonnull button, NSUInteger idx, BOOL * _Nonnull stop) {
        [self.contentView addSubview:button];
        [button mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(leftMargin + (width - 20) / 6 * idx);
            make.top.equalTo(self.textLabel.mas_bottom).offset(10);
        }];
    }];
    
    [self.divideView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).offset(5);
        make.right.equalTo(self.contentView.mas_right).offset(-5);
        make.top.equalTo(self.contentView.mas_top).offset(75);
        make.height.mas_equalTo([Utility realPX:1.0f]);
    }];
    [self.drawLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(leftMargin);
        make.top.equalTo(self.contentView.mas_top).offset(_textButtons.count > 0 ? 80 : 10);
        make.width.mas_equalTo(200);
        make.height.mas_equalTo(20);
    }];
    [_drawButtons enumerateObjectsUsingBlock:^(id  _Nonnull button, NSUInteger idx, BOOL * _Nonnull stop) {
        [self.contentView addSubview:button];
        [button mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(leftMargin + (width - 20) / 6 * idx);
            make.top.equalTo(self.drawLabel.mas_bottom).offset(10);
        }];
    }];
    
    [self.divideView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).offset(5);
        make.right.equalTo(self.contentView.mas_right).offset(-5);
        make.top.equalTo(self.contentView.mas_top).offset((_textButtons.count > 0 && _drawButtons.count > 0) ? 150 : 75);
        make.height.mas_equalTo([Utility realPX:1.0f]);
    }];
    [self.othersLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(leftMargin);
        make.top.equalTo(self.contentView.mas_top).offset((_textButtons.count > 0 ? 80 : 10) + (_drawButtons.count > 0 ? 80 : 0));
        make.width.mas_equalTo(200);
        make.height.mas_equalTo(20);
    }];
    [_otherButtons enumerateObjectsUsingBlock:^(id  _Nonnull button, NSUInteger idx, BOOL * _Nonnull stop) {
        [self.contentView addSubview:button];
        [button mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(leftMargin + (width - 20) / 4 * idx);
            make.top.equalTo(self.othersLabel.mas_bottom).offset(10);
            make.width.mas_equalTo([button bounds].size.width);
            make.height.mas_equalTo([button bounds].size.height);
        }];
    }];
    
//    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
//        UIButton *lastButton = _otherButtons.lastObject ?: (_drawButtons.lastObject ?: _textButtons.lastObject);
//        if (lastButton) {
//            make.bottom.equalTo(lastButton.mas_bottom).offset(10);
//        }
//    }];
}
//{
//    [self.textLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(self.rectBtn.mas_left).offset(0);
//        make.top.equalTo(self.contentView.mas_top).offset(10);
//        make.width.mas_equalTo(200);
//        make.height.mas_equalTo(20);
//    }];
//
//    [self.drawLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(self.rectBtn.mas_left).offset(0);
//        make.top.equalTo(self.contentView.mas_top).offset(80);
//        make.width.mas_equalTo(200);
//        make.height.mas_equalTo(20);
//    }];
//
//    [self.othersLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(self.rectBtn.mas_left).offset(0);
//        make.top.equalTo(self.contentView.mas_top).offset(160);
//        make.width.mas_equalTo(200);
//        make.height.mas_equalTo(20);
//    }];
//
//    [self.highlightBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(self.rectBtn.mas_left).offset(0);
//        make.top.equalTo(self.textLabel.mas_bottom).offset(10);
//        make.width.mas_equalTo(self.highlightBtn.bounds.size.width);
//        make.height.mas_equalTo(self.highlightBtn.bounds.size.height);
//    }];
//    [self.underlineBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(self.circleBtn.mas_left).offset(0);
//        make.top.equalTo(self.textLabel.mas_bottom).offset(10);
//        make.width.mas_equalTo(self.underlineBtn.bounds.size.width);
//        make.height.mas_equalTo(self.underlineBtn.bounds.size.height);
//    }];
//    [self.breaklineBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(self.lineBtn.mas_left).offset(0);
//        make.top.equalTo(self.textLabel.mas_bottom).offset(10);
//        make.width.mas_equalTo(self.breaklineBtn.bounds.size.width);
//        make.height.mas_equalTo(self.breaklineBtn.bounds.size.height);
//    }];
//    [self.strokeoutBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(self.arrowsBtn.mas_left).offset(0);
//        make.top.equalTo(self.textLabel.mas_bottom).offset(10);
//        make.width.mas_equalTo(self.strokeoutBtn.bounds.size.width);
//        make.height.mas_equalTo(self.strokeoutBtn.bounds.size.height);
//    }];
//    [self.replaceBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(self.pencileBtn.mas_left).offset(0);
//        make.top.equalTo(self.textLabel.mas_bottom).offset(10);
//        make.width.mas_equalTo(self.replaceBtn.bounds.size.width);
//        make.height.mas_equalTo(self.replaceBtn.bounds.size.height);
//    }];
//    [self.insertBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(self.eraserBtn.mas_left).offset(0);
//        make.top.equalTo(self.textLabel.mas_bottom).offset(10);
//        make.width.mas_equalTo(self.insertBtn.bounds.size.width);
//        make.height.mas_equalTo(self.insertBtn.bounds.size.height);
//    }];
//
//    [self.divideView1 mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(self.contentView.mas_left).offset(5);
//        make.right.equalTo(self.contentView.mas_right).offset(-5);
//        make.top.equalTo(self.contentView.mas_top).offset(75);
//        make.height.mas_equalTo([Utility realPX:1.0f]);
//    }];
//
//    [self.divideView2 mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(self.contentView.mas_left).offset(5);
//        make.right.equalTo(self.contentView.mas_right).offset(-5);
//        make.top.equalTo(self.contentView.mas_top).offset(150);
//        make.height.mas_equalTo([Utility realPX:1.0f]);
//    }];
//}

- (void)initButtonActions {
    [self.highlightBtn addTarget:self action:@selector(onHighLightClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.underlineBtn addTarget:self action:@selector(onUnderLineClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.breaklineBtn addTarget:self action:@selector(onBreakLineClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.strikeOutBtn addTarget:self action:@selector(onStrikeOutClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.replaceBtn addTarget:self action:@selector(onReplaceClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.insertBtn addTarget:self action:@selector(onInsertClicked) forControlEvents:UIControlEventTouchUpInside];

    [self.lineBtn addTarget:self action:@selector(onLineClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.rectBtn addTarget:self action:@selector(onRectClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.circleBtn addTarget:self action:@selector(onCircleClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.arrowsBtn addTarget:self action:@selector(onArrowsClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.pencileBtn addTarget:self action:@selector(onPencilClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.eraserBtn addTarget:self action:@selector(onEraserClicked) forControlEvents:UIControlEventTouchUpInside];

    [self.typewriterBtn addTarget:self action:@selector(onTyperwriterClicked) forControlEvents:UIControlEventTouchUpInside];

    [self.noteBtn addTarget:self action:@selector(onNoteClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.attachmentBtn addTarget:self action:@selector(onAttachClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.stampBtn addTarget:self action:@selector(onStampClicked) forControlEvents:UIControlEventTouchUpInside];
}

- (void)onHighLightClicked {
    if (self.highLightClicked) {
        self.highLightClicked();
    }
}

- (void)onUnderLineClicked {
    if (self.underLineClicked) {
        self.underLineClicked();
    }
}

- (void)onStrikeOutClicked {
    if (self.strikeOutClicked) {
        self.strikeOutClicked();
    }
}

- (void)onBreakLineClicked {
    if (self.breakLineClicked) {
        self.breakLineClicked();
    }
}

- (void)onLineClicked {
    if (self.lineClicked) {
        self.lineClicked();
    }
}

- (void)onRectClicked {
    if (self.rectClicked) {
        self.rectClicked();
    }
}

- (void)onCircleClicked {
    if (self.circleClicked) {
        self.circleClicked();
    }
}

- (void)onArrowsClicked {
    if (self.arrowsClicked) {
        self.arrowsClicked();
    }
}

- (void)onPencilClicked {
    if (self.pencileClicked) {
        self.pencileClicked();
    }
}

- (void)onEraserClicked {
    if (self.eraserClicked) {
        self.eraserClicked();
    }
}

- (void)onTyperwriterClicked {
    if (self.typerwriterClicked) {
        self.typerwriterClicked();
    }
}

- (void)onNoteClicked {
    if (self.noteClicked) {
        self.noteClicked();
    }
}

- (void)onAttachClicked {
    if (self.attachmentClicked) {
        self.attachmentClicked();
    }
}

- (void)onStampClicked {
    if (self.stampClicked) {
        self.stampClicked();
    }
}

- (void)onInsertClicked {
    if (self.insertClicked)
        self.insertClicked();
}

- (void)onReplaceClicked {
    if (self.replaceClicked)
        self.replaceClicked();
}

//create button with image.
+ (UIButton *)createItemWithImage:(UIImage *)imageNormal {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.contentMode = UIViewContentModeScaleToFill;
    [button setImage:imageNormal forState:UIControlStateNormal];
    [button setImage:[MoreAnnotationsBar imageByApplyingAlpha:imageNormal alpha:0.5] forState:UIControlStateHighlighted];
    [button setImage:[MoreAnnotationsBar imageByApplyingAlpha:imageNormal alpha:0.5] forState:UIControlStateSelected];
    return button;
}

+ (UIButton *)createItemWithImageAndTitle:(NSString *)title
                              imageNormal:(UIImage *)imageNormal {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    CGSize titleSize = [Utility getTextSize:title fontSize:12.0f maxSize:CGSizeMake(300, 200)];

    float width = imageNormal.size.width;
    float height = imageNormal.size.height;
    button.contentMode = UIViewContentModeScaleToFill;
    [button setImage:imageNormal forState:UIControlStateNormal];
    [button setImage:[MoreAnnotationsBar imageByApplyingAlpha:imageNormal alpha:0.5] forState:UIControlStateHighlighted];
    [button setImage:[MoreAnnotationsBar imageByApplyingAlpha:imageNormal alpha:0.5] forState:UIControlStateSelected];

    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    [button setTitleColor:[UIColor grayColor] forState:UIControlStateSelected];
    button.titleLabel.font = [UIFont systemFontOfSize:12.0f];

    button.titleEdgeInsets = UIEdgeInsetsMake(0, -width, -height, 0);
    button.imageEdgeInsets = UIEdgeInsetsMake(-titleSize.height, 0, 0, -titleSize.width);
    button.frame = CGRectMake(0, 0, titleSize.width > width ? titleSize.width + 2 : width, titleSize.height + height);

    return button;
}

+ (UIImage *)imageByApplyingAlpha:(UIImage *)image alpha:(CGFloat)alpha {
    UIGraphicsBeginImageContextWithOptions(image.size, NO, 0.0f);

    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGRect area = CGRectMake(0, 0, image.size.width, image.size.height);

    CGContextScaleCTM(ctx, 1, -1);
    CGContextTranslateCTM(ctx, 0, -area.size.height);

    CGContextSetBlendMode(ctx, kCGBlendModeMultiply);

    CGContextSetAlpha(ctx, alpha);

    CGContextDrawImage(ctx, area, image.CGImage);

    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();

    UIGraphicsEndImageContext();

    return newImage;
}

@end
