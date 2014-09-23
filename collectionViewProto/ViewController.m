//
//  ViewController.m
//  collectionViewProto
//
//  Created by raymond chen on 2014-09-21.
//  Copyright (c) 2014 raymond chen. All rights reserved.
//

#import "ViewController.h"

#define middleColumnOffset 70

@interface ViewController ()
//	Plate Source Array
@property (nonatomic, strong) NSMutableArray *plateSourceArray;
//	Long Press Gesture
@property (nonatomic, strong) UITapGestureRecognizer *tapGesture;
//	Menu Mode
@property (nonatomic, assign) BOOL isMenuShown;

@end

@implementation ViewController

- (void)viewDidLoad {
	[super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
	
	//	Initialize the plateSourceArray
	if (!self.plateSourceArray){
		//	This could be any data source
		self.plateSourceArray = [NSMutableArray arrayWithArray:@[@"APPLE", @"PEAR", @"APPLE", @"PEAR", @"APPLE", @"PEAR", @"APPLE", @"PEAR", @"APPLE", @"PEAR", @"APPLE", @"PEAR", @"APPLE", @"PEAR", @"APPLE", @"PEAR", @"APPLE", @"PEAR", @"APPLE", @"PEAR", @"APPLE", @"PEAR", @"APPLE", @"PEAR", @"APPLE", @"PEAR", @"APPLE", @"PEAR", @"APPLE", @"PEAR", @"APPLE", @"PEAR", @"APPLE", @"PEAR", @"APPLE", @"PEAR", @"APPLE", @"PEAR", @"APPLE", @"PEAR", @"APPLE", @"PEAR", @"APPLE", @"PEAR"]];
	}
	
	//	Setup long press gesture for collection view
	self.tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onTappingOnPlate:)];
	[self.discoverPlateCollectionView addGestureRecognizer:self.tapGesture];
	self.tapGesture.numberOfTapsRequired = 1;
	self.tapGesture.delegate = self;

	if ([self respondsToSelector:@selector(edgesForExtendedLayout)])
		self.edgesForExtendedLayout = UIRectEdgeNone;
	
	//	Setup Views
	self.tryPlateOptionView.layer.cornerRadius = self.tryPlateOptionView.bounds.size.width/2;
	self.tryPlateOptionView.clipsToBounds = YES;
	
	self.thumbDownOptionView.layer.cornerRadius = self.thumbDownOptionView.bounds.size.width/2;
	self.thumbDownOptionView.clipsToBounds = YES;
	
	self.thumbUpOptionView.layer.cornerRadius = self.thumbUpOptionView.bounds.size.width/2;
	self.thumbUpOptionView.clipsToBounds = YES;
	
	self.goToPageOptionView.layer.cornerRadius = self.goToPageOptionView.bounds.size.width/2;
	self.goToPageOptionView.clipsToBounds = YES;
	
	self.selectedPlateImageView.layer.cornerRadius = self.selectedPlateImageView.bounds.size.width/2;
	self.selectedPlateImageView.clipsToBounds = YES;
}

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}

#pragma mark - UICollectionView Datasource
- (NSInteger)collectionView:(UICollectionView *)view numberOfItemsInSection:(NSInteger)section {
	//	Only one section, return the count in plateSourceArray
	return self.plateSourceArray.count;
}

- (NSInteger)numberOfSectionsInCollectionView: (UICollectionView *)collectionView {
	//	Only one section is required for now
	return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)cv cellForItemAtIndexPath:(NSIndexPath *)indexPath {
	//	Retrieve the custom cell for the current indexpath
	UICollectionViewCell *cell = [cv dequeueReusableCellWithReuseIdentifier:@"SinglePlateCell" forIndexPath:indexPath];
	cell.backgroundColor = [UIColor clearColor];
	
	//	Update the plate image view to circle
	UIImageView *plateImageView = (UIImageView*)[cell viewWithTag:100];
	plateImageView.image = [UIImage imageNamed:[self randomizePlatesForIndex:indexPath]];
	
	//	Edit corner radius
	plateImageView.layer.cornerRadius = plateImageView.bounds.size.height/2;
	plateImageView.clipsToBounds = YES;
	
	//	Add border
	plateImageView.layer.borderColor = [[UIColor grayColor] CGColor];
	plateImageView.layer.borderWidth = 1.0f;
	
	//	Offset every second plate
	if ((indexPath.row + 2) % 3 == 0){
		[UIView animateWithDuration:0.4 animations:^{
			cell.transform = CGAffineTransformIdentity;
			cell.transform = CGAffineTransformTranslate(cell.transform, 0, middleColumnOffset);
		}];


	}
	
	//	Add pop in animation to plate image
	plateImageView.transform = CGAffineTransformScale(plateImageView.transform, 0.4, 0.4);
	
	[UIView animateWithDuration:0.5
						  delay:0.1
		 usingSpringWithDamping:0.8
		  initialSpringVelocity:0.7
						options:UIViewAnimationOptionCurveEaseIn
					 animations:^{
		plateImageView.alpha = 1.0;
		plateImageView.transform = CGAffineTransformIdentity;
						 
	} completion:^(BOOL finished) {
		
	}];
	
	return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didEndDisplayingCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath{
	//	Fade out the plate image
	UIImageView *plateImageView = (UIImageView*)[cell viewWithTag:100];

	[UIView animateWithDuration:0.4 animations:^{
		plateImageView.alpha = 0.0;
	}];
}

#pragma mark - UICollectionViewDelegate
//- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
//{
//	// TODO: Select Item
//	NSLog(@"Selected");
//}
//- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath {
//	// TODO: Deselect item
//}

#pragma mark – UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {

	//	Default to this size for now
	return CGSizeMake(98, 126);
	
}

- (UIEdgeInsets)collectionView:
(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
	return UIEdgeInsetsMake(-60, 0, 0, 0);
}



- (NSString*)randomizePlatesForIndex:(NSIndexPath*)targetIndexPath{
	//	Returns a random image from the array
	NSArray *myImageNames = [NSArray arrayWithObjects:
							 @"tempImage1.jpg",
							 @"tempImage2.jpg",
							 @"tempImage3.jpg",
							 @"tempImage4.jpg",
							 @"tempImage5.jpg",
							 @"tempImage6.jpg",
							 @"tempImage7.jpg",
							 @"tempImage8.jpg",
							 @"tempImage9.jpg",
							 nil];
	int index = arc4random() % (myImageNames.count - 1);
		
	return [myImageNames objectAtIndex:index];
}

#pragma mark - Long Press Gesture Recognizer
-(void)onTappingOnPlate:(UILongPressGestureRecognizer *)gestureRecognizer
{
	if (gestureRecognizer.view == self.discoverPlateCollectionView){
		//	Determine the press location in the collection view
		CGPoint p = [gestureRecognizer locationInView:self.discoverPlateCollectionView];
		
		//	Offset for the middle column
		if (p.x > self.view.bounds.size.width / 3 && p.x < self.view.bounds.size.width / 3 * 2){
			
			p.y = p.y - middleColumnOffset;
		}
		
		NSIndexPath *indexPath = [self.discoverPlateCollectionView indexPathForItemAtPoint:p];
		if (indexPath == nil){
			NSLog(@"no index path detected");
		} else {
			if (!self.isMenuShown){
				[self showPlateOptions];
				
				//	get the cell at indexPath
				UICollectionViewCell* cell =
				[self.discoverPlateCollectionView cellForItemAtIndexPath:indexPath];
				UIImageView *plateImageView = (UIImageView*)[cell viewWithTag:100];
				
				//	Update the selected plate image
				self.selectedPlateImageView.image = plateImageView.image;
			}
		}
	}else{
		[self hidePlateOptions];
	}
	
}

- (void)showPlateOptions{
	self.isMenuShown = !self.isMenuShown;
	
	//	Show the menu view
	[UIView animateWithDuration:0.5 animations:^{
		self.dimView.hidden = NO;
		self.menuView.hidden = NO;
	}completion:^(BOOL finished) {
		 [UIView animateWithDuration:0.7 delay:0 usingSpringWithDamping:0.5 initialSpringVelocity:0.7 options:UIViewAnimationOptionCurveEaseInOut animations:^{
					self.tryPlateOptionView.transform = CGAffineTransformTranslate(self.tryPlateOptionView.transform, 0, 70);
					self.thumbUpOptionView.transform = CGAffineTransformTranslate(self.thumbUpOptionView.transform, 50, 0);
					self.thumbDownOptionView.transform = CGAffineTransformTranslate(self.thumbDownOptionView.transform, -50, 0);
					self.goToPageOptionView.transform = CGAffineTransformTranslate(self.goToPageOptionView.transform, 0, -50);
		} completion:^(BOOL finished) {
			[self.menuView addGestureRecognizer:self.tapGesture];
		}];
	}];
}

- (void)hidePlateOptions{
	self.isMenuShown = !self.isMenuShown;
	
	//	Hide the menu view
	[UIView animateWithDuration:0.3 delay:0 usingSpringWithDamping:1.0 initialSpringVelocity:0.7 options:UIViewAnimationOptionCurveEaseInOut animations:^{
		self.tryPlateOptionView.transform = CGAffineTransformIdentity;
		self.thumbUpOptionView.transform = CGAffineTransformIdentity;
		self.thumbDownOptionView.transform = CGAffineTransformIdentity;
		self.goToPageOptionView.transform = CGAffineTransformIdentity;
	} completion:^(BOOL finished) {
		self.dimView.hidden = YES;
		self.menuView.hidden = YES;
		[self.discoverPlateCollectionView addGestureRecognizer:self.tapGesture];
	}];
}
@end
