/*
 //   UIFont+CustomStyles.m
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
 //
 // Description: A category on UIFont that defines custom text styles used by my application.
 // Extend this category to include other text styles appropriate for your application
 */

#import "UIFont+CustomStyles.h"

@implementation UIFont (CustomStyles)

// Defines a custom heading style
+(UIFont*)ls_preferredHeadingFont
{
       UIFont* font = NULL;
    // Get font descriptor associated with default UIFontTextStyleHeadline
    UIFontDescriptor* fontDesc = [UIFontDescriptor preferredFontDescriptorWithTextStyle:UIFontTextStyleHeadline];
    // Get its point size (This would change depending on user's text size preferences)
    CGFloat pointSize = fontDesc.pointSize;
    
    // Set the traits as appropriate (Bold, italics in this case)
    UIFontDescriptorSymbolicTraits newSymbolicTrait =  fontDesc.symbolicTraits | UIFontDescriptorTraitItalic|UIFontDescriptorTraitBold;
    
    // Create new font descriptor for your font
    UIFontDescriptor* updatedFontDesc = [fontDesc fontDescriptorByAddingAttributes:@{UIFontDescriptorTraitsAttribute:@{UIFontSymbolicTrait:[NSNumber numberWithInteger:newSymbolicTrait]}}];
    
    // Scale the default UIFontTextStyleHeadline style as appropriate
    float scale = 1.1;
    
    // Create the font with new descriptor
    font = [UIFont fontWithDescriptor:updatedFontDesc size:pointSize* scale];
    return font;
}
@end
