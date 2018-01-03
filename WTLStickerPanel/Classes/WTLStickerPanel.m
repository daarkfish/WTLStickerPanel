//
//  WTLStickerPanel.m
//  Pods
//
//  Created by Daarkfish on 13/12/2017.
//
//

#import "WTLStickerPanel.h"
#import "WTLStickerCollectionViewCell.h"
#import <CoreGraphics/CoreGraphics.h>
#import "WTLGridHorizontalCollectionViewLayout.h"
#import "WTLSticker.h"

#define STICKER_PANEL_HEIGHT 215
@interface WTLStickerPanel()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, WTLStickerCollectionViewCellDelegate>
@property (nonatomic, strong) NSMutableArray *stickerList;
@property (strong, nonatomic) IBOutlet UICollectionView *collectionView;
@property (strong, nonatomic) IBOutlet UIPageControl *pageControl;
@end

@implementation WTLStickerPanel
+ (WTLStickerPanel*)sharedPanel {
    static dispatch_once_t once;
    
    static WTLStickerPanel *sharedPanel;

    dispatch_once(&once, ^{ sharedPanel = [[self alloc] init];  sharedPanel.stickerList = [NSMutableArray new];});
   
    return sharedPanel;
}


-(WTLStickerPanel *)init{
    WTLStickerPanel *result = nil;
      NSBundle *podbundle = [NSBundle bundleForClass:[self class]];
    NSURL *bundleURL = [podbundle URLForResource:@"WTLStickerPanel" withExtension:@"bundle"];
    NSBundle *bundle = [NSBundle bundleWithURL:bundleURL];
    NSArray* elements = [bundle loadNibNamed: NSStringFromClass([self class]) owner:self options: nil];
    for (id item in elements)
    {
        if ([item isKindOfClass:[self class]])
        {
            result = item;
            result.frame = CGRectMake(0, [[UIScreen mainScreen] bounds].size.height, [[UIScreen mainScreen] bounds].size.width, STICKER_PANEL_HEIGHT);
            break;
        }
    }
    return result;
}



-(void) updateWithStickerArray:(NSArray *)stickerArray
{
    
    NSBundle *podbundle = [NSBundle bundleForClass:[self class]];
    NSURL *bundleURL = [podbundle URLForResource:@"WTLStickerPanel" withExtension:@"bundle"];
    NSBundle *bundle = [NSBundle bundleWithURL:bundleURL];
    [self.collectionView registerNib:[UINib nibWithNibName:@"WTLStickerCollectionViewCell" bundle:bundle] forCellWithReuseIdentifier:@"stickerCell"];

    float divisionValue = (float)stickerArray.count / 6;
    int pageCount = (int)divisionValue;
    
    [self.stickerList removeAllObjects];
    NSMutableArray *sectionStickerList = [NSMutableArray new];
    WTLSticker *emptySticker = [WTLSticker new];
    for (int i = 0; i < [stickerArray count]; i++) {
       if( [sectionStickerList count] < 6)
       {
           [sectionStickerList addObject:stickerArray[i]];
           if([sectionStickerList count] == 6 || i == [stickerArray count] - 1)
           {
               [self.stickerList addObject:sectionStickerList];
               sectionStickerList = [NSMutableArray new];
           }
       }
    
        
    }
    NSInteger lastSectionItemCount = [[self.stickerList lastObject] count] ;
    if (lastSectionItemCount < 6) {
        NSInteger remainingCount = 6 - lastSectionItemCount;
        for (int j = 0; j < remainingCount; j++)  {
            [[self.stickerList lastObject] addObject:emptySticker];
        }
    }
   
    self.pageControl.numberOfPages = [self.stickerList count] % 6 == 0 ? pageCount : pageCount + 1;
    [self.collectionView reloadData];
}

#pragma mark - UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout

-(NSInteger) numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return [self.stickerList count];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [self.stickerList[section] count];
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    WTLStickerCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"stickerCell" forIndexPath:indexPath];
    [cell updateDisplay:self.stickerList[indexPath.section][indexPath.row]];
    cell.delegate = self;
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(self.frame.size.width/3 , self.frame.size.height/3);
}

- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath
{
    self.pageControl.currentPage = indexPath.section;
}

#pragma mark - setup / show / dismiss
+(void) setDelegate:(id) delegate
{
    [WTLStickerPanel sharedPanel].delegate = delegate;
}

+(void) setUpSickerPanelWithStickerList:(NSArray *)stickerList
{

    UIBezierPath *shadowPath = [UIBezierPath bezierPathWithRect:[WTLStickerPanel sharedPanel].bounds];
    [WTLStickerPanel sharedPanel].layer.masksToBounds = NO;
    [WTLStickerPanel sharedPanel].layer.shadowColor = [UIColor blackColor].CGColor;
    [WTLStickerPanel sharedPanel].layer.shadowOffset = CGSizeMake(0.0f, 1.0f);
    [WTLStickerPanel sharedPanel].layer.shadowOpacity = 0.3f;
    [WTLStickerPanel sharedPanel].layer.shadowPath = shadowPath.CGPath;
    [[WTLStickerPanel sharedPanel] updateWithStickerArray:stickerList];
}


+ (void) showStickerPanel
{
    UIWindow *window = [[UIApplication sharedApplication].windows lastObject];
    [window addSubview:[WTLStickerPanel sharedPanel] ];
    [window bringSubviewToFront:[WTLStickerPanel sharedPanel]];
    
    [UIView animateWithDuration:0.5 animations:^{
        [WTLStickerPanel sharedPanel] .frame = CGRectMake(0, [[UIScreen mainScreen] bounds].size.height - STICKER_PANEL_HEIGHT, [[UIScreen mainScreen] bounds].size.width, STICKER_PANEL_HEIGHT);
    }];
}

+(void) dismissStickerPanel
{
    UIWindow *window = [[UIApplication sharedApplication].windows lastObject];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"self isKindOfClass: %@",
                      [self class]];
    NSArray *result = [window.subviews filteredArrayUsingPredicate:predicate];
    if([result count] > 0)
    {
        WTLStickerPanel *panelView = result[0];
  
        [UIView animateWithDuration:0.5 animations:^{
            panelView.frame = CGRectMake(0, [[UIScreen mainScreen] bounds].size.height, [[UIScreen mainScreen] bounds].size.width, STICKER_PANEL_HEIGHT);
        } completion:^(BOOL finished) {
            [panelView removeFromSuperview];
        }];
    }
}

#pragma mark -  WTLStickerCollectionViewCellDelegate
-(void) selectSticker:(WTLSticker *_Nonnull)sticker
{
    if([self.delegate respondsToSelector:@selector(didSelectSticker:)] && [sticker.Stickercode length] > 0)
    {
        [self.delegate didSelectSticker:sticker];
    }
}

@end
