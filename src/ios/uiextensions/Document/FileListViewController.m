/**
 * Copyright (C) 2003-2018, Foxit Software Inc..
 * All Rights Reserved.
 *
 * http://www.foxitsoftware.com
 *
 * The following code is copyrighted and is the proprietary of Foxit Software Inc.. It is not allowed to
 * distribute any parts of Foxit Mobile PDF SDK to third party or public without permission unless an agreement
 * is signed between Foxit Software Inc. and customers to explicitly grant customers permissions.
 * Review legal.txt for additional license and legal information.
 */

#import "FileListViewController.h"
#import "../BaseBar/TbBaseBar.h"

@interface FSFileListViewController () <FileDelegate> {
    UIView *sortContainerView;
    TbBaseBar *topToolbar;
    UIView *contentView;
    FileBrowser *browser;
    DXPopover *popover;
    TbBaseBar *fileBrowser;
    UILabel *previousPath;
    UILabel *currentPath;
    NSMutableArray *pathItems;
    UIImageView *nextImage;
    UIImageView *dateimage;
    UIImageView *nameimage;
    UIImageView *sizeimage;
    TbBaseItem *thumbnailItem;
    FileItem *currentFileItem;

    BOOL isShowMorePopover;
    BOOL isShowSortPopover;

    FileSortType sortType;
    FileSortMode sortMode;
    int viewMode;
}

@property (nonatomic, strong) FileItem *previousItem;
@property (nonatomic, strong) TbBaseItem *ipadsortNameItem;
@property (nonatomic, strong) TbBaseItem *ipadsortTimeItem;
@property (nonatomic, strong) TbBaseItem *ipadsortTypeItem;
@property (nonatomic, strong) TbBaseItem *sortNameItem;
@property (nonatomic, strong) UIView *rootView;
@end

@implementation FSFileListViewController

- (instancetype)init {
    self = [super init];
    if (self) {
        sortType = FileSortType_Name;
        sortMode = FileSortMode_Ascending;
        viewMode = 0;

        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(orientationChanged:) name:UIApplicationWillChangeStatusBarOrientationNotification object:nil];

        pathItems = [[NSMutableArray alloc] init];
        topToolbar = [[TbBaseBar alloc] init];
        topToolbar.contentView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 64);
        topToolbar.contentView.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleRightMargin;
        topToolbar.backgroundColor = [UIColor colorWithRed:0.15 green:0.62 blue:0.84 alpha:1];
        topToolbar.direction = Orientation_HORIZONTAL;
        topToolbar.interval = NO;
        topToolbar.hasDivide = NO;
        contentView = [[UIView alloc] initWithFrame:CGRectMake(0, 64, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - 64)];
        contentView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleBottomMargin;
        contentView.backgroundColor = [UIColor whiteColor];
        browser = [[FileBrowser alloc] init];
        browser.sortType = sortType;
        browser.sortMode = sortMode;
        [browser initializeViewWithDelegate:self];
        [browser getContentView].frame = CGRectMake(0, 45, contentView.frame.size.width, contentView.frame.size.height - 45);
        [contentView addSubview:[browser getContentView]];

        fileBrowser = [[TbBaseBar alloc] init];
        fileBrowser.contentView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 45);
        fileBrowser.contentView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        fileBrowser.backgroundColor = [UIColor whiteColor];
        fileBrowser.direction = Orientation_HORIZONTAL;
        fileBrowser.interval = NO;
        fileBrowser.hasDivide = NO;
        [contentView addSubview:fileBrowser.contentView];
        fileBrowser.top = NO;
        TbBaseItem *documentTitle = [TbBaseItem createItemWithTitle:FSLocalizedString(@"kDocuments")];
        documentTitle.textColor = [UIColor whiteColor];
        documentTitle.textFont = [UIFont systemFontOfSize:(DEVICE_iPHONE) ? 18.f : 20.f];
        documentTitle.button.enabled = NO;
        [topToolbar addItem:documentTitle displayPosition:Position_CENTER];
        __block FSFileListViewController *docModule = self;
        if (DEVICE_iPHONE) {
            UINavigationController *nai = [browser getNaviController];
            FileManageListViewController *fileList = [nai.viewControllers objectAtIndex:0];

            [fileList setViewMode:viewMode];
            thumbnailItem = [TbBaseItem createItemWithImage:[UIImage imageNamed:@"document_thumb_state_iphone"] imageSelected:nil imageDisable:nil];
            if (viewMode == 1) {
                [thumbnailItem.button setImage:[UIImage imageNamed:@"document_thumb_state_iphone"] forState:UIControlStateNormal];
            } else if (viewMode == 0) {
                [thumbnailItem.button setImage:[UIImage imageNamed:@"document_list_state_iphone"] forState:UIControlStateNormal];
            }
            thumbnailItem.tag = 5;
            TbBaseItem *__weak weakThumbnailItem = thumbnailItem;
            thumbnailItem.onTapClick = ^(TbBaseItem *item) {
                [docModule->browser switchStyle];

                viewMode = viewMode == 1 ? 0 : 1;

                if (viewMode == 1) {
                    [weakThumbnailItem.button setImage:[UIImage imageNamed:@"document_thumb_state_iphone"] forState:UIControlStateNormal];
                } else if (viewMode == 0) {
                    [weakThumbnailItem.button setImage:[UIImage imageNamed:@"document_list_state_iphone"] forState:UIControlStateNormal];
                }
            };
            [fileBrowser addItem:thumbnailItem displayPosition:Position_LT];

            TbBaseItem *sortNameItem = nil;
            if (sortType == FileSortType_Name) {
                if (sortMode == FileSortMode_Ascending) {
                    UIImage *imageNormal = [UIImage imageNamed:@"document_sortupselect_black.png"];
                    UIImage *imageSelected = [UIImage imageNamed:@"document_sortupselect_black.png"];
                    sortNameItem = [TbBaseItem createItemWithImageAndTitle:FSLocalizedString(@"kName") imageNormal:imageNormal imageSelected:imageSelected imageDisable:nil background:nil imageTextRelation:RELATION_LEFT];
                } else {
                    UIImage *imageNormal = [UIImage imageNamed:@"document_sortselect_black.png"];
                    UIImage *imageSelected = [UIImage imageNamed:@"document_sortselect_black.png"];
                    sortNameItem = [TbBaseItem createItemWithImageAndTitle:FSLocalizedString(@"kName") imageNormal:imageNormal imageSelected:imageSelected imageDisable:nil background:nil imageTextRelation:RELATION_LEFT];
                }
            } else if (sortType == FileSortType_Date) {
                if (sortMode == FileSortMode_Ascending) {
                    UIImage *imageNormal = [UIImage imageNamed:@"document_sortupselect_black.png"];
                    UIImage *imageSelected = [UIImage imageNamed:@"document_sortupselect_black.png"];
                    sortNameItem = [TbBaseItem createItemWithImageAndTitle:FSLocalizedString(@"kTimeSort") imageNormal:imageNormal imageSelected:imageSelected imageDisable:nil background:nil imageTextRelation:RELATION_LEFT];
                } else {
                    UIImage *imageNormal = [UIImage imageNamed:@"document_sortselect_black.png"];
                    UIImage *imageSelected = [UIImage imageNamed:@"document_sortselect_black.png"];
                    sortNameItem = [TbBaseItem createItemWithImageAndTitle:FSLocalizedString(@"kTimeSort") imageNormal:imageNormal imageSelected:imageSelected imageDisable:nil background:nil imageTextRelation:RELATION_LEFT];
                }
            } else if (sortType == FileSortType_Size) {
                if (sortMode == FileSortMode_Ascending) {
                    UIImage *imageNormal = [UIImage imageNamed:@"document_sortupselect_black.png"];
                    UIImage *imageSelected = [UIImage imageNamed:@"document_sortupselect_black.png"];
                    sortNameItem = [TbBaseItem createItemWithImageAndTitle:FSLocalizedString(@"kSize") imageNormal:imageNormal imageSelected:imageSelected imageDisable:nil background:nil imageTextRelation:RELATION_LEFT];
                } else {
                    UIImage *imageNormal = [UIImage imageNamed:@"document_sortselect_black.png"];
                    UIImage *imageSelected = [UIImage imageNamed:@"document_sortselect_black.png"];
                    sortNameItem = [TbBaseItem createItemWithImageAndTitle:FSLocalizedString(@"kSize") imageNormal:imageNormal imageSelected:imageSelected imageDisable:nil background:nil imageTextRelation:RELATION_LEFT];
                }
            }
            self.sortNameItem = sortNameItem;
            isShowSortPopover = NO;
            self.sortNameItem.textColor = [UIColor blackColor];
            self.sortNameItem.tag = 6;
            typeof(self) __weak weakSelf = self;
            self.sortNameItem.onTapClick = ^(TbBaseItem *item) {
                [weakSelf setSortButtonPopover];
            };
            [fileBrowser addItem:self.sortNameItem displayPosition:Position_CENTER];

            UIView *linetwo = [[UIView alloc] initWithFrame:CGRectMake(0, fileBrowser.contentView.bounds.size.height - 1, fileBrowser.contentView.bounds.size.width, [Utility realPX:1.0f])];
            linetwo.backgroundColor = [UIColor colorWithRGBHex:0xe6e6e6];
            linetwo.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
            [fileBrowser.contentView addSubview:linetwo];

        } else {
            UINavigationController *nai = [browser getNaviController];
            FileManageListViewController *fileList = [nai.viewControllers objectAtIndex:0];
            [fileList setViewMode:0];
            thumbnailItem = [TbBaseItem createItemWithImage:[UIImage imageNamed:@"document_thumb_state_ipad"] imageSelected:nil imageDisable:nil];
            if (viewMode == 1) {
                [thumbnailItem.button setImage:[UIImage imageNamed:@"document_thumb_state_ipad"] forState:UIControlStateNormal];
            } else if (viewMode == 0) {
                [thumbnailItem.button setImage:[UIImage imageNamed:@"document_list_state_ipad"] forState:UIControlStateNormal];
            }

            thumbnailItem.tag = 5;
            TbBaseItem *__weak weakThumbnailItem = thumbnailItem;
            thumbnailItem.onTapClick = ^(TbBaseItem *item) {
                [docModule->browser switchStyle];

                viewMode = viewMode == 1 ? 0 : 1;
                if (viewMode == 1) {
                    [weakThumbnailItem.button setImage:[UIImage imageNamed:@"document_thumb_state_ipad"] forState:UIControlStateNormal];
                } else if (viewMode == 0) {
                    [weakThumbnailItem.button setImage:[UIImage imageNamed:@"document_list_state_ipad"] forState:UIControlStateNormal];
                }
            };
            [topToolbar addItem:thumbnailItem displayPosition:Position_RB];

            self.ipadsortNameItem = [TbBaseItem createItemWithImageAndTitle:FSLocalizedString(@"kName") imageNormal:[UIImage imageNamed:@"document_sortblank"] imageSelected:[UIImage imageNamed:@"document_sortupselect"] imageDisable:[UIImage imageNamed:@"document_sortblank"] background:nil imageTextRelation:RELATION_LEFT];
            self.ipadsortNameItem.textColor = [UIColor blackColor];
            self.ipadsortNameItem.textFont = [UIFont systemFontOfSize:15.0f];
            self.ipadsortNameItem.tag = 2;
            self.ipadsortNameItem.selected = YES;
            self.ipadsortNameItem.textColor = [UIColor colorWithRGBHex:0x179cd8];
            //            [docModule->browser sortFileByType:FileSortType_Name fileSortMode:self.ipadsortNameItem.selected ? FileSortMode_Ascending : FileSortMode_Descending];

            self.ipadsortNameItem.onTapClick = ^(TbBaseItem *item) {
                [docModule.ipadsortNameItem.button setImage:[UIImage imageNamed:@"document_sortselect.png"] forState:UIControlStateNormal];
                docModule.ipadsortNameItem.selected = !docModule.ipadsortNameItem.selected;
                docModule.ipadsortNameItem.textColor = [UIColor colorWithRGBHex:0x179cd8];

                docModule.ipadsortTimeItem.selected = NO;
                [docModule.ipadsortTimeItem.button setImage:[UIImage imageNamed:@"document_sortblank"] forState:UIControlStateNormal];
                docModule.ipadsortTimeItem.textColor = [UIColor blackColor];

                docModule.ipadsortTypeItem.selected = NO;
                [docModule.ipadsortTypeItem.button setImage:[UIImage imageNamed:@"document_sortblank"] forState:UIControlStateNormal];
                docModule.ipadsortTypeItem.textColor = [UIColor blackColor];

                [docModule->browser sortFileByType:FileSortType_Name fileSortMode:docModule.ipadsortNameItem.selected ? FileSortMode_Ascending : FileSortMode_Descending];
            };

            self.ipadsortTimeItem = [TbBaseItem createItemWithImageAndTitle:FSLocalizedString(@"kTimeSort") imageNormal:[UIImage imageNamed:@"document_sortblank"] imageSelected:[UIImage imageNamed:@"document_sortupselect"] imageDisable:[UIImage imageNamed:@"document_sortblank"] background:nil imageTextRelation:RELATION_LEFT];
            self.ipadsortTimeItem.textColor = [UIColor blackColor];
            self.ipadsortTimeItem.textFont = [UIFont systemFontOfSize:15.0f];
            self.ipadsortTimeItem.tag = 3;
            self.ipadsortTimeItem.onTapClick = ^(TbBaseItem *item) {
                [docModule.ipadsortTimeItem.button setImage:[UIImage imageNamed:@"document_sortselect.png"] forState:UIControlStateNormal];
                docModule.ipadsortTimeItem.selected = !docModule.ipadsortTimeItem.selected;
                docModule.ipadsortTimeItem.textColor = [UIColor colorWithRGBHex:0x179cd8];

                docModule.ipadsortNameItem.selected = NO;
                [docModule.ipadsortNameItem.button setImage:[UIImage imageNamed:@"document_sortblank"] forState:UIControlStateNormal];
                docModule.ipadsortNameItem.textColor = [UIColor blackColor];

                docModule.ipadsortTypeItem.selected = NO;
                [docModule.ipadsortTypeItem.button setImage:[UIImage imageNamed:@"document_sortblank"] forState:UIControlStateNormal];
                docModule.ipadsortTypeItem.textColor = [UIColor blackColor];
                [docModule->browser sortFileByType:FileSortType_Date fileSortMode:docModule.ipadsortTimeItem.selected ? FileSortMode_Ascending : FileSortMode_Descending];
            };

            self.ipadsortTypeItem = [TbBaseItem createItemWithImageAndTitle:FSLocalizedString(@"kSize") imageNormal:[UIImage imageNamed:@"document_sortblank"] imageSelected:[UIImage imageNamed:@"document_sortupselect.png"] imageDisable:[UIImage imageNamed:@"document_sortblank"] background:nil imageTextRelation:RELATION_LEFT];
            self.ipadsortTypeItem.textColor = [UIColor blackColor];
            self.ipadsortTimeItem.textFont = [UIFont systemFontOfSize:15.0f];
            self.ipadsortTypeItem.tag = 4;
            self.ipadsortTypeItem.onTapClick = ^(TbBaseItem *item) {
                [docModule.ipadsortTypeItem.button setImage:[UIImage imageNamed:@"document_sortselect.png"] forState:UIControlStateNormal];
                docModule.ipadsortTypeItem.selected = !docModule.ipadsortTypeItem.selected;
                docModule.ipadsortTypeItem.textColor = [UIColor colorWithRGBHex:0x179cd8];

                docModule.ipadsortNameItem.selected = NO;
                [docModule.ipadsortNameItem.button setImage:[UIImage imageNamed:@"document_sortblank"] forState:UIControlStateNormal];
                docModule.ipadsortNameItem.textColor = [UIColor blackColor];

                docModule.ipadsortTimeItem.selected = NO;
                [docModule.ipadsortTimeItem.button setImage:[UIImage imageNamed:@"document_sortblank"] forState:UIControlStateNormal];
                docModule.ipadsortTimeItem.textColor = [UIColor blackColor];

                [docModule->browser sortFileByType:FileSortType_Size fileSortMode:docModule.ipadsortTypeItem.selected ? FileSortMode_Ascending : FileSortMode_Descending];
            };

            sortContainerView = [[UIView alloc] initWithFrame:CGRectMake(30, 0, 250, fileBrowser.contentView.bounds.size.height)];
            sortContainerView.backgroundColor = [UIColor clearColor];

            self.ipadsortNameItem.contentView.frame = CGRectMake(30, 0, self.ipadsortNameItem.contentView.frame.size.width, self.ipadsortNameItem.contentView.frame.size.height);
            self.ipadsortTimeItem.contentView.frame = CGRectMake(CGRectGetMaxX(self.ipadsortNameItem.contentView.frame) + 20, 0, self.ipadsortTimeItem.contentView.frame.size.width, self.ipadsortTimeItem.contentView.frame.size.height);
            self.ipadsortTypeItem.contentView.frame = CGRectMake(CGRectGetMaxX(self.ipadsortTimeItem.contentView.frame) + 20, 0, self.ipadsortTypeItem.contentView.frame.size.width, self.ipadsortTypeItem.contentView.frame.size.height);

            self.ipadsortNameItem.contentView.center = CGPointMake(self.ipadsortNameItem.contentView.center.x, sortContainerView.frame.size.height / 2);
            self.ipadsortTimeItem.contentView.center = CGPointMake(self.ipadsortTimeItem.contentView.center.x, sortContainerView.frame.size.height / 2);
            self.ipadsortTypeItem.contentView.center = CGPointMake(self.ipadsortTypeItem.contentView.center.x, sortContainerView.frame.size.height / 2);

            [sortContainerView addSubview:self.ipadsortNameItem.contentView];
            [sortContainerView addSubview:self.ipadsortTimeItem.contentView];
            [sortContainerView addSubview:self.ipadsortTypeItem.contentView];
            sortContainerView.center = fileBrowser.contentView.center;
            [fileBrowser.contentView addSubview:sortContainerView];

            UIView *linetwo = [[UIView alloc] initWithFrame:CGRectMake(0, fileBrowser.contentView.bounds.size.height - 1, fileBrowser.contentView.bounds.size.width, [Utility realPX:1.0f])];
            linetwo.backgroundColor = [UIColor colorWithRGBHex:0xe6e6e6];
            linetwo.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleRightMargin;
            [fileBrowser.contentView addSubview:linetwo];
        }

        [self pathView];
        [self.view addSubview:topToolbar.contentView];
        [self.view addSubview:contentView];
        topToolbar.contentView.translatesAutoresizingMaskIntoConstraints = NO;
        [topToolbar.contentView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(topToolbar.contentView.superview.mas_top).offset(0);
            make.width.mas_equalTo(topToolbar.contentView.superview.mas_width);
            make.height.mas_equalTo(64);
        }];
        contentView.translatesAutoresizingMaskIntoConstraints = NO;
        [contentView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(topToolbar.contentView.mas_bottom).offset(0);
            make.width.mas_equalTo(contentView.superview.mas_width);
            make.bottom.mas_equalTo(contentView.superview.mas_bottom);
        }];
    }
    return self;
}

// setup content view of popover of sort type
- (UIView *)configureSortPopoverView {
    UIView *menu = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 150, 150)];
    UIButton *date = [[UIButton alloc] initWithFrame:CGRectMake(10, 15, 150, 20)];
    date.tag = 200;
    [date setTitle:FSLocalizedString(@"kTimeSort") forState:UIControlStateNormal];
    [date setTitleColor:[UIColor colorWithRed:23.f / 255.f green:156.f / 255.f blue:216.f / 255.f alpha:1] forState:UIControlStateNormal];
    [date setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    date.titleLabel.font = [UIFont systemFontOfSize:15];
    date.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [date addTarget:self action:@selector(fileSort:) forControlEvents:UIControlEventTouchUpInside];
    [menu addSubview:date];

    UIButton *name = [[UIButton alloc] initWithFrame:CGRectMake(10, 65, 150, 20)];
    name.tag = 210;
    [name setTitle:FSLocalizedString(@"kName") forState:UIControlStateNormal];
    [name setTitleColor:[UIColor colorWithRed:23.f / 255.f green:156.f / 255.f blue:216.f / 255.f alpha:1] forState:UIControlStateNormal];
    [name setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    name.titleLabel.font = [UIFont systemFontOfSize:15];
    name.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [name addTarget:self action:@selector(fileSort:) forControlEvents:UIControlEventTouchUpInside];
    [menu addSubview:name];

    UIButton *size = [[UIButton alloc] initWithFrame:CGRectMake(10, 115, 150, 20)];
    size.tag = 220;
    [size setTitle:FSLocalizedString(@"kSize") forState:UIControlStateNormal];
    [size setTitleColor:[UIColor colorWithRed:23.f / 255.f green:156.f / 255.f blue:216.f / 255.f alpha:1] forState:UIControlStateNormal];
    [size setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    size.titleLabel.font = [UIFont systemFontOfSize:15];
    size.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [size addTarget:self action:@selector(fileSort:) forControlEvents:UIControlEventTouchUpInside];
    [menu addSubview:size];

    dateimage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"document_sortselect"]];
    dateimage.frame = CGRectMake(120, 15, 18, 18);
    nameimage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"document_sortselect"]];
    nameimage.frame = CGRectMake(120, 65, 18, 18);
    sizeimage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"document_sortselect"]];
    sizeimage.frame = CGRectMake(120, 115, 18, 18);

    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(10, 50, 130, [Utility realPX:1.0f])];
    line.backgroundColor = [UIColor colorWithRGBHex:0xe6e6e6];
    [menu addSubview:line];
    UIView *linetwo = [[UIView alloc] initWithFrame:CGRectMake(10, 100, 130, [Utility realPX:1.0f])];
    linetwo.backgroundColor = [UIColor colorWithRGBHex:0xe6e6e6];
    [menu addSubview:linetwo];
    [menu addSubview:dateimage];
    [menu addSubview:nameimage];
    [menu addSubview:sizeimage];

    nameimage.hidden = YES;
    sizeimage.hidden = YES;
    dateimage.hidden = YES;

    if (sortMode == FileSortMode_Ascending) {
        if (sortType == FileSortType_Name) {
            nameimage.hidden = NO;
            nameimage.image = [UIImage imageNamed:@"document_sortupselect.png"];
            name.selected = YES;
        } else if (sortType == FileSortType_Date) {
            dateimage.hidden = NO;
            dateimage.image = [UIImage imageNamed:@"document_sortupselect.png"];
            date.selected = YES;
        } else if (sortType == FileSortType_Size) {
            sizeimage.hidden = NO;
            sizeimage.image = [UIImage imageNamed:@"document_sortupselect.png"];
            size.selected = YES;
        }
    } else {
        if (sortType == FileSortType_Name) {
            nameimage.hidden = NO;
            nameimage.image = [UIImage imageNamed:@"document_sortselect.png"];
            name.selected = NO;
        } else if (sortType == FileSortType_Date) {
            dateimage.hidden = NO;
            dateimage.image = [UIImage imageNamed:@"document_sortselect.png"];
            date.selected = NO;
        } else if (sortType == FileSortType_Size) {
            sizeimage.hidden = NO;
            sizeimage.image = [UIImage imageNamed:@"document_sortselect.png"];
            size.selected = NO;
        }
    }
    return menu;
}

// popover sort type of file list
- (void)setSortButtonPopover {
    if (DEVICE_iPHONE) {
        UIView *menu = [self configureSortPopoverView];
        CGRect frame = self.sortNameItem.contentView.frame;
        CGPoint startPoint = CGPointMake(CGRectGetMidX(frame), CGRectGetMaxY(frame) + 64);
        popover = [DXPopover popover];
        [popover showAtPoint:startPoint popoverPosition:DXPopoverPositionDown withContentView:menu inView:self.view];
        isShowSortPopover = YES;
        popover.didDismissHandler = ^{
            isShowSortPopover = NO;
        };
    }
}

- (void)fileSort:(id)sender {
    UIButton *button = (UIButton *) sender;
    button.selected = !button.selected;
    sortMode = button.selected ? FileSortMode_Ascending : FileSortMode_Descending;
    if (button.tag == 200) // sort by time
    {
        dateimage.hidden = NO;
        nameimage.hidden = YES;
        sizeimage.hidden = YES;

        self.sortNameItem.text = FSLocalizedString(@"kTimeSort");
        if (button.selected) {
            self.sortNameItem.imageNormal = [UIImage imageNamed:@"document_sortupselect_black.png"];
            dateimage.image = [UIImage imageNamed:@"document_sortupselect.png"];
        } else {
            self.sortNameItem.imageNormal = [UIImage imageNamed:@"document_sortselect_black.png"];
            dateimage.image = [UIImage imageNamed:@"document_sortselect.png"];
        }

        sortType = FileSortType_Date;
        [self->browser sortFileByType:sortType fileSortMode:sortMode];

    } else if (button.tag == 210) // sort by name
    {
        dateimage.hidden = YES;
        nameimage.hidden = NO;
        sizeimage.hidden = YES;

        self.sortNameItem.text = FSLocalizedString(@"kName");

        if (button.selected) {
            self.sortNameItem.imageNormal = [UIImage imageNamed:@"document_sortupselect_black.png"];
            nameimage.image = [UIImage imageNamed:@"document_sortupselect.png"];
        } else {
            self.sortNameItem.imageNormal = [UIImage imageNamed:@"document_sortselect_black.png"];
            nameimage.image = [UIImage imageNamed:@"document_sortselect.png"];
        }
        sortType = FileSortType_Name;
        [self->browser sortFileByType:sortType fileSortMode:sortMode];

    } else if (button.tag == 220) // sort by size
    {
        dateimage.hidden = YES;
        nameimage.hidden = YES;
        sizeimage.hidden = NO;

        self.sortNameItem.text = FSLocalizedString(@"kSize");

        if (button.selected) {
            self.sortNameItem.imageNormal = [UIImage imageNamed:@"document_sortupselect_black.png"];
            sizeimage.image = [UIImage imageNamed:@"document_sortupselect.png"];
        } else {
            self.sortNameItem.imageNormal = [UIImage imageNamed:@"document_sortselect_black.png"];
            sizeimage.image = [UIImage imageNamed:@"document_sortselect.png"];
        }
        sortType = FileSortType_Size;
        [self->browser sortFileByType:sortType fileSortMode:sortMode];
    }
    __block FSFileListViewController *docModule = self;
    [docModule->popover dismiss];
    docModule->isShowMorePopover = NO;
    docModule->isShowSortPopover = NO;
}

// add a view showing current path
- (void)pathView {
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(returnPreviousPath:)];
    tapGesture.numberOfTapsRequired = 1;
    tapGesture.numberOfTouchesRequired = 1;

    UITapGestureRecognizer *tapGestureTwo = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(returnPreviousPath:)];
    tapGestureTwo.numberOfTapsRequired = 1;
    tapGestureTwo.numberOfTouchesRequired = 1;
    _rootView = [[UIView alloc] initWithFrame:CGRectMake(DEVICE_iPHONE ? 10 : 15, DEVICE_iPHONE ? 40 : 0, 270, 40)];
    _rootView.backgroundColor = [UIColor clearColor];
    UIImageView *previousImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 13, 18, 18)];
    previousImage.userInteractionEnabled = YES;
    previousImage.image = [UIImage imageNamed:@"document_path_back"];
    previousImage.tag = 20;
    [previousImage addGestureRecognizer:tapGestureTwo];

    previousPath = [[UILabel alloc] initWithFrame:CGRectMake(20, 20, 100, 25)];
    previousPath.lineBreakMode = NSLineBreakByTruncatingMiddle;
    previousPath.font = [UIFont systemFontOfSize:16];
    previousPath.textColor = [UIColor colorWithRed:23.f / 255.f green:156.f / 255.f blue:216.f / 255.f alpha:1];

    nextImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"document_path_arrow"]];
    nextImage.frame = CGRectMake(0, 0, 6, 6);

    currentPath = [[UILabel alloc] initWithFrame:CGRectMake(DEVICE_iPHONE ? 145 : 155, 20, 100, 25)];
    currentPath.lineBreakMode = NSLineBreakByTruncatingMiddle;
    currentPath.font = [UIFont systemFontOfSize:16];
    [_rootView addSubview:previousPath];
    [_rootView addSubview:currentPath];
    [previousPath addGestureRecognizer:tapGesture];
    previousPath.tag = 21;
    previousPath.userInteractionEnabled = YES;
    [_rootView addSubview:previousImage];
    [_rootView addSubview:nextImage];
    [contentView addSubview:_rootView];
    _rootView.hidden = YES;
}

- (void)returnPreviousPath:(UIGestureRecognizer *)tapGesture {
    if ([tapGesture.view isKindOfClass:[UIImageView class]]) {
        [pathItems removeAllObjects];
        [self setPathTitle:nil currentTitle:nil isHidden:YES];
        [[browser getNaviController] popToRootViewControllerAnimated:YES];
        [browser changeThumbnailFrame:NO];
        return;
    }

    [pathItems removeLastObject];
    if ([pathItems count] == 1 || [pathItems count] == 0) {
        if ([pathItems count] == 1) {
            FileItem *currentfileItem = [pathItems lastObject];
            [self setPathTitle:nil currentTitle:currentfileItem.fileName isHidden:NO];
        } else {
            [self setPathTitle:nil currentTitle:nil isHidden:YES];
        }
    } else {
        FileItem *currentfileItem = [pathItems lastObject];
        FileItem *previousfileItem = [pathItems objectAtIndex:[pathItems indexOfObject:currentfileItem] - 1];
        [self setPathTitle:previousfileItem.fileName currentTitle:currentfileItem.fileName isHidden:NO];
    }
    [[browser getNaviController] popViewControllerAnimated:YES];
    if (DEVICE_iPHONE) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [browser changeThumbnailFrame:YES];
        });
    }
}

- (void)setPathTitle:(NSString *)previousTitle currentTitle:(NSString *)currentTitle isHidden:(BOOL)hidden {
    previousPath.text = previousTitle == nil ? @"Document" : [previousTitle lastPathComponent];
    currentPath.text = [currentTitle lastPathComponent];
    _rootView.hidden = hidden;
    CGSize textSize = [previousPath.text boundingRectWithSize:CGSizeMake(110, 25) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:16]} context:nil].size;
    previousPath.frame = CGRectMake(23, 10, textSize.width, 25);
    nextImage.frame = CGRectMake(CGRectGetMaxX(previousPath.frame) + 8, 20, 6, 6);
    currentPath.frame = CGRectMake(CGRectGetMaxX(nextImage.frame) + 8, 10, 110, 25);
}

- (void)onItemCliked:(FileItem *)item {
    if (!item.isFolder) {
        [self.delegate didFileSelected:item.path];
        item.isOpen = YES;
        currentFileItem = item;
    } else {
        if ([pathItems count] == 0) {
            [self setPathTitle:nil currentTitle:item.fileName isHidden:NO];

        } else {
            FileItem *fileItem = [pathItems lastObject];
            [self setPathTitle:fileItem.fileName currentTitle:item.fileName isHidden:NO];
        }
        [pathItems addObject:item];
        if (DEVICE_iPHONE) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [browser changeThumbnailFrame:YES];
            });
        }
    }
}

- (void)onItemsChecked:(NSArray *)item {
}

- (TbBaseBar *)getTopToolBar {
    return topToolbar;
}

- (UIView *)getTopToolbar {
    return topToolbar.contentView;
}

- (UIView *)getContentView {
    return contentView;
}

#pragma mark - Orientation changed notification method
- (void)orientationChanged:(NSNotification *)object {
    if (isShowMorePopover) {
        isShowMorePopover = NO;
        [popover.contentView removeFromSuperview];
        [popover.blackOverlay removeFromSuperview];
        [popover removeFromSuperview];
        if (popover.didDismissHandler) {
            popover.didDismissHandler();
        }
    } else if (isShowSortPopover) {
        isShowSortPopover = NO;
        [popover.contentView removeFromSuperview];
        [popover.blackOverlay removeFromSuperview];
        [popover removeFromSuperview];
        if (popover.didDismissHandler) {
            popover.didDismissHandler();
        }
        [self performSelector:@selector(setSortButtonPopover) withObject:self afterDelay:0.2f];
    }
    [self performSelector:@selector(reframingSortContainerView) withObject:self afterDelay:0.2f];
}

- (void)reframingSortContainerView {
    sortContainerView.center = fileBrowser.contentView.center;
}

#pragma mark IDocEventListener
- (void)onDocSaved:(FSPDFDoc *)document error:(int)error {
    //update folder size dictionary
    if (!currentFileItem)
        return;
    NSString *key = [[currentFileItem.path componentsSeparatedByString:DOCUMENT_PATH] objectAtIndex:1];
    NSMutableDictionary<NSString *, NSNumber *> *folderSizeDictionary = [FileManageListViewController getFolderSizeDictionary];
    while (![(key = [key stringByDeletingLastPathComponent]) isEqualToString:@"/"]) {
        [folderSizeDictionary removeObjectForKey:key];
    }
}

@end
