//
//  DMCWritePostImageTableViewCell.h
//  Demacia
//
//  Created by Hongyong Jiang on 06/11/14.
//  Copyright (c) 2014年 Demacia.cc. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol DMCWritePostImageTableViewCellDelegate <NSObject>

- (void)addImageButtonAction;

@end


@interface DMCWritePostImageTableViewCell : UITableViewCell <UICollectionViewDataSource, UICollectionViewDelegate>

@property(nonatomic,strong) IBOutlet UICollectionView *  collectionView;

@property(nonatomic, weak)id<DMCWritePostImageTableViewCellDelegate> delegate;

- (void)setImageArray:(NSArray*)assets;

@end
