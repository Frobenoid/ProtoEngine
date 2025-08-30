//
//  Fragment.metal
//  ProtoEngine
//
//  Created by Milton Montiel on 29/08/25.
//

#include <metal_stdlib>
using namespace metal;
#import "Shaders.h"

fragment float4 fragment_main(VertexOut in [[stage_in]]) {
    return float4(0.0, 1.0, 1.0, 1.0);
}
