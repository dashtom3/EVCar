//
//  SearchView.h
//  EVCar
//
//  Created by 田程元 on 15/10/29.
//  Copyright (c) 2015年 TIAN. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SearchView : UICollectionViewCell
@property (strong, nonatomic) IBOutlet UILabel *labelContent;
@property (strong, nonatomic) IBOutlet UILabel *labelType;
@property (strong, nonatomic) IBOutlet UIImageView *imageView;
-(void)setContent:(NSString*)content;
-(void)setDataWithImage:(NSString*)image WithType:(NSString*)type WithContent:(NSString*)content;
@end
