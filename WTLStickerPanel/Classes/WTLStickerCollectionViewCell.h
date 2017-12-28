//
//  WTLStickerCollectionViewCell2.h
//  Pods
//
//  Created by Daarkfish on 27/12/2017.
//
//

#import <UIKit/UIKit.h>
#import "WTLSticker.h"

@protocol WTLStickerCollectionViewCellDelegate;


@interface WTLStickerCollectionViewCell : UICollectionViewCell
@property (nonatomic, weak, nullable) id <WTLStickerCollectionViewCellDelegate> delegate;

-(void) updateDisplay:(id _Nonnull )object;
@end

@protocol WTLStickerCollectionViewCellDelegate <NSObject>
@optional
-(void) selectSticker:(WTLSticker *_Nonnull)sticker;

@end
