//
//  DMCAsserts.h
//  Demacia
//
//  Created by Hongyong Jiang on 29/03/13.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface DMCAsserts : NSObject

+ (DMCAsserts *)sharedInstance;

@property(nonatomic,readonly,strong) UIColor* colorPrimary;
@property(nonatomic,readonly,strong) UIColor* colorPrimaryLight;
@property(nonatomic,readonly,strong) UIColor* colorPrimaryLessLight;
@property(nonatomic,readonly,strong) UIColor* colorPrimaryDark;
@property(nonatomic,readonly,strong) UIColor* colorPrimaryMoreDark;
@property(nonatomic,readonly,strong) UIColor* colorSecondary;
@property(nonatomic,readonly,strong) UIColor* colorSecondaryLight;
@property(nonatomic,readonly,strong) UIColor* colorSecondaryLessLight;
@property(nonatomic,readonly,strong) UIColor* colorSecondaryDark;
@property(nonatomic,readonly,strong) UIColor* colorSecondaryMoreDark;
@property(nonatomic,readonly,strong) UIColor* colorTertiary;
@property(nonatomic,readonly,strong) UIColor* colorTertiaryLight;
@property(nonatomic,readonly,strong) UIColor* colorTertiaryLessLight;
@property(nonatomic,readonly,strong) UIColor* colorTertiaryDark;
@property(nonatomic,readonly,strong) UIColor* colorTertiaryMoreDark;

@property(nonatomic,readonly,strong) UIColor* colorTextureBg;
@property(nonatomic,readonly,strong) UIColor* colorNavigationBar;
@property(nonatomic,readonly,strong) UIColor* colorOptionPanel;
@property(nonatomic,readonly,strong) UIColor* colorLinkedText;
@property(nonatomic,readonly,strong) UIColor* colorPanel;
@property(nonatomic,readonly,strong) UIColor* colorButtonBg;
@property(nonatomic,readonly,strong) UIColor* colorButtonTitle;
@property(nonatomic,readonly,strong) UIColor* colorButtonBg2;
@property(nonatomic,readonly,strong) UIColor* colorButtonTitle2;

@property(nonatomic,readonly,strong) UIImage* imageButtonBg;
@property(nonatomic,readonly,strong) UIImage* imageButtonBg2;

@property(nonatomic,readonly,strong) UIColor* colorTextureHatched;

@property(nonatomic,readonly,strong) UIImage* imageButtonPhoto;
@property(nonatomic,readonly,strong) UIImage* imageButtonAlbum;

@property(nonatomic,readonly,strong) UIImage* imageBarButtonItemBrightness;
@property(nonatomic,readonly,strong) UIImage* imageBarButtonItemContrast;
@property(nonatomic,readonly,strong) UIImage* imageBarButtonItemSave;
@property(nonatomic,readonly,strong) UIImage* imageBarButtonItemEmail;
@property(nonatomic,readonly,strong) UIImage* imageBarButtonItemDelete;
@property(nonatomic,readonly,strong) UIImage* imageBarButtonItemPrint;
@property(nonatomic,readonly,strong) UIImage* imageBarButtonItemTrash;
@property(nonatomic,readonly,strong) UIImage* imageBarButtonItemFavorities;

@property(nonatomic,readonly,strong) UIColor* colorNavigationBar1;
@property(nonatomic,readonly,strong) UIColor* colorNavigationBar2;
@property(nonatomic,readonly,strong) UIColor* colorNavigationBar3;

@property(nonatomic,readonly,strong) UIImage* imageLogo;


@end
