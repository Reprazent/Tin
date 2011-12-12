//
//  TinResponse.m
//  Tin
//
//  Created by Piet Jaspers on 13/06/11.
//  Copyright 2011 10to1. All rights reserved.
//

#import "TinResponse.h"
#import "AFJSONUtilities.h"

#import "AFHTTPClient.h"

@interface TinResponse (Private)
- (id)initWithClient:(AFHTTPClient *)_client URL:(NSURL *)_URL response:(id)_response error:(NSError *)_error;
@end

@implementation TinResponse
@synthesize client;
@synthesize URL;
@synthesize response;
@synthesize parsedResponse;
@synthesize error;

#pragma mark - Initialization

+ (id)responseWithClient:(AFHTTPClient *)_client URL:(NSURL *)_URL response:(id)_response error:(NSError *)_error {
  return [[[self alloc] initWithClient:_client URL:_URL response:_response error:_error] autorelease];
}

- (id)initWithClient:(AFHTTPClient *)_client URL:(NSURL *)_URL response:(id)_response error:(NSError *)_error {
    if(!(self = [super init])) return nil;

    self.client = _client;
    self.URL = _URL;
    self.response = _response;
    if(self.response != nil){
        self.parsedResponse = AFJSONDecode(_response, &_error);   
    }
    self.error = _error;
    
    return self;
}

#pragma mark - Utility

- (NSString *)description {
    return [NSString stringWithFormat:@"Client (%p) parsedResponse: %@ URL: %@", self, self.parsedResponse, self.URL];
}

#pragma mark - Memory

- (void)dealloc {
	self.client = nil;
    self.URL = nil;
    self.parsedResponse = nil;
    self.error = nil;
    self.response = nil;
    
    [super dealloc];
}

@end
