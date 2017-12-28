//
//  WTLStickerCollectionViewCell.m
//  Pods
//
//  Created by Daarkfish on 13/12/2017.
//
//

#import "WTLStickerCollectionViewCell.h"
#import "YYWebImage.h"
@interface WTLStickerCollectionViewCell()
@property (strong, nonatomic) IBOutlet YYAnimatedImageView *stickerImageView;
@property (strong, nonatomic) WTLSticker *currentSticker;
@end
@implementation WTLStickerCollectionViewCell
-(void) awakeFromNib
{
    [super awakeFromNib];
   
}

-(void) updateDisplay:(id)object
{

    WTLSticker *sticker = object;
    self.currentSticker = sticker;
    if([self.currentSticker.ImageUrl containsString:@"gif"])
    {
//         [self.stickerImageView setAnimatedImage:[FLAnimatedImage animatedImageWithGIFData:[NSData dataWithContentsOfURL:[NSURL URLWithString:self.currentSticker.ImageUrl]]]];
        self.stickerImageView.yy_imageURL = [NSURL URLWithString:sticker.ImageUrl];
    }
    else
    {
        [self.stickerImageView yy_setImageWithURL:[NSURL URLWithString:sticker.ImageUrl] options:YYWebImageOptionProgressive];
    }
}

-(IBAction) stickerPressed
{
    if([self.delegate respondsToSelector:@selector(selectSticker:)])
    {
        [self.delegate selectSticker:self.currentSticker];
    }
}
@end
