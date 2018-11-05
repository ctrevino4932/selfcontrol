//
//  SCBlockDateUtilities+HelperTools.m
//  SelfControl
//
//  Created by Charles Stigler on 07/07/2018.
//

#import "SCBlockDateUtilities+HelperTools.h"
#import "HelperCommon.h"

@implementation SCBlockDateUtilities (HelperTools)

+ (void) startDefaultsBlockWithDict:(NSDictionary*)defaultsDict forUID:(uid_t)uid {
    // sanity check duration
    NSTimeInterval duration = MAX([[defaultsDict objectForKey: @"BlockDuration"] floatValue], 0);
    
    // assume the block is starting now
    NSDate* blockEndDate = [NSDate dateWithTimeIntervalSinceNow: duration];
    
    // we always _set_ BlockEndDate, because BlockStartedDate is some legacy ish
    setDefaultsValue(@"BlockEndDate", blockEndDate, uid);
    
    // in fact, let's take the opportunity to make sure BlockStartedDate is gone-zo
    setDefaultsValue(@"BlockStartedDate", NULL, uid);
}

+ (void) removeBlockFromDefaultsForUID:(uid_t)uid {
    // remove both BlockEndDate and legacy BlockStartedDate, just in case an old version comes back and tries to read that
    NSLog(@"Setting BlockEndDate and BlockStartedDate to NULL for %d", uid);
    setDefaultsValue(@"BlockEndDate", [NSDate dateWithTimeIntervalSince1970: 0], uid);
    setDefaultsValue(@"BlockStartedDate", NULL, uid);
}

@end
