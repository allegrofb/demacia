//
//  DMCWritePostTextTableViewCell.m
//  Demacia
//
//  Created by Hongyong Jiang on 06/11/14.
//  Copyright (c) 2014年 Demacia.cc. All rights reserved.
//

#import "DMCWritePostTextTableViewCell.h"

@implementation DMCWritePostTextTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 3;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{

    if(indexPath.row == 0)
    {
        UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"DMCWritePostTextCollectionTextCell1" forIndexPath:indexPath];
        
        return cell;
    }
    else
    {
        UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"DMCWritePostTextCollectionTextCell2" forIndexPath:indexPath];
        
        return cell;
        
    }
}


@end
