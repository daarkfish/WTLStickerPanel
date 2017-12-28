//
//  WTLStickerPanel2.h
//  Pods
//
//  Created by Daarkfish on 27/12/2017.
//
//

#import <UIKit/UIKit.h>
#import "WTLSticker.h"
@protocol WTLStickerPanelDelegate;

@interface WTLStickerPanel : UIView
@property (nonatomic, weak) id <WTLStickerPanelDelegate> delegate;

- (void) updateWithStickerArray:(NSArray *)stickerArray;
+ (void) showStickerPanel;
+ (void) dismissStickerPanel;
+ (void) setDelegate:(id) delegate;
+ (void) setUpSickerPanelWithStickerList:(NSArray *)stickerList;
@end

@protocol WTLStickerPanelDelegate <NSObject>
@optional
-(void) didSelectSticker:(WTLSticker *)sticker;

@end
