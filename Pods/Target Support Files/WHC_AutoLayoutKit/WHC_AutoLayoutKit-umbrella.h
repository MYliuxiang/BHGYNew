#ifdef __OBJC__
#import <UIKit/UIKit.h>
#else
#ifndef FOUNDATION_EXPORT
#if defined(__cplusplus)
#define FOUNDATION_EXPORT extern "C"
#else
#define FOUNDATION_EXPORT extern
#endif
#endif
#endif

#import "WHC_AutoLayout.h"
#import "UITableViewCell+WHC_AutoHeightForCell.h"
#import "CALayer+WHC_Frame.h"
#import "UIView+WHC_Frame.h"
#import "UILayoutGuide+WHC_AutoLayout.h"
#import "UIView+WHC_AutoLayout.h"
#import "WHC_StackView.h"
#import "WHC_AutoLayoutUtilities.h"

FOUNDATION_EXPORT double WHC_AutoLayoutKitVersionNumber;
FOUNDATION_EXPORT const unsigned char WHC_AutoLayoutKitVersionString[];

