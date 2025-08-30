//
//  Vertex.metal
//  ProtoEngine
//
//  Created by Milton Montiel on 29/08/25.
//

#include <metal_stdlib>
using namespace metal;
#import "Shaders.h"

vertex VertexOut vertex_main(VertexIn in [[stage_in]]) {
    VertexOut out {
        .poisiton = in.position
    };
    return out;
}



