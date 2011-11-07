//
//  ViewController.h
//  GTranslateTest
//
//  Created by Kenneth Anguish on 11/7/11.
//  Copyright (c) 2011 Kenneth Anguish. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@interface ViewController : UIViewController {
    IBOutlet UITextView *theTextField;
    IBOutlet UIButton *theButton;
    
    NSOperationQueue *queue;
    
    NSData *audioData;
    
    AVAudioPlayer *audioPlayer;
}
@property (nonatomic, retain) IBOutlet UITextView *theTextField;
@property (nonatomic, retain) IBOutlet UIButton *theButton;
@property (nonatomic, retain) NSOperationQueue *queue;


@property (nonatomic, retain) NSData *audioData;

- (IBAction)speakAction:(id)sender;

@end
