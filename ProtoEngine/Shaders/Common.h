//
//  Common.h
//  ProtoEngine
//
//  Created by Milton Montiel on 29/08/25.
//

#ifndef Common_h
#define Common_h

#import <simd/simd.h>

typedef struct {
    matrix_float4x4 modelMatrix;
    matrix_float4x4 viewMatrix;
    matrix_float4x4 projectionMatrix;
    matrix_float3x3 normalMatrix;
} Uniforms;

typedef struct {
    uint32_t width;
    uint32_t height;
    uint32_t tiling;
    uint32_t lightCount;
    vector_float3 cameraPosition;
    float scaleFactor;
} Params;

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
