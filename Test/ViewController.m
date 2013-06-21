//
//  ViewController.m
//  Test
//
//  Created by Marty on 6/21/13.
//  Copyright (c) 2013 Marty. All rights reserved.
//

#import "ViewController.h"
#import "HeartView.h"

@interface ViewController ()

@property (strong, nonatomic) IBOutlet HeartView *heartView;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

}

- (IBAction)updateWidth:(id)sender
{
	UISlider *slider = (UISlider*)sender;
	CGRect frame = self.heartView.frame;
	frame.size.width = slider.value;
	self.heartView.frame = frame;
}

- (IBAction)updateHeight:(id)sender
{
	UISlider *slider = (UISlider*)sender;
	CGRect frame = self.heartView.frame;
	frame.size.height = slider.value;
	self.heartView.frame = frame;
}

@end
