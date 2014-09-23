//
//  ViewController.h
//  collectionViewProto
//
//  Created by raymond chen on 2014-09-21.
//  Copyright (c) 2014 raymond chen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UIGestureRecognizerDelegate>

@property (strong, nonatomic) IBOutlet UICollectionView *discoverPlateCollectionView;

@property (strong, nonatomic) IBOutlet UIView *dimView;
@property (strong, nonatomic) IBOutlet UIView *menuView;

//	Option views : WON'T TRY/GO TO PAGE/THUMB UP/THUMB DOWN
@property (strong, nonatomic) IBOutlet UIView *tryPlateOptionView;
@property (strong, nonatomic) IBOutlet UIView *thumbUpOptionView;
@property (strong, nonatomic) IBOutlet UIView *thumbDownOptionView;
@property (strong, nonatomic) IBOutlet UIView *goToPageOptionView;

@property (strong, nonatomic) IBOutlet UIImageView *selectedPlateImageView;
@end

