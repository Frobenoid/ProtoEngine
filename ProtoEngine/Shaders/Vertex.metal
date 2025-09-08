//
//  Vertex.metal
//  ProtoEngine
//
//  Created by Milton Montiel on 29/08/25.
//

#include <metal_stdlib>
using namespace metal;
#import "Shaders.h"
#import "Common.h"

vertex VertexOut vertex_main(VertexIn in [[stage_in]],
                             constant Uniforms &uniforms [[buffer(UniformsBuffer)]]
                             ) {
    float4 worldPosition = uniforms.modelMatrix * in.position;
    float4 position = uniforms.projectionMatrix * uniforms.viewMatrix
    * uniforms.modelMatrix * in.position;
    
    VertexOut out {
        .worldPosition = worldPosition.xyz / worldPosition.w,
        .worldNormal = uniforms.normalMatrix * in.normal, 
        .poisiton = position
    };
    return out;
}



