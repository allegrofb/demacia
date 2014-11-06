//
//  DMCWritePostTextTableViewCell.h
//  Demacia
//
//  Created by Hongyong Jiang on 06/11/14.
//  Copyright (c) 2014年 Demacia.cc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DMCWritePostTextTableViewCell : UITableViewCell <UICollectionViewDataSource, UICollectionViewDelegate>

@property(nonatomic,strong) IBOutlet UICollectionView *  collectionView;

@end
