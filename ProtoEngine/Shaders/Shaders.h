//
//  Shaders.h
//  ProtoEngine
//
//  Created by Milton Montiel on 29/08/25.
//

#ifndef Shaders_h
#define Shaders_h
#include <metal_stdlib>

struct VertexIn {
    float4 position [[attribute(0)]];
};

struct VertexOut {
    float4 poisiton [[position]];
    float2 uv;
};

#endif /* Shaders_h */
