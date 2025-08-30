//
//  Common.h
//  ProtoEngine
//
//  Created by Milton Montiel on 29/08/25.
//

#ifndef Common_h
#define Common_h

#import <simd/simd.h>

typedef enum {
    Position = 0,
    Normal = 1,
    UV = 2,
    Tangent = 3,
    Bitangent = 4
} Attributes;

typedef enum {
    VertexBuffer = 0,
    UVBuffer = 1,
    TangentBuffer = 2,
    BitangentBuffer = 3,
    UniformsBuffer = 11,
    ParamsBuffer = 12,
    LightBuffer = 13,
    MaterialBuffer = 14
} BufferIndices;

typedef enum {
    BaseColor = 0,
    NormalTexture = 1,
    RoughnessTexture = 2,
    MetallicTexture = 3,
    AOTexture = 4,
} TextureIndices;

typedef struct {
    vector_float3 baseColor;
    float roughness;
    float metallic;
    float ambientOcclusion;
} Material;

#endif /* Common_h */
