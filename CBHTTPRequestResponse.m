//
//  CBHTTPRequestResponse.m
//  CBAPI
//
//  Created by Tyler Dodge on 1/22/14.
//  Copyright (c) 2014 Clearblade. All rights reserved.
//

#import "CBHTTPRequestResponse.h"
#import "CBHTTPRequest.h"

@implementation CBHTTPRequestResponse
@synthesize request = _request;
@synthesize response = _response;
@synthesize responseData = _responseData;
@dynamic responseString;

+(instancetype)responseWithRequest:(CBHTTPRequest *)request withResponse:(NSHTTPURLResponse *)response withData:(NSData *)data {
    CBHTTPRequestResponse * newResponse = [[CBHTTPRequestResponse alloc] init];
    newResponse.request = request;
    newResponse.response = response;
    newResponse.responseData = data;
    return newResponse;
}

-(NSString *)responseString {
    return [[NSString alloc] initWithData:self.responseData encoding:NSUTF8StringEncoding];
}
-(void)setResponseString:(NSString *)responseString {
    self.responseData = [responseString dataUsingEncoding:NSUTF8StringEncoding];
}

-(NSString *)dataToString:(NSData *)data {
    return [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
}

-(NSString *)description {
    NSString * reqHeaders = [self dataToString:[NSJSONSerialization dataWithJSONObject:self.request.allHTTPHeaderFields options:0 error:NULL]];
    NSString * resHeaders = [self dataToString:[NSJSONSerialization dataWithJSONObject:self.response.allHeaderFields options:0 error:NULL]];
    return [NSString stringWithFormat:
            CB_LOG_DIVIDER @"\n"
            @"Request URL <%@>\nRequest Body <%@>\nRequest Method <%@>\nRequest Headers <%@>\n"
            @"Response Status Code <%@>\nResponse Body <%@>\nResponse Headers <%@>\n"
            CB_LOG_DIVIDER,
            self.request.URL, [self dataToString:self.request.HTTPBody],
            self.request.HTTPMethod, reqHeaders,
            @(self.response.statusCode), [self dataToString:self.responseData], resHeaders];
}

@end
