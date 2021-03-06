#import "GeoIPTest.h"
#import "Playtomic.h"
#import "PlayerCountry.h"
#import "PResponse.h"

@implementation GeoIPTest
- (void) testLookup
{
    NSString *section = @"geoip.testLookup";
    __block BOOL done = NO;
    
    [[Playtomic GeoIP] lookup:^(PlayerCountry* country, PResponse* r){
        STAssertTrue(r.success, [NSString stringWithFormat:@"[%@] Request succeeded", section]);
        STAssertTrue(r.errorcode == 0, [NSString stringWithFormat:@"[%@] No errorcode", section]);
        STAssertTrue(country.name != Nil, [NSString stringWithFormat:@"[%@] Has country name", section]);
        STAssertTrue(country.code != Nil, [NSString stringWithFormat:@"[%@] Has country code", section]);
        done = YES;
    }];
    
    while (!done) {
        [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]];
        usleep(100000);
    }
}
@end
