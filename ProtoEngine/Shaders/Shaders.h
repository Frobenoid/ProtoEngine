//
//  Shaders.h
//  ProtoEngine
//
//  Created by Milton Montiel on 29/08/25.
//

#ifndef Shaders_h
#define Shaders_h
#include <metal_stdlib>
#include "Common.h"
using namespace metal;

struct VertexIn {
    float4 position [[attribute(0)]];
    float3 normal [[attribute(Normal)]];
    float2 uv [[attribute(UV)]];
    float3 tangent [[attribute((Tangent))]];
    float3 bitangent [[attribute(Bitangent)]];
};

struct VertexOut {
    float4 poisiton [[position]];
    float2 uv;
    float3 worldPosition;
    float3 worldNormal;
    float3 worldTangent;
    float3 worldBitangent;
};

#endif /* Shaders_h */
