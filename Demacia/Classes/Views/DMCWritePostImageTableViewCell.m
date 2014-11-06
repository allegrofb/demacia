//
//  DMCWritePostImageTableViewCell.m
//  Demacia
//
//  Created by Hongyong Jiang on 06/11/14.
//  Copyright (c) 2014年 Demacia.cc. All rights reserved.
//

#import "DMCWritePostImageTableViewCell.h"
#import "DMCWritePostImageImageCollectionViewCell.h"

@interface DMCWritePostImageTableViewCell()
{
    NSMutableArray* _imageArray;
}
@end

@implementation DMCWritePostImageTableViewCell

- (void)awakeFromNib {
    // Initialization code
    _imageArray = [[NSMutableArray alloc] init];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _imageArray.count + 2;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    if(indexPath.row == _imageArray.count)
    {
        DMCWritePostImageImageCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"DMCWritePostTextCollectionImageCell1" forIndexPath:indexPath];
        
        cell.imageView.backgroundColor = [UIColor blackColor];
        
        return cell;
    }
    if(indexPath.row == _imageArray.count+1)
    {
        UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"DMCWritePostTextCollectionImageCell2" forIndexPath:indexPath];
        
        
        
        return cell;
    }
    else
    {
        UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"DMCWritePostTextCollectionImageCell1" forIndexPath:indexPath];
        
        //load image
        
        return cell;
        
    }
}


@end
