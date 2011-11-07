//
//  ViewController.m
//  GTranslateTest
//
//  Created by Kenneth Anguish on 11/7/11.
//  Copyright (c) 2011 Kenneth Anguish. All rights reserved.
//

#import "ViewController.h"
#import "ASIHTTPRequest.h"
#import "GTMNSDictionary+URLArguments.h"
#import "GTMNSString+URLArguments.h"
#define USER_AGENT_STRING @"Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10_6_7; da-dk) AppleWebKit/533.21.1 (KHTML, like Gecko) Version/5.0.5 Safari/533.21.1"

@implementation ViewController
@synthesize theTextField, theButton, queue, audioData;

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];

    // init queue
    self.queue = [[NSOperationQueue alloc] init];

    [self.theTextField becomeFirstResponder];
    
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

#pragma mark - Actions

- (IBAction)speakAction:(id)sender {
    
    NSString *googleURL = [NSString stringWithFormat: @"http://translate.google.com/translate_tts?ie=UTF-8&q=%@&tl=zh-CN&prev=input", [self.theTextField.text gtm_stringByEscapingForURLArgument]];
    
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL: [NSURL URLWithString: googleURL]];
    [request setTimeOutSeconds: 60]; 
    
    [request addRequestHeader:@"User-Agent" value: USER_AGENT_STRING];
    
    //[request setValidatesSecureCertificate:NO];	
    [request setDelegate:self];
    [request setDidFinishSelector:@selector(requestDone:)];
    [request setDidFailSelector:@selector(requestWentWrong:)];
    [request setDidReceiveDataSelector:@selector(request:didReceiveBytes:)]; 
    request.showAccurateProgress = YES;
    
    
    [self.queue addOperation:request];

    
}

- (IBAction)requestDone:(ASIHTTPRequest *)request {
    
    
    self.audioData = [request responseData];
    
    if (self.audioData != nil) {
        NSError *error;
		AVAudioPlayer *audioPlayer = [[AVAudioPlayer alloc] initWithData: self.audioData error: &error];
		audioPlayer.numberOfLoops = 0;
		
		[audioPlayer play];

    }
}

- (IBAction)requestWentWrong:(ASIHTTPRequest *)request {
    NSLog(@"Request went wrong");
}

#pragma mark - Other delegates

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

- (void)dealloc {
    [queue release], queue = nil;
    
    [super dealloc];
}

@end
