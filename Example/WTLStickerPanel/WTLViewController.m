//
//  WTLViewController.m
//  WTLStickerPanel
//
//  Created by daarkfish on 12/13/2017.
//  Copyright (c) 2017 daarkfish. All rights reserved.
//

#import "WTLViewController.h"
#import <WTLStickerPanel/WTLStickerPanel.h>
#import <WTLSticker.h>
@interface WTLViewController ()<WTLStickerPanelDelegate, UITextViewDelegate>
@property (strong, nonatomic) IBOutlet UITextView *inputTextView;
@property (strong, nonatomic)  UIView *bottomPanel;
@property (strong, nonatomic) WTLStickerPanel *panelView;
@property (nonatomic) BOOL isShowStickerPanel;
@end

@implementation WTLViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.navigationItem.title = @"Demo";
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tappedOutside:)];
    
    [self.view addGestureRecognizer:tapGesture];
    
    self.inputTextView.delegate = self;
    NSMutableArray *temp = [NSMutableArray new];
    for (int i = 1; i < 8; i++) {
        WTLSticker *sticker = [WTLSticker new];
        sticker.StickerId = i;
        sticker.Stickercode = [NSString stringWithFormat:@"{{sticker:%d}}", i]; //{{sticker:1}}
        sticker.ImageUrl = @"https://cdn.pixabay.com/photo/2016/11/05/20/09/grooming-1801287_1280.png"; // also support gif
        [WTLStickerPanel setDelegate:self];

        [temp addObject:sticker];
    }
    
    [WTLStickerPanel setUpSickerPanelWithStickerList:temp];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)stickerButtonPressed:(id)sender {
    [self toggleStickerPanel];
}

-(void) toggleStickerPanel
{

    if(!self.isShowStickerPanel)
    {
        [self showSticker];
    }
    else
    {
        [self dismissSticker];
    }
}

#pragma mark - WTLStickerPanelDelegate
-(void) didSelectSticker:(WTLSticker *)sticker
{
    //post comment with sticker or do whatever u need for the sticker selected
    self.inputTextView.text = sticker.Stickercode;
    [self.inputTextView resignFirstResponder];
    [self dismissSticker];
}

#pragma mark - UITextViewDelegate
- (void)textViewDidBeginEditing:(UITextView *)textView
{
    [self dismissSticker];
}
- (void)textViewDidEndEditing:(UITextView *)textView
{
    [self dismissSticker];
}

#pragma mark - Others

-(void) showSticker
{
    [WTLStickerPanel showStickerPanel];
    self.isShowStickerPanel = YES;
}

-(void) dismissSticker
{
    [WTLStickerPanel dismissStickerPanel];
    self.isShowStickerPanel = NO;
}

-(void)tappedOutside:(UITapGestureRecognizer *)gesture
{
    [self.inputTextView resignFirstResponder];
}
@end
