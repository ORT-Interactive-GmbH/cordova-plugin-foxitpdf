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

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, FSPanelTag) {
    FSPanelTagAnnotation = 1,
    FSPanelTagAttachment,
    FSPanelTagOutline,
    FSPanelTagReadingBookmark
};

@class PanelButton;
@protocol IPanelSpec <NSObject>

- (int)getTag;

- (PanelButton *)getButton;
- (UIView *)getTopToolbar;
- (UIView *)getContentView;

- (void)onActivated;
- (void)onDeactivated;
@end
