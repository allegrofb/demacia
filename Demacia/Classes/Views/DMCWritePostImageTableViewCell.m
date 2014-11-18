//
//  DMCWritePostImageTableViewCell.m
//  Demacia
//
//  Created by Hongyong Jiang on 06/11/14.
//  Copyright (c) 2014年 Demacia.cc. All rights reserved.
//

#import "DMCWritePostImageTableViewCell.h"
#import "DMCWritePostImageImageCollectionViewCell.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import "Utility.h"

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
        
//        cell.imageView.backgroundColor = [UIColor blackColor];
        cell.imageView.image = [UIImage imageNamed:@"addImage.png"];
        
        cell.tag = indexPath.row;
        
        return cell;
    }
    if(indexPath.row == _imageArray.count+1)
    {
        UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"DMCWritePostTextCollectionImageCell2" forIndexPath:indexPath];
        
        cell.tag = indexPath.row;
        
        
        return cell;
    }
    else
    {
        DMCWritePostImageImageCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"DMCWritePostTextCollectionImageCell1" forIndexPath:indexPath];
        
        DLog(@"row = %ld",indexPath.row);
        
        cell.imageView.image = _imageArray[indexPath.row];
        cell.tag = indexPath.row;
        
        return cell;
    }
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if(!self.editing)
    {
        //deselect cell view
        [self.collectionView deselectItemAtIndexPath:indexPath animated:YES];
        
        if(indexPath.row == _imageArray.count)
        {
            [self.delegate addImageButtonAction];
        }
        
        return;
    }    
}

- (void)setImageArray:(NSArray*)images
{
    [_imageArray removeAllObjects];
    
    for (id img in images) {
        [_imageArray addObject:img];
    }
    
    [self.collectionView reloadData];
}

@end
