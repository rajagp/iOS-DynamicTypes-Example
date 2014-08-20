/*
 //   LSViewController.m
 //   LSFontTest
 //
 //  Created by Priya Rajagopal
 //  Copyright (c) 2014 Lunaria Software, LLC. All rights reserved.
 //
 // Permission is hereby granted, free of charge, to any person obtaining a copy
 // of this software and associated documentation files (the "Software"), to deal
 // in the Software without restriction, including without limitation the rights
 // to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 // copies of the Software, and to permit persons to whom the Software is
 // furnished to do so, subject to the following conditions:
 //
 // The above copyright notice and this permission notice shall be included in
 // all copies or substantial portions of the Software.
 //
 // THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 // IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 // FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 // AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 // LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 // OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 // THE SOFTWARE.
 */


#import "LSViewController.h"
#import "UIFont+CustomStyles.h"

@interface LSViewController ()

@end

@implementation LSViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
      
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    // Set text heading labels
    [self setHeadingLabelText];
    
    // Add observer to handle changes to user's text size preference settings
    [self addObserversForTextSizeChanges];
}

-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    
    // remove previously registered observers
    [self removeObserverForTextSizeChanges];
}

#pragma mark - Handle text size notifications
-(void)handleTextSizeChangeNotification
{
    // Update the heading labels
    [self setHeadingLabelText];
    
    // Inform UIKit that the size of the label will likely change because of the text size changes
    [self.headingLabel invalidateIntrinsicContentSize];
    
    [self.customHeadingLabel invalidateIntrinsicContentSize];
}

#pragma mark - setTextLabels
-(void)setHeadingLabelText
{
    // Set heading Label with system heading style
    self.headingLabel.font = [UIFont preferredFontForTextStyle:UIFontTextStyleHeadline];
    
    // Adjust the bounds of label to accomodate the new text
    self.headingLabel.numberOfLines = 0;
    [self.headingLabel sizeToFit];
    
    // Set heading label with custom heading style
    self.customHeadingLabel.font = [UIFont ls_preferredHeadingFont];
    // Adjust the bounds of label to accomodate the new text
    self.customHeadingLabel.numberOfLines = 0;
    [self.customHeadingLabel sizeToFit];
    
}


#pragma mark - helpers
-(void) addObserversForTextSizeChanges
{
    if (&UIContentSizeCategoryDidChangeNotification != nil)
    {
        [[NSNotificationCenter defaultCenter]addObserverForName:UIContentSizeCategoryDidChangeNotification object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification *note) {
            [self handleTextSizeChangeNotification];
            
            
        }];
    }
    
}

-(void)removeObserverForTextSizeChanges
{
    if (&UIContentSizeCategoryDidChangeNotification != nil)
    {
        [[NSNotificationCenter defaultCenter]removeObserver:self name:UIContentSizeCategoryDidChangeNotification object:nil];
    }
}

#pragma mark - bounding rect for text
- (NSInteger)boundingHeightForString:(NSString*)str withFont:(UIFont*)font constrainedToWidth:(NSInteger)width
{
    NSInteger heightVal = 0;
    CGSize maximumLabelSize = CGSizeMake(width,CGFLOAT_MAX);
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
    
    NSDictionary* attributes = @{NSFontAttributeName:font,NSParagraphStyleAttributeName:paragraphStyle};

    NSAttributedString* tempStr = [[NSAttributedString alloc]initWithString:str attributes:attributes];
    CGRect boundRect = [tempStr boundingRectWithSize:maximumLabelSize options:NSStringDrawingUsesFontLeading|NSStringDrawingUsesLineFragmentOrigin context:nil];
    heightVal = boundRect.size.height;
    heightVal+= 10; // buffer
    return heightVal;
}

@end
