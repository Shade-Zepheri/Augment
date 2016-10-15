static BOOL enabled = YES;
static unsigned long long width = 750;
static unsigned long long height = 1334;
static CGSize nsize = CGSizeMake(width, height);

%hook CADisplayMode

-(void)_setWidth:(unsigned long long)arg1 height:(unsigned long long)arg2 {
  if(!enabled){
    %orig();
  }else{
    HBLogDebug(@"Set Width Ran");
    %orig(width,height);
  }
}

%end

%hook UIScreenMode

 -(CGSize)size {
   if(!enabled){
     return %orig();
   }else{
     HBLogDebug(@"CGSize Ran");
     return nsize;
   }
 }

%end
