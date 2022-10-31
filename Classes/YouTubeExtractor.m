#import "YouTubeExtractor.h"

@implementation YouTubeExtractor

+ (NSDictionary *)youtubePlayerRequest :(NSString *)clientName :(NSString *)clientVersion :(NSString *)videoID {
    NSLocale *locale = [NSLocale currentLocale];
	NSString *countryCode = [locale objectForKey:NSLocaleCountryCode];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"https://www.youtube.com/youtubei/v1/player?key=AIzaSyAO_FJ2SlqU8Q4STEHLGCilw_Y9_11qcW8&prettyPrint=false"]];
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setValue:@"CONSENT=YES+" forHTTPHeaderField:@"Cookie"];
    NSString *jsonBody = [NSString stringWithFormat:@"{\"context\":{\"client\":{\"hl\":\"en\",\"gl\":\"%@\",\"clientName\":\"%@\",\"clientVersion\":\"%@\",\"playbackContext\":{\"contentPlaybackContext\":{\"signatureTimestamp\":\"sts\",\"html5Preference\":\"HTML5_PREF_WANTS\"}}}},\"contentCheckOk\":true,\"racyCheckOk\":true,\"videoId\":\"%@\"}", countryCode, clientName, clientVersion, videoID];
    [request setHTTPBody:[jsonBody dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES]];
    
    __block NSData *requestData;
    __block BOOL requestFinished = NO;
    [[[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        requestData = data;
        requestFinished = YES;
    }] resume];

    while (!requestFinished) {
        [NSThread sleepForTimeInterval:0.02];
    }

    return [NSJSONSerialization JSONObjectWithData:requestData options:0 error:nil];
}

+ (NSDictionary *)youtubeBrowseRequest :(NSString *)clientName :(NSString *)clientVersion :(NSString *)browseId :(NSString *)params {
    NSLocale *locale = [NSLocale currentLocale];
	NSString *countryCode = [locale objectForKey:NSLocaleCountryCode];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"https://www.youtube.com/youtubei/v1/browse?key=AIzaSyAO_FJ2SlqU8Q4STEHLGCilw_Y9_11qcW8&prettyPrint=false"]];
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setValue:@"CONSENT=YES+" forHTTPHeaderField:@"Cookie"];
    NSString *jsonBody = [NSString stringWithFormat:@"{\"context\":{\"client\":{\"hl\":\"en\",\"gl\":\"%@\",\"clientName\":\"%@\",\"clientVersion\":\"%@\",\"playbackContext\":{\"contentPlaybackContext\":{\"signatureTimestamp\":\"sts\",\"html5Preference\":\"HTML5_PREF_WANTS\"}}}},\"contentCheckOk\":true,\"racyCheckOk\":true,\"browseId\":\"%@\",\"params\":\"%@\"}", countryCode, clientName, clientVersion, browseId, params];
    [request setHTTPBody:[jsonBody dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES]];
    
    __block NSData *requestData;
    __block BOOL requestFinished = NO;
    [[[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        requestData = data;
        requestFinished = YES;
    }] resume];

    while (!requestFinished) {
        [NSThread sleepForTimeInterval:0.02];
    }

    return [NSJSONSerialization JSONObjectWithData:requestData options:0 error:nil];
}

+ (NSDictionary *)youtubeSearchRequest :(NSString *)clientName :(NSString *)clientVersion :(NSString *)query {
    NSLocale *locale = [NSLocale currentLocale];
	NSString *countryCode = [locale objectForKey:NSLocaleCountryCode];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"https://www.youtube.com/youtubei/v1/search?key=AIzaSyAO_FJ2SlqU8Q4STEHLGCilw_Y9_11qcW8&prettyPrint=false"]];
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setValue:@"CONSENT=YES+" forHTTPHeaderField:@"Cookie"];
    NSString *jsonBody = [NSString stringWithFormat:@"{\"context\":{\"client\":{\"hl\":\"en\",\"gl\":\"%@\",\"clientName\":\"%@\",\"clientVersion\":\"%@\",\"playbackContext\":{\"contentPlaybackContext\":{\"signatureTimestamp\":\"sts\",\"html5Preference\":\"HTML5_PREF_WANTS\"}}}},\"contentCheckOk\":true,\"racyCheckOk\":true,\"query\":\"%@\"}", countryCode, clientName, clientVersion, query];
    [request setHTTPBody:[jsonBody dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES]];
    
    __block NSData *requestData;
    __block BOOL requestFinished = NO;
    [[[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        requestData = data;
        requestFinished = YES;
    }] resume];

    while (!requestFinished) {
        [NSThread sleepForTimeInterval:0.02];
    }

    return [NSJSONSerialization JSONObjectWithData:requestData options:0 error:nil];
}

+ (NSDictionary *)returnYouTubeDislikeRequest :(NSString *)videoID {
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"https://returnyoutubedislikeapi.com/votes?videoId=%@", videoID]]];
    
    __block NSData *requestData;
    __block BOOL requestFinished = NO;
    [[[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        requestData = data;
        requestFinished = YES;
    }] resume];

    while (!requestFinished) {
        [NSThread sleepForTimeInterval:0.02];
    }

    return [NSJSONSerialization JSONObjectWithData:requestData options:0 error:nil];
}

@end