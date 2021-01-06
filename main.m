@interface LSApplicationState : NSObject
-(bool)isValid;
@end

@interface LSApplicationProxy : NSObject
+(LSApplicationProxy*)applicationProxyForIdentifier:(NSString*)appid;
-(NSString*)applicationIdentifier;
-(LSApplicationState*)appState;
-(NSURL*)bundleURL;
-(NSURL*)containerURL;
@end

@interface LSApplicationWorkspace : NSObject
+(LSApplicationWorkspace*)defaultWorkspace;
-(NSArray <LSApplicationProxy*> *)allApplications;
@end

int main(int argc, char **argv, char **envp) {
	if (argc < 2) {
		fprintf(stderr, "Usage: %s -l | <app.id>\n", argv[0]);
		return -1;
	}
        if (strcmp(argv[1], "-l")==0) {
            NSArray *allApps = [[LSApplicationWorkspace defaultWorkspace] allApplications];
            for (LSApplicationProxy *app in allApps) {
                printf("%s : %s\n", [[app applicationIdentifier] UTF8String], [[app bundleURL] fileSystemRepresentation]);
            }
            return 0;
        }
	NSString *appid = @(argv[1]);
	LSApplicationProxy *app = [LSApplicationProxy applicationProxyForIdentifier:appid];
        LSApplicationState *appState = [app appState];
	if (![appState isValid]) {
            printf("Invalid appID\n");
            return 1;
        }
        printf("State: %s\n", [[appState description] UTF8String]);
        printf("Path: %s\n", [[app bundleURL] fileSystemRepresentation]);
        printf("Container Path: %s\n", [[app containerURL] fileSystemRepresentation]);
	return 0;
}

// vim:ft=objc
