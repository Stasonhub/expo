/**
 * Copyright (c) 2015-present, Horcrux.
 * All rights reserved.
 *
 * This source code is licensed under the MIT-style license found in the
 * LICENSE file in the root directory of this source tree.
 */
#import "ABI18_0_0RNSVGUse.h"
#import "ABI18_0_0RNSVGSymbol.h"
#import <ReactABI18_0_0/ABI18_0_0RCTLog.h>

@implementation ABI18_0_0RNSVGUse

- (void)setHref:(NSString *)href
{
    if (href == _href) {
        return;
    }
    
    [self invalidate];
    _href = href;
}


- (void)renderLayerTo:(CGContextRef)context
{
    ABI18_0_0RNSVGNode* template = [[self getSvgView] getDefinedTemplate:self.href];
    if (template) {
        [self beginTransparencyLayer:context];
        [self clip:context];
        
        if ([template isKindOfClass:[ABI18_0_0RNSVGRenderable class]]) {
            [(ABI18_0_0RNSVGRenderable*)template mergeProperties:self];
        }

        if ([template class] == [ABI18_0_0RNSVGSymbol class]) {
            ABI18_0_0RNSVGSymbol *symbol = (ABI18_0_0RNSVGSymbol*)template;
            [symbol renderSymbolTo:context width:[self relativeOnWidth:self.width] height:[self relativeOnWidth:self.height]];
        } else {
            [template renderTo:context];
        }
        
        if ([template isKindOfClass:[ABI18_0_0RNSVGRenderable class]]) {
            [(ABI18_0_0RNSVGRenderable*)template resetProperties];
        }
        
        [self endTransparencyLayer:context];
    } else if (self.href) {
        // TODO: calling yellow box here
        ABI18_0_0RCTLogWarn(@"`Use` element expected a pre-defined svg template as `href` prop, template named: %@ is not defined.", self.href);
    }
}

@end

